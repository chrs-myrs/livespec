# LLM-Based Semantic Drift Detection Research Brief

## Executive Summary

This research investigates how to use LLMs to detect and resolve semantic drift between specifications and code in AI-assisted development workflows. Unlike traditional version control or programmatic code generation, we're dealing with LLM-generated code that humans then modify, requiring semantic understanding to extract intent and update specifications.

## The Real Problem

**LiveSpec v2's unique challenge:**
1. LLM reads specs → generates code
2. Human modifies code (or LLM makes changes based on new context)
3. **How do we know what changed semantically?**
4. **How do we update specs to reflect the new intent?**

This isn't:
- ❌ Diff/merge conflict resolution (we know what text changed)
- ❌ Programmatic code generation (deterministic rules)
- ❌ Real-time collaboration (simultaneous edits)

This is:
- ✅ Semantic intent extraction from code changes
- ✅ LLM-based understanding of requirement drift
- ✅ Specification update generation from code analysis
- ✅ Human-in-the-loop validation of inferred changes

## Primary Research Questions

### Critical Questions (Must Answer)

1. **How do LLMs detect semantic vs syntactic code changes?**
   - Refactoring vs new behavior
   - Implementation detail vs requirement change
   - Bug fix vs feature addition

2. **Can LLMs reliably extract specifications from code?**
   - Accuracy rates for spec extraction
   - Types of specs that work (behavior vs implementation)
   - Confidence scoring for extracted specs

3. **What's the human validation workflow?**
   - Present inferred changes for approval
   - Batch vs individual review
   - Cognitive load and decision fatigue

4. **How do we handle ambiguous changes?**
   - Multiple valid interpretations
   - Insufficient context to determine intent
   - Conflicting signals from code and specs

### Important Questions (Should Answer)

5. **What metadata improves drift detection?**
   - Git commit messages
   - PR descriptions
   - Code comments
   - Test changes

6. **How do we measure specification completeness?**
   - Are specs sufficient to regenerate code?
   - What's missing vs what's intentionally unspecified?
   - Completeness scoring

7. **What's the feedback loop pattern?**
   - How often to check for drift?
   - Continuous vs on-demand analysis?
   - Triggered by what events?

## Research Areas

### Area 1: LLM Code Understanding & Analysis

**Research Focus:**
How well can LLMs understand code semantically and extract intent?

**Key Topics:**
- Code summarization by LLMs
- Semantic code search
- Code-to-documentation generation
- Intent detection from code changes

**Systems/Papers to Investigate:**
- **GitHub Copilot** - How does it understand context from code?
- **Cursor** - How does it analyze codebase semantics?
- **Sourcegraph Cody** - Code understanding mechanisms
- **OpenAI Codex** papers - Code understanding capabilities
- **CodeBERT, GraphCodeBERT** - Code representation models
- **Academic papers** on code summarization and intent detection

**Questions:**
- What accuracy can LLMs achieve in understanding code intent?
- How do they distinguish semantic vs syntactic changes?
- What context improves understanding (tests, comments, history)?
- What are the failure modes?

**Search Terms:**
- "LLM code understanding"
- "semantic code analysis language models"
- "code intent detection"
- "specification extraction from code"
- "code summarization LLM accuracy"

### Area 2: Specification Mining & Extraction

**Research Focus:**
Extracting specifications from existing codebases automatically.

**Key Topics:**
- Specification mining from code
- Behavioral specification extraction
- Invariant detection
- Automated documentation generation

**Academic/Industry Work:**
- **Daikon** - Dynamic invariant detection
- **Specification mining research** (academic)
- **API documentation generation** from code
- **Test-to-specification** generation
- **Behavioral type inference**

**Systems to Study:**
- Tools that generate OpenAPI specs from code
- Systems that extract ADRs from code
- Documentation generators (TypeDoc, JSDoc, etc.)
- Static analysis tools that infer contracts

**Questions:**
- What types of specs can be extracted reliably?
- What's the accuracy for behavioral specs vs structural?
- How do you validate extracted specs?
- What role do tests play in extraction?

**Search Terms:**
- "specification mining from source code"
- "behavioral specification extraction"
- "automatic API documentation generation"
- "invariant detection dynamic analysis"
- "code to specification LLM"

### Area 3: Change Impact Analysis

**Research Focus:**
Understanding what changed and why, semantically.

**Key Topics:**
- Semantic diff vs syntactic diff
- Change impact analysis
- Commit message generation
- Code review automation

**Systems to Study:**
- **SemanticDiff** - Semantic code differencing
- **GitHub Copilot** - Commit message generation
- **CodeScene** - Behavioral code analysis over time
- **Conventional commits** - Structured change classification
- **Refactoring detection tools**

**Questions:**
- How do tools detect refactoring vs feature changes?
- What heuristics identify semantic equivalence?
- How accurate is LLM classification of change types?
- What metadata improves classification?

**Search Terms:**
- "semantic code diff"
- "change impact analysis LLM"
- "refactoring detection automatic"
- "commit classification semantic"
- "code change intent detection"

### Area 4: LLM-Assisted Code Review

**Research Focus:**
How LLMs help humans understand and review changes.

**Key Systems:**
- **GitHub Copilot** - PR summaries and reviews
- **Sourcery** - Automated code review suggestions
- **CodeRabbit** - AI code review assistant
- **Codium AI** - PR agent
- **Anthropic's Claude** - Code review capabilities

**Questions:**
- What makes a good AI code review?
- How do humans validate LLM insights?
- What's the false positive/negative rate?
- What workflows minimize cognitive load?

**Research:**
- Studies on AI-assisted code review
- Human-AI collaboration in code review
- Trust calibration with AI suggestions
- Cognitive load in review workflows

**Search Terms:**
- "AI code review effectiveness"
- "LLM code review accuracy"
- "human-AI collaboration code review"
- "automated code review tools evaluation"

### Area 5: Human-in-the-Loop Validation

**Research Focus:**
How to design effective human validation of AI inferences.

**Key Topics:**
- Active learning for code
- Confidence scoring for LLM outputs
- Explanability in code analysis
- Review UI/UX patterns

**Questions:**
- When should humans validate vs auto-accept?
- How to present uncertainty to users?
- What information helps validation decisions?
- How to minimize decision fatigue?

**Research Sources:**
- Human-in-the-loop ML research
- Active learning papers
- Explanability research (XAI)
- Code review UX studies

**Systems:**
- Label Studio (human-in-the-loop annotation)
- Code review tools (GitHub, GitLab UX)
- AI pair programming studies

**Search Terms:**
- "human-in-the-loop code analysis"
- "confidence scoring LLM code understanding"
- "active learning software engineering"
- "code review decision support systems"

### Area 6: Test-Driven Specification Validation

**Research Focus:**
Using tests as ground truth for specifications.

**Key Insight:**
Tests are executable specifications. If code changes but tests still pass, it might be refactoring. If tests change, requirements changed.

**Questions:**
- Can test changes indicate spec changes?
- How reliable is "tests passing" as validation?
- What about implicit requirements not tested?
- Test coverage as completeness metric?

**Research:**
- Test-driven development research
- Specification by example
- Mutation testing
- Property-based testing

**Systems:**
- Property-based testing tools (Hypothesis, QuickCheck)
- Mutation testing frameworks
- Test impact analysis tools

**Search Terms:**
- "tests as specifications"
- "specification by example"
- "test-driven development formal specifications"
- "mutation testing coverage"

## The LiveSpec v2 Specific Workflow

**Forward Flow:**
1. Human writes MSL spec
2. LLM generates code from spec
3. Tests generated/written to validate
4. Code + tests committed

**Drift Detection:**
1. Human modifies code (or LLM does based on new context)
2. **System detects** code changed
3. **LLM analyzes** semantic difference
4. **LLM infers** specification changes needed
5. **Human validates** inferred changes
6. Specs updated or change rejected

**Key Research Questions:**
- Step 3: How accurate is semantic analysis?
- Step 4: Can LLM reliably infer spec changes?
- Step 5: What's the validation UX?

## Proposed Experiments

### Experiment 1: Specification Extraction Accuracy
```markdown
**Goal**: Test LLM ability to extract specs from code

**Method**:
1. Take 20 functions with known MSL specs
2. Remove specs
3. Ask LLM to extract specs from code
4. Compare extracted vs original

**Measure**:
- Precision/recall of extracted requirements
- False positive rate (hallucinated specs)
- Completeness (missing critical specs)

**Success Criteria**: >80% accuracy on critical specs
```

### Experiment 2: Change Classification Accuracy
```markdown
**Goal**: Test LLM ability to classify code changes

**Method**:
1. Create 50 code changes:
   - 20 refactorings (no spec change)
   - 15 bug fixes (spec was wrong)
   - 15 new features (new specs needed)
2. Give LLM code before/after
3. Ask it to classify

**Measure**:
- Classification accuracy
- Confidence correlation with correctness
- Context needed for accuracy

**Success Criteria**: >85% accuracy with confidence scoring
```

### Experiment 3: Spec Update Generation
```markdown
**Goal**: Test LLM ability to generate spec updates

**Method**:
1. Start with code + spec
2. Make intentional code changes
3. Ask LLM to update spec
4. Validate spec updates

**Measure**:
- Spec update quality
- Completeness of changes
- Over-specification rate
- MSL compliance

**Success Criteria**: >75% of updates usable with minimal editing
```

### Experiment 4: Human Validation Workflow
```markdown
**Goal**: Test different validation UX patterns

**Method**:
1. Create 3 UX variants:
   - A: Show all changes, approve all
   - B: Show changes with confidence, approve low-confidence
   - C: Show only ambiguous, auto-accept high-confidence
2. Test with 10 users on 20 changes

**Measure**:
- Time to complete
- Error rate (wrong approvals)
- Cognitive load (subjective)
- User preference

**Success Criteria**: One pattern with <5% error, <2min average time
```

## Search Strategy

### Week 1: LLM Capabilities Research
**Day 1-2**: Academic literature on LLM code understanding
- arXiv papers on code models
- Benchmarks for code understanding
- Specification extraction research

**Day 3-4**: Industry implementations
- How Cursor/Copilot/Cody work
- Code review AI tools
- Documentation generation tools

**Day 5**: Synthesis
- What's proven to work?
- Accuracy expectations
- Limitations and failure modes

### Week 2: Experimental Validation
**Day 1-2**: Build test suite for experiments
**Day 3-4**: Run experiments 1-3
**Day 5**: Analyze results and document findings

## Success Criteria

This research succeeds if it provides:

1. **Validated accuracy metrics** for LLM semantic analysis
2. **Proven workflow pattern** for human validation
3. **Clear limitations** of automated extraction
4. **Decision tree** for auto-accept vs human review
5. **Go/no-go recommendation** on bidirectional sync feasibility

## Critical Insights Needed

### Must Discover
- [ ] Can LLMs extract specs accurately enough? (>80%)
- [ ] Can they classify changes reliably? (>85%)
- [ ] What confidence scoring predicts accuracy?
- [ ] What's the minimum viable validation UX?

### Should Discover
- [ ] What metadata improves accuracy?
- [ ] How do tests help validation?
- [ ] What types of specs extract well vs poorly?
- [ ] What's the performance/cost at scale?

### Nice to Have
- [ ] Fine-tuning opportunities
- [ ] Hybrid symbolic+LLM approaches
- [ ] Incremental learning patterns
- [ ] Multi-agent validation patterns

## Red Flags

Evidence that bidirectional sync may not be viable:
- **LLM spec extraction <70% accurate**
- **Change classification <75% accurate**
- **High false positive rate** in drift detection
- **No reliable confidence scoring** possible
- **Human validation too burdensome** (>5min per change)
- **Cost prohibitive** at scale (too many LLM calls)

## Alternative Approaches If Research Fails

If full bidirectional sync proves impractical:

**Plan B: Assisted Sync**
- Detect drift, flag for review
- LLM suggests updates, human writes them
- Lower accuracy acceptable with human oversight

**Plan C: One-Way with Validation**
- Specs → Code (forward only)
- Validate code against specs
- Manual spec updates when needed

**Plan D: Hybrid**
- Bidirectional for high-confidence changes
- Assisted for medium-confidence
- Manual for low-confidence

## Timeline

**Total Duration: 2 weeks**

- **Week 1**: Research and literature review
- **Week 2**: Experimental validation

**Fast track (1 week)**: Focus on experiments only, skip comprehensive literature review

## Output Deliverables

### 1. Capability Assessment
```markdown
## LLM Semantic Analysis Capabilities

**Spec Extraction**: [Accuracy %, limitations]
**Change Classification**: [Accuracy %, confusion matrix]
**Spec Generation**: [Quality %, common errors]
**Confidence Scoring**: [Correlation with accuracy]
```

### 2. Workflow Design
```markdown
## LiveSpec v2 Drift Detection Workflow

1. Trigger: [When to check]
2. Analysis: [LLM analyzes changes]
3. Classification: [Change type determination]
4. Spec Generation: [Proposed updates]
5. Human Review: [Validation UX]
6. Application: [Update specs]
```

### 3. Go/No-Go Recommendation
```markdown
## Bidirectional Sync Feasibility

**Recommendation**: [GO / NO-GO / CONDITIONAL]

**Confidence**: [High / Medium / Low]

**Reasoning**: [Evidence-based decision]

**Risks**: [What could still go wrong]

**Mitigations**: [How to address risks]
```

---

*This research brief focuses specifically on the LLM-based semantic understanding needed for LiveSpec v2's bidirectional synchronization, rather than generic sync patterns that don't apply to AI-assisted development.*