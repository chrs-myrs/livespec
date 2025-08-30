# Information Architecture

## Core Principle
[One sentence describing the organizing philosophy - e.g., "Progressive disclosure with task-based organization"]

## Information Hierarchy

### Level 0: Pre-Engagement
What users see before they commit to using the system

```
┌─────────────────────────────────────────┐
│          [Value Proposition]            │
│                                         │
│         [Single Key Benefit]            │
│                                         │
│         [Primary CTA]                   │
└─────────────────────────────────────────┘
```

**Content**:
- Headline: [8-10 words max]
- Subhead: [15-20 words explaining benefit]
- CTA: [2-3 word action]

**Goal**: User understands value in <5 seconds

---

### Level 1: Executive Summary (Default View)
First screen after engagement - enables immediate action

```
┌─────────────────────────────────────────┐
│ [Status/Summary Bar]                    │
│ ┌─────────────────────────────────────┐ │
│ │ Primary Metric: [Value]             │ │
│ │ Status: [Good/Warning/Alert]        │ │
│ └─────────────────────────────────────┘ │
│                                         │
│ [Top Actions] (max 5)                   │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐│
│ │ Action 1 │ │ Action 2 │ │ Action 3 ││
│ │ [Impact] │ │ [Impact] │ │ [Impact] ││
│ └──────────┘ └──────────┘ └──────────┘│
│                                         │
│ [More Options ▼]                        │
└─────────────────────────────────────────┘
```

**Information Shown**:
- **Always Visible**: [List 3-5 items max]
- **One Click Away**: [Secondary information]
- **Hidden**: [Rarely needed details]

**Cognitive Load**: Low - Single decision point

---

### Level 2: Grouped Details
Expanded view showing categorized information

```
┌─────────────────────────────────────────┐
│ [Category 1 Name]                    ▼ │
│ ┌─────────────────────────────────────┐ │
│ │ • Item with context      [Action]  │ │
│ │ • Item with context      [Action]  │ │
│ │ • Item with context      [Action]  │ │
│ └─────────────────────────────────────┘ │
│                                         │
│ [Category 2 Name]                    ▶ │
│                                         │
│ [Category 3 Name]                    ▶ │
└─────────────────────────────────────────┘
```

**Grouping Logic**:
- **By User Mental Model**: [How users think about it]
- **Not By**: [System architecture/Database structure]

**Categories**:
1. [Category Name]: [What it contains] (Usually [X] items)
2. [Category Name]: [What it contains] (Usually [Y] items)
3. [Category Name]: [What it contains] (Usually [Z] items)

---

### Level 3: Full Details
Complete information for power users

```
┌─────────────────────────────────────────┐
│ [Filters] [Sort] [View Options] [Export]│
├─────────────────────────────────────────┤
│ Column1    Column2    Column3   Actions │
├─────────────────────────────────────────┤
│ Data       Data       Data      [...] │
│ Data       Data       Data      [...] │
│ Data       Data       Data      [...] │
├─────────────────────────────────────────┤
│ [◀ Prev] Page 1 of X [Next ▶]         │
└─────────────────────────────────────────┘
```

**Access Method**: Deliberate choice - not default
**Use Case**: [When users need this level]
**Percentage of Users**: ~[X]%

---

## Navigation Structure

### Primary Navigation
Top-level sections based on user tasks

```
[Logo/Home] | [Task 1] | [Task 2] | [Task 3] | [User Menu]
```

**Sections**:
1. **[Section Name]**: [User goal it serves]
2. **[Section Name]**: [User goal it serves]
3. **[Section Name]**: [User goal it serves]

**Not Included**: [What's deliberately not in main nav and why]

### Secondary Navigation
Contextual navigation within sections

```
Current Section
├── Subsection 1
│   ├── Option A
│   └── Option B
├── Subsection 2
└── Subsection 3
```

### Utility Navigation
Always accessible tools

**Location**: [Top right/Bottom bar/Floating]
- [Search]: [Global/Contextual]
- [Help]: [Documentation/Chat/Tutorial]
- [Settings]: [User preferences]
- [Profile]: [Account management]

---

## Content Organization Patterns

### Card-Based Layout
For scannable, action-oriented content

```
┌─────────┐ ┌─────────┐ ┌─────────┐
│ Card    │ │ Card    │ │ Card    │
│ ┌─────┐ │ │ ┌─────┐ │ │ ┌─────┐ │
│ │Image│ │ │ │Image│ │ │ │Image│ │
│ └─────┘ │ │ └─────┘ │ │ └─────┘ │
│ Title   │ │ Title   │ │ Title   │
│ Detail  │ │ Detail  │ │ Detail  │
│[Action] │ │[Action] │ │[Action] │
└─────────┘ └─────────┘ └─────────┘
```

**When to Use**: [Multiple equal options]
**Cards per Row**: Mobile: 1, Tablet: 2, Desktop: 3-4

### List-Based Layout
For detailed, comparative content

```
┌─────────────────────────────────────┐
│ □ Item Name          Status    [...] │
│   Additional context information    │
├─────────────────────────────────────┤
│ □ Item Name          Status    [...] │
│   Additional context information    │
└─────────────────────────────────────┘
```

**When to Use**: [Need to compare/scan many items]
**Density**: [Compact/Comfortable/Spacious]

### Dashboard Layout
For monitoring and quick actions

```
┌─────────────┬─────────────┬─────────┐
│ Key Metric  │ Key Metric  │ Alert   │
│ [Big #]     │ [Big #]     │ [!]     │
├─────────────┴─────────────┴─────────┤
│           Main Work Area             │
│                                      │
│         [Visualizations]             │
│                                      │
├──────────────────────────────────────┤
│          Quick Actions Bar           │
└──────────────────────────────────────┘
```

---

## Search & Discovery

### Search Strategy
- **Type**: [Global/Contextual/Both]
- **Prominence**: [Always visible/Icon/Hidden]
- **Features**: [Autocomplete/Filters/History]

### Browse Strategy
```
Browse by:
├── Category
│   └── Subcategory
│       └── Items
├── Date
│   └── Recent/Older
├── Status
│   └── Active/Completed
└── Custom Tags
```

### Filter Strategy
**Progressive Filters**:
1. Start with: [Most common filter]
2. Then show: [Additional filters]
3. Advanced: [Complex filter builder]

---

## Mobile Information Architecture

### Mobile-First Adaptations
```
Desktop → Mobile Transformation:

[Three columns] → [Single column stack]
[Hover reveals] → [Tap to expand]
[Side navigation] → [Bottom tabs]
[Multiple actions] → [Primary + menu]
```

### Mobile Navigation Pattern
```
┌─────────────────────────┐
│ ☰  Screen Title      ⋮ │ <- Header
├─────────────────────────┤
│                         │
│     Content Area        │ <- Scrollable
│                         │
├─────────────────────────┤
│ 🏠  📊  ➕  🔔  👤    │ <- Tab bar
└─────────────────────────┘
```

**Tab Priority** (left to right):
1. [Most used feature]
2. [Second priority]
3. [Primary action]
4. [Notifications]
5. [Profile/Settings]

---

## Content Prioritization

### Above the Fold
Must be visible without scrolling:
1. [Critical information]
2. [Primary action]
3. [Navigation/Orientation]

### Progressive Loading
```
Phase 1 (0-100ms): Layout structure
Phase 2 (100-300ms): Text content
Phase 3 (300ms+): Images/Media
Phase 4 (Async): Below fold content
```

### Attention Budget
**2 seconds**: [What must be understood]
**5 seconds**: [Key value communicated]
**10 seconds**: [Ready to take action]
**30 seconds**: [Full context absorbed]

---

## Wayfinding & Orientation

### Breadcrumbs
```
Home > Category > Subcategory > Current Page
```
**When to Show**: [3+ levels deep]
**Mobile**: [Collapsed/Hidden/Simplified]

### Page Titles
**Pattern**: [Context] - [Specific]
**Example**: "Settings - Notifications"

### Progress Indicators
```
Step 1 ─── Step 2 ─── Step 3 ─── Step 4
  ✓         ✓         ●         ○
         You are here ─┘
```

---

## Error States & Empty States

### Empty State Hierarchy
```
┌─────────────────────────────────────┐
│          [Friendly Icon]            │
│                                     │
│      [What's Missing]               │
│   [Why this is empty]               │
│                                     │
│   [Primary Action to Fix]           │
│   [Learn More]                      │
└─────────────────────────────────────┘
```

### Error State Hierarchy
```
┌─────────────────────────────────────┐
│ ⚠️  [What Went Wrong]               │
│                                     │
│ [Explanation in plain language]     │
│                                     │
│ What you can do:                    │
│ • [Option 1]                        │
│ • [Option 2]                        │
│                                     │
│ [Try Again] [Get Help]              │
└─────────────────────────────────────┘
```

---

## Accessibility Structure

### Landmark Regions
```html
<header> - Site header/navigation
<nav> - Navigation sections
<main> - Main content area
  <section> - Major sections
  <article> - Self-contained content
<aside> - Supplementary content
<footer> - Site footer
```

### Heading Hierarchy
```
h1: Page Title (one per page)
  h2: Major Section
    h3: Subsection
      h4: Detail level
```

### Skip Links
```
[Skip to main content]
[Skip to navigation]
[Skip to search]
```

---

## Metrics & Validation

### Success Metrics
- **Find-ability**: Users locate [feature] in <[X] clicks
- **Scan-ability**: Key info understood in <[Y] seconds
- **Learn-ability**: New users successful without help
- **Efficiency**: Power users complete tasks in <[Z] steps

### Testing Methods
- Card sorting for categories
- Tree testing for navigation
- First-click testing for actions
- 5-second test for comprehension

---

## Documentation & Maintenance

### Naming Conventions
- **Sections**: [Noun - what it contains]
- **Actions**: [Verb - what it does]
- **States**: [Adjective - current status]

### Content Guidelines
- **Labels**: [2-3 words max]
- **Descriptions**: [1 sentence, <15 words]
- **Instructions**: [Action-oriented, starts with verb]
- **Errors**: [Problem + Solution format]