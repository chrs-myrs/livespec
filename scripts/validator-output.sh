#!/usr/bin/env bash
# validator-output.sh — The --json document shared by LiveSpec validators
#
# Sourced, never run, and only when --json is requested:
#   vo_init <validator>                     after any cd; silences text output
#   vo_finding <severity> <rule> <path> <subject> <message>
# The document is written to the original stdout when the validator exits.
#
# Specifies: specs/artifacts/validators/validator-output.spec.md
# Contract:  specs/interfaces/formats/validator-output.spec.md
#
# Bash 3.2 compatible (macOS ships it): no associative arrays.

VO_SCHEMA_VERSION=1
VO_LINES=()

# Release this validator came from: its own vendored stamp, then the
# toolchain's project.yaml beside it.
_vo_version() {
    local v dir
    v="$(grep -m1 '^# source-version: ' "$1" 2>/dev/null | sed 's/^# source-version: //')"
    if [[ -z "$v" ]]; then
        dir="$(cd "$(dirname "$1")" && pwd -P)"
        v="$(grep -A5 '^livespec:' "$dir/../project.yaml" 2>/dev/null | grep -m1 'version:' \
            | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
    fi
    printf '%s' "${v:-unknown}"
}

# JSON string escaping into _VO_E (no subshell per field).
_vo_esc() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    _VO_E="\"$s\""
}

# Repository-root-relative, /-separated, with . and .. segments resolved.
_vo_path() {
    local p="$1" part lead="" IFS=/
    local -a out=() parts=()
    if [[ "$p" == /* ]]; then
        # Outside the repository there is no root-relative form: keep it as given.
        if [[ -n "$_VO_TOP" && "$p" == "$_VO_TOP"/* ]]; then p="${p#"$_VO_TOP"/}"; else lead=/; fi
    else
        p="${_VO_PREFIX}${p}"
    fi
    read -ra parts <<< "$p"
    for part in ${parts[@]+"${parts[@]}"}; do
        case "$part" in
            ""|.) ;;
            ..)   (( ${#out[@]} )) && unset "out[$(( ${#out[@]} - 1 ))]" ;;
            *)    out+=("$part") ;;
        esac
    done
    if (( ${#out[@]} )); then _VO_P="$lead${out[*]}"; else _VO_P="${lead:-.}"; fi
}

vo_init() {
    VO_VALIDATOR="$1"
    VO_VERSION="$(_vo_version "${BASH_SOURCE[1]:-$0}")"
    _VO_TOP="$(git rev-parse --show-toplevel 2>/dev/null || true)"
    _VO_PREFIX="$(git rev-parse --show-prefix 2>/dev/null || true)"
    exec 3>&1 1>/dev/null
    trap _vo_emit EXIT
}

vo_finding() {
    local severity="$1" rule="$2" subject="$4" message id jid jmsg obj
    _vo_path "$3"
    # Colour codes and stray control characters never reach the document.
    message="$(printf '%s' "$5" | sed $'s/\033\\[[0-9;]*m//g' | tr -d '\000-\010\013\014\016-\037')"
    id="$rule:$_VO_P"
    [[ -n "$subject" ]] && id="$id:$subject"
    _vo_esc "$id";       jid="$_VO_E"
    _vo_esc "$message";  jmsg="$_VO_E"
    obj="{\"id\": $jid, \"rule\": "
    _vo_esc "$rule";     obj+="$_VO_E, \"severity\": "
    _vo_esc "$severity"; obj+="$_VO_E, \"path\": "
    _vo_esc "$_VO_P";    obj+="$_VO_E, \"message\": $jmsg}"
    VO_LINES+=("$jid"$'\t'"$jmsg"$'\t'"$obj")
}

_vo_emit() {
    {
        printf '{\n  "schema_version": %d,\n' "$VO_SCHEMA_VERSION"
        _vo_esc "$VO_VALIDATOR"; printf '  "validator": %s,\n' "$_VO_E"
        _vo_esc "$VO_VERSION";   printf '  "livespec_version": %s,\n' "$_VO_E"
        if (( ${#VO_LINES[@]} )); then
            printf '  "findings": [\n'
            printf '%s\n' "${VO_LINES[@]}" | LC_ALL=C sort -u | cut -f3- \
                | sed -e 's/^/    /' -e '$!s/$/,/'
            printf '  ]\n}\n'
        else
            printf '  "findings": []\n}\n'
        fi
    } >&3
}
