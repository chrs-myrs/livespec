# Design User Interactions Prompt

You are tasked with designing detailed user interactions using markdown-based mockups and flow diagrams. This translates UX strategy into concrete interface designs.

## Your Mindset for Interaction Design

Before you begin, understand that you are:
- **An interaction choreographer**, designing conversational flows
- **A visual communicator**, using ASCII art and markdown effectively
- **A detail obsessor**, thinking through every click and response
- **A simplicity advocate**, removing friction at every step

## Deep Thinking Framework

### Interaction Design Decisions (THINK DEEPLY - 20+ minutes):
1. **How does each screen flow to the next?**
   - Natural progression paths?
   - Escape routes always visible?
   - Context preserved between screens?
   - Breadcrumbs or progress indicators?

2. **What does each interaction feel like?**
   - Immediate response feedback?
   - Loading state handling?
   - Error state presentation?
   - Success confirmation approach?

3. **How do we handle edge cases?**
   - Empty states?
   - Error conditions?
   - Offline scenarios?
   - Conflict resolution?

## Instructions

### Step 1: Review Foundation Documents
1. Read UX strategy from `reqs/2-strategy/ux-interaction-strategy.md`
2. Review user journeys from `reqs/0-ux/journeys/`
3. Understand system design from `reqs/3-design/`
4. Note component capabilities from `reqs/4-components/` (if exists)

### Step 2: Create Screen-by-Screen Designs

Create `reqs/3-design/interaction-flows/` directory with markdown files for each major flow:

#### Example: `main-screen-design.md`

```markdown
# Main Screen Design

## Screen Purpose
Primary entry point showing system status and available actions

## ASCII Mockup
```
╔══════════════════════════════════════════════════════════════════╗
║  [Logo] Application Name                    [?] [Settings] [User] ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  Welcome back, Sarah!                                            ║
║                                                                  ║
║  ┌────────────────────────────────────────────────────────────┐ ║
║  │                    Current Status                           │ ║
║  │                                                            │ ║
║  │  [============================          ] 75%             │ ║
║  │  375 GB used of 500 GB                                    │ ║
║  │                                                            │ ║
║  │  ⚡ Quick Action Available: Free up 50GB in 2 minutes      │ ║
║  └────────────────────────────────────────────────────────────┘ ║
║                                                                  ║
║  What would you like to do?                                     ║
║                                                                  ║
║  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐  ║
║  │                 │ │                 │ │                 │  ║
║  │  🧹 Quick Clean │ │  🔍 Deep Scan  │ │  📊 View Details│  ║
║  │                 │ │                 │ │                 │  ║
║  │  Free up space  │ │  Full analysis  │ │  See breakdown  │  ║
║  │  fast (2 min)   │ │  (5-10 min)     │ │  by file type   │  ║
║  │                 │ │                 │ │                 │  ║
║  │   [Start →]     │ │   [Start →]     │ │   [View →]      │  ║
║  └─────────────────┘ └─────────────────┘ └─────────────────┘  ║
║                                                                  ║
║  Recent Activity:                                                ║
║  • Cleaned 15GB last Tuesday                                     ║
║  • Archived old projects last month                              ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
```

## Interaction Details

### Visual Hierarchy
1. **Primary Focus**: Status bar with visual progress
2. **Secondary Focus**: Quick action prompt
3. **Tertiary Focus**: Action buttons
4. **Supporting Info**: Recent activity

### Interactive Elements

#### Progress Bar
- **Hover**: Shows exact byte count
- **Click**: Expands to show breakdown
- **Color**: Green (0-70%), Yellow (70-85%), Red (85%+)

#### Quick Action Banner
- **Auto-appears**: When significant space can be freed
- **Dismissible**: X button to hide
- **Smart**: Doesn't show same suggestion twice

#### Action Cards
- **Hover**: Subtle elevation effect (border highlight)
- **Click**: Immediate response with loading state
- **Disabled**: Grayed out with reason on hover

### Responsive Behavior

#### Desktop (>1024px)
- Full layout as shown
- Cards side by side
- Detailed recent activity

#### Tablet (768-1024px)
- Cards stack 2x1 + 1
- Condensed header
- Recent activity collapsed

#### Mobile (<768px)
- Single column
- Cards stack vertically
- Hamburger menu for settings
- Bottom navigation bar

### State Variations

#### Loading State
```
┌────────────────────────────────────────────────────────────┐
│  [════════════════                              ] 40%      │
│  Analyzing your disk... Found 2,341 files so far           │
│                                                            │
│  [Cancel]                                                  │
└────────────────────────────────────────────────────────────┘
```

#### Empty State (New User)
```
┌────────────────────────────────────────────────────────────┐
│                    👋 Welcome!                              │
│                                                            │
│  Ready to reclaim some disk space?                        │
│                                                            │
│  This tool helps you:                                      │
│  • Find large files you forgot about                      │
│  • Remove duplicate photos and documents                   │
│  • Clean up old downloads and caches                      │
│                                                            │
│         [🚀 Start First Scan]                              │
└────────────────────────────────────────────────────────────┘
```

#### Error State
```
┌────────────────────────────────────────────────────────────┐
│  ⚠️  Unable to Access Disk                                 │
│                                                            │
│  We need permission to scan your files.                   │
│                                                            │
│  [Grant Permission]  [Learn Why]                           │
└────────────────────────────────────────────────────────────┘
```
```

#### Example: `quick-clean-flow.md`

```markdown
# Quick Clean Interaction Flow

## Flow Overview
Main Screen → Scanning → Results → Confirmation → Success

## Step 1: Initiate Quick Clean
*User clicks "Quick Clean" from main screen*

### Transition
- Card expands to full screen
- Smooth animation (300ms)
- Other options fade out

## Step 2: Scanning Phase

```
╔══════════════════════════════════════════════════════════════════╗
║  🧹 Quick Clean in Progress...                             [X]   ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  Scanning for safe cleanup opportunities...                      ║
║                                                                  ║
║  [████████████████████░░░░░░░░░░░░░░░░░░░░░░░░] 45%            ║
║                                                                  ║
║  Currently checking: ~/Downloads/old-files-2019/                 ║
║                                                                  ║
║  ┌────────────────────────────────────────────────────────────┐ ║
║  │ Found so far:                                               │ ║
║  │                                                             │ ║
║  │ 📁 Old Downloads:        12.3 GB  (423 files)              │ ║
║  │ 🖼️  Duplicate Photos:     8.7 GB  (1,892 files)            │ ║
║  │ 🗑️  Trash Can:           5.2 GB  (30 days old)             │ ║
║  │ 💾 Application Caches:   3.1 GB  (15 apps)                 │ ║
║  │                                                             │ ║
║  │ Total found: 29.3 GB                                        │ ║
║  └────────────────────────────────────────────────────────────┘ ║
║                                                                  ║
║  ⏱️  Time remaining: ~45 seconds                                  ║
║                                                                  ║
║                                    [Cancel Scan]                 ║
╚══════════════════════════════════════════════════════════════════╝
```

### Interaction Notes
- Numbers update in real-time
- Progress bar smooth, not jumpy
- Cancel always available
- Categories appear as found

## Step 3: Results Presentation

```
╔══════════════════════════════════════════════════════════════════╗
║  ✅ Quick Clean Complete                                   [X]   ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  I found 47.8 GB you can safely clean up:                       ║
║                                                                  ║
║  ┌────────────────────────────────────────────────────────────┐ ║
║  │ ☑️  Old Downloads (6+ months)                               │ ║
║  │    18.5 GB • 1,247 files • Last accessed Dec 2019         │ ║
║  │    [👁️  Preview Files]                                      │ ║
║  ├────────────────────────────────────────────────────────────┤ ║
║  │ ☑️  Duplicate Photos                                        │ ║
║  │    12.3 GB • 3,421 duplicates of 1,140 photos             │ ║
║  │    Keeping organized copies, removing scattered ones       │ ║
║  │    [👁️  See Examples]                                       │ ║
║  ├────────────────────────────────────────────────────────────┤ ║
║  │ ☑️  System Caches                                           │ ║
║  │    8.7 GB • Safe temporary files                           │ ║
║  │    Will be recreated if needed                             │ ║
║  ├────────────────────────────────────────────────────────────┤ ║
║  │ ☐ Old Project Files                                        │ ║
║  │    8.3 GB • "Website Redesign 2018"                        │ ║
║  │    [👁️  Check Contents]                                     │ ║
║  └────────────────────────────────────────────────────────────┘ ║
║                                                                  ║
║  Selected: 39.5 GB                                               ║
║                                                                  ║
║  [🧹 Clean Selected]  [Customize]  [Cancel]                      ║
╚══════════════════════════════════════════════════════════════════╝
```

### Interaction Patterns
- Checkboxes: Click to toggle
- Preview: Opens detail view
- Total updates as selection changes
- Smart descriptions explain safety

## Step 4: Confirmation Dialog

```
╔══════════════════════════════════════════════════════════════════╗
║  Confirm Cleanup                                                 ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  You're about to free up 39.5 GB by removing:                   ║
║                                                                  ║
║  • 1,247 old download files                                      ║
║  • 3,421 duplicate photos                                        ║
║  • Temporary system caches                                       ║
║                                                                  ║
║  ⚠️  This action can be undone for 30 days                       ║
║                                                                  ║
║  [🗑️  Move to Trash]  [💨 Delete Permanently]  [Cancel]         ║
╚══════════════════════════════════════════════════════════════════╝
```

## Step 5: Progress & Success

### During Cleanup
```
╔══════════════════════════════════════════════════════════════════╗
║  Cleaning up your files...                                       ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  [████████████████████████████░░░░░░░░░░] 75%                   ║
║                                                                  ║
║  Moving old downloads to trash...                                ║
║  ✅ Duplicates removed (12.3 GB)                                 ║
║  ✅ Caches cleared (8.7 GB)                                      ║
║                                                                  ║
║  30.2 GB freed so far...                                         ║
╚══════════════════════════════════════════════════════════════════╝
```

### Success State
```
╔══════════════════════════════════════════════════════════════════╗
║  🎉 Cleanup Complete!                                            ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  You freed up 39.5 GB!                                           ║
║                                                                  ║
║  [====================                    ] 50%                  ║
║  250 GB used of 500 GB (was 75%)                                ║
║                                                                  ║
║  Your disk is much happier now! 😊                               ║
║                                                                  ║
║  [↩️  Undo]  [🏠 Back to Home]  [📊 See Details]                 ║
╚══════════════════════════════════════════════════════════════════╝
```

## Micro-interactions

### Button States
```
Normal:     [  Action  ]
Hover:      [ >Action< ]
Active:     [ [Action] ]
Disabled:   [  Action  ] (grayed)
Loading:    [ ⟳ ···   ]
```

### Checkbox Behavior
```
Unchecked:  ☐ Item
Hover:      ☐ Item (highlight)
Checked:    ☑️ Item
Mixed:      ☑️ Item (some selected)
```

### Transitions
- Expand/Collapse: 300ms ease-out
- Page transitions: 200ms fade
- Loading spinners: 600ms rotation
- Success checkmarks: 400ms draw
```

### Step 3: Create Component Interaction Specifications

For each UI component, create detailed interaction specs:

Create `reqs/3-design/component-interactions/button-behaviors.md`:

```markdown
# Button Component Interactions

## Primary Button
Used for main actions (Clean, Start, Confirm)

### States
```
Default:    ╔═══════════════╗
            ║   Action →    ║
            ╚═══════════════╝

Hover:      ╔═══════════════╗
            ║ > Action → <  ║ (subtle shadow)
            ╚═══════════════╝

Active:     ╔═══════════════╗
            ║ [ Action → ]  ║ (pressed in)
            ╚═══════════════╝

Loading:    ╔═══════════════╗
            ║   ⟳ Loading   ║ (spinning icon)
            ╚═══════════════╝

Disabled:   ╔═══════════════╗
            ║   Action →    ║ (50% opacity)
            ╚═══════════════╝

Success:    ╔═══════════════╗
            ║   ✓ Done!     ║ (green check)
            ╚═══════════════╝
```

### Behaviors
- Click feedback: Immediate visual response (<100ms)
- Hover tooltip: Show after 1s if disabled
- Keyboard: Enter/Space to activate
- Focus: Visible outline for accessibility
- Loading: Disable during action, show progress

## Secondary Button
Used for alternate actions (Cancel, Learn More)

### Visual Design
```
Default:    [  Action  ]    (outline only)
Hover:      [ >Action< ]    (filled background)
Active:     [[Action]]      (inverted colors)
```

## Icon Button
Compact actions with just icons

### Layout Options
```
Small:      [✕]
Medium:     [ ✕ ]
Large:      [  ✕  ]
With Text:  [ ✕ Close ]
```
```

### Step 4: Create Error Handling Patterns

Create `reqs/3-design/error-handling-patterns.md`:

```markdown
# Error Handling Interaction Patterns

## Error Display Hierarchy

### Inline Errors (Field Level)
```
Email Address:
┌─────────────────────────────┐
│ notavalidemail              │ ❌
└─────────────────────────────┘
↳ Please enter a valid email address
```

### Section Errors (Multiple Related Issues)
```
╔═══════════════════════════════════════════════╗
║ ⚠️  Cannot complete cleanup                    ║
║                                              ║
║ 2 issues need your attention:                ║
║ • Disk permissions needed for /System        ║
║ • Another cleanup is already running         ║
║                                              ║
║ [Fix Issues] [Try Anyway] [Cancel]           ║
╚═══════════════════════════════════════════════╝
```

### System Errors (Critical Failures)
```
╔═══════════════════════════════════════════════╗
║ 🔴 System Error                               ║
╠═══════════════════════════════════════════════╣
║                                              ║
║ We encountered an unexpected problem.         ║
║                                              ║
║ Error Details:                               ║
║ ┌───────────────────────────────────────┐   ║
║ │ Code: DISK_READ_FAILED                 │   ║
║ │ Time: 2024-01-20 15:32:41             │   ║
║ │ [Copy Error Details]                   │   ║
║ └───────────────────────────────────────┘   ║
║                                              ║
║ What you can try:                            ║
║ • Restart the application                    ║
║ • Check disk permissions                     ║
║ • Contact support if this persists          ║
║                                              ║
║ [Restart App] [Get Help] [Close]             ║
╚═══════════════════════════════════════════════╝
```

## Error Prevention Patterns

### Real-time Validation
```
Creating Backup Name:
┌─────────────────────────────┐
│ My Backup 2024              │ ✓ Available
└─────────────────────────────┘

┌─────────────────────────────┐
│ My/Backup:2024              │ ⚠️ Invalid characters: / :
└─────────────────────────────┘
```

### Confirmation for Destructive Actions
```
╔═══════════════════════════════════════════════╗
║ ⚠️  Permanent Deletion                         ║
╠═══════════════════════════════════════════════╣
║                                              ║
║ You're about to permanently delete:          ║
║ • 1,234 files (25.5 GB)                     ║
║                                              ║
║ This cannot be undone.                       ║
║                                              ║
║ Type DELETE to confirm:                      ║
║ ┌───────────────────────────────────────┐   ║
║ │                                       │   ║
║ └───────────────────────────────────────┘   ║
║                                              ║
║ [Cancel] [Delete Permanently]                ║
╚═══════════════════════════════════════════════╝
```

## Recovery Patterns

### Undo Notifications
```
┌─────────────────────────────────────────────────┐
│ ✅ 45 files moved to trash  [Undo] [Dismiss]   │
└─────────────────────────────────────────────────┘
(Auto-dismiss after 10 seconds)
```

### Progressive Disclosure of Solutions
```
Simple:  "Cannot connect to server" [Try Again]
         ↓ (if fails)
Medium:  "Still having trouble connecting"
         • Check internet connection
         • Try again in a few minutes
         [Try Again] [More Options]
         ↓ (if clicked)
Advanced: • Check firewall settings
         • Verify proxy configuration
         • View connection logs
         [Open Settings] [View Logs]
```
```

### Step 5: Create Responsive Design Specifications

Create `reqs/3-design/responsive-breakpoints.md`:

```markdown
# Responsive Design Specifications

## Breakpoint Strategy

### Core Breakpoints
- **Mobile**: 320px - 767px
- **Tablet**: 768px - 1023px  
- **Desktop**: 1024px - 1439px
- **Wide**: 1440px+

## Layout Adaptations

### Navigation
```
Mobile (<768px):
╔════════════════════╗
║ ☰  App Name    👤  ║
╚════════════════════╝

Tablet (768-1023px):
╔═══════════════════════════════╗
║ Logo  AppName    [?][⚙️][👤]  ║
╚═══════════════════════════════╝

Desktop (1024px+):
╔═══════════════════════════════════════════════╗
║ Logo  AppName    Home|Features|About  [?][👤] ║
╚═══════════════════════════════════════════════╝
```

### Content Cards
```
Mobile: Stack vertically, full width
┌─────────────┐
│   Card 1    │
└─────────────┘
┌─────────────┐
│   Card 2    │
└─────────────┘

Tablet: 2 columns
┌──────┐ ┌──────┐
│Card 1│ │Card 2│
└──────┘ └──────┘

Desktop: 3+ columns
┌────┐ ┌────┐ ┌────┐
│ C1 │ │ C2 │ │ C3 │
└────┘ └────┘ └────┘
```

### Touch Adaptations
- Minimum touch target: 44x44px
- Increased spacing on mobile
- Swipe gestures for navigation
- Long-press for additional options

### Information Density
```
Mobile:  Show essentials only
Tablet:  Show important + some optional
Desktop: Show all available information
```
```

## Quality Checks

Before proceeding:
- [ ] Every major flow has detailed mockups
- [ ] All states (empty, loading, error, success) designed
- [ ] Micro-interactions specified
- [ ] Responsive behavior documented
- [ ] Accessibility considered in every design
- [ ] Cognitive load actively minimized

## Remember

> "The best interface is no interface. The next best is obvious."

Every interaction should feel natural and require minimal thought. If users have to think about how to use it, redesign it.

## Next Steps

After interaction design:
1. Review with user personas in mind
2. Create interaction pattern library
3. Test flows with paper prototypes
4. Document remaining edge cases

## Update Progress Report

After completing interaction design:
1. Update `reqs/progress-report.md`:
   - Add task: `[x] Design user interactions (3b)`
   - Note number of flows designed
   - Record major interaction patterns
   - Update activity log
   - Flag any technical constraints discovered