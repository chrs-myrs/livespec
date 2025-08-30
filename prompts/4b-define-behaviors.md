# Define User-Facing Behaviors Prompt

You are tasked with defining the user-facing behaviors of each component, focusing on what users experience rather than technical implementation. This bridges interaction design with component specifications.

## Your Mindset for Behavior Definition

Before you begin, understand that you are:
- **A behavior specifier**, defining how components act from user perspective
- **A state manager**, documenting all possible user-visible states
- **A feedback designer**, ensuring users always know what's happening
- **An edge case hunter**, finding and handling unusual scenarios

## Deep Thinking Framework

### Behavior Analysis (THINK DEEPLY - 15+ minutes per component):
1. **What states can users observe?**
   - Visual states?
   - Interaction states?
   - Data states?
   - Transition states?

2. **How does the component respond?**
   - To user actions?
   - To system events?
   - To data changes?
   - To errors?

3. **What feedback does it provide?**
   - Immediate acknowledgment?
   - Progress indication?
   - Success confirmation?
   - Error explanation?

## Instructions

### Step 1: Review Foundation
1. Read interaction designs from `reqs/3-design/interaction-flows/`
2. Review component specs from `reqs/4-components/`
3. Understand user journeys from `reqs/0-ux/journeys/`
4. Note success criteria from `reqs/1-purpose/user-success-criteria.md`

### Step 2: Create Behavior Specifications

For each component in `reqs/4-components/`, create a corresponding behavior spec:

Create `reqs/4-components/behaviors/<component-name>-behaviors.md`:

```markdown
# [Component Name] User-Facing Behaviors

## Component Purpose (User Perspective)
[What users think this component does for them]

## Observable States

### Visual States
```
Default State:
┌─────────────────────────┐
│ [Component appearance]  │
└─────────────────────────┘

Active State:
┌─────────────────────────┐
│ [Different appearance]  │
└─────────────────────────┘

Disabled State:
┌─────────────────────────┐
│ [Grayed appearance]     │
└─────────────────────────┘
```

### Data States
1. **Empty**: [How it looks with no data]
2. **Partial**: [How it looks with some data]
3. **Full**: [How it looks with complete data]
4. **Overflow**: [How it handles too much data]

### Loading States
```
Initial Load:
[────────────────          ] 30%
Loading more results...

Refreshing:
🔄 Updating... (subtle, non-blocking)

Background Sync:
↻ (small icon, no interruption)
```

## User Interactions

### Primary Actions
| User Does | Component Shows | Then What Happens |
|-----------|----------------|-------------------|
| Clicks button | Button depresses, shows loading | Action executes, shows result |
| Hovers over item | Highlight + tooltip | Ready for click |
| Starts typing | Real-time validation | Suggestions appear |
| Drags element | Ghost image follows | Drop zones highlight |

### Gesture Support
- **Click/Tap**: [Primary action]
- **Long Press**: [Secondary menu]
- **Swipe**: [Navigation/delete]
- **Pinch**: [Zoom if applicable]
- **Keyboard**: [All shortcuts]

## Feedback Patterns

### Immediate Feedback (<100ms)
```
User clicks → Visual acknowledgment
Examples:
- Button press animation
- Highlight color change  
- Micro-animation start
```

### Progress Feedback (100ms-1s)
```
Operation starting → Progress indicator
Examples:
┌─────────────────────────────┐
│ Processing your request...  │
│ [═══════════         ] 60%  │
└─────────────────────────────┘
```

### Completion Feedback
```
Success:
┌─────────────────────────────┐
│ ✅ Successfully completed!   │
│ [View Results] [Done]       │
└─────────────────────────────┘

Failure:
┌─────────────────────────────┐
│ ❌ Could not complete       │
│ [Reason why]                │
│ [Try Again] [Get Help]      │
└─────────────────────────────┘
```

## Edge Case Behaviors

### Network Issues
```
Offline Mode:
┌─────────────────────────────┐
│ 🔌 Offline - Limited Mode   │
│ Some features unavailable   │
└─────────────────────────────┘

Slow Connection:
┌─────────────────────────────┐
│ 🐌 Slow connection detected │
│ This might take longer...   │
└─────────────────────────────┘
```

### Data Edge Cases
1. **No Results**: 
   ```
   No items found matching your criteria
   [Adjust Filters] [Browse All]
   ```

2. **Too Many Results**:
   ```
   Showing 1-20 of 1,847 results
   [Load More] [Refine Search]
   ```

3. **Partial Data**:
   ```
   ⚠️ Some information unavailable
   [Shown what we have + reason]
   ```

## Accessibility Behaviors

### Keyboard Navigation
```
Tab Order:
1. [Main action]
2. [Secondary action]  
3. [Content items]
4. [Navigation]

Focus Indicators:
┌─────────────────┐
│ ┃Focused Item┃  │ (clear outline)
└─────────────────┘
```

### Screen Reader Announcements
- State changes: "Loading results"
- Completion: "5 items found"
- Errors: "Error: Email required"
- Navigation: "Page 2 of 10"

### Motion Preferences
```
prefers-reduced-motion: 
- No auto-playing animations
- Instant transitions
- Static progress indicators
```

## Responsive Behaviors

### Mobile Adaptations
- Touch targets: Minimum 44x44px
- Swipe actions: Delete, archive
- Pull to refresh: Where applicable
- Thumb-friendly: Bottom actions

### Desktop Enhancements  
- Hover states: Preview on hover
- Right-click: Context menus
- Drag & drop: File management
- Keyboard shortcuts: Power users

## Performance Behaviors

### Perceived Performance
```
Instant (<100ms):
- Button feedback
- Hover effects
- Focus changes

Fast (<1s):
- Page transitions
- Simple operations
- Local searches

Acceptable (1-3s):
- Complex operations
- Network requests
- Show progress

Long (>3s):
- Heavy processing
- Allow cancellation
- Show time remaining
```

### Progressive Loading
```
Stage 1: Structure
┌─────────┬─────────┐
│ ▫️▫️▫️▫️ │ ▫️▫️▫️▫️ │ (gray boxes)
└─────────┴─────────┘

Stage 2: Content
┌─────────┬─────────┐
│ Title   │ Title   │ (text appears)
└─────────┴─────────┘

Stage 3: Enhancement
┌─────────┬─────────┐
│ 🖼️ Full │ 🖼️ Full │ (images load)
└─────────┴─────────┘
```

## Error Recovery Behaviors

### Validation Errors
```
Inline Correction:
Email: [not.valid.email    ] ❌
       ↳ Missing @ symbol

With Suggestion:
Email: [john.doe.gmail.com ] ❌
       ↳ Did you mean john.doe@gmail.com?
       [Use Suggestion]
```

### Operation Failures
```
Graceful Degradation:
┌──────────────────────────────┐
│ ⚠️ Live sync unavailable      │
│ Working in offline mode       │
│ Changes will sync when online │
└──────────────────────────────┘

With Recovery:
┌──────────────────────────────┐
│ ❌ Upload failed              │
│ Network timeout after 30s     │
│                              │
│ [Retry] [Save Draft] [Cancel]│
└──────────────────────────────┘
```

## State Persistence

### What Gets Remembered
- User selections
- Sort preferences
- View options
- Partially completed forms
- Scroll position

### What Gets Reset
- Temporary filters
- Search queries (after success)
- Error states
- Loading states
- One-time notices

## Behavior Documentation Template

For each significant user action:
```
Action: [What user does]
Trigger: [Click/Key/Gesture]
Immediate Response: [<100ms feedback]
Processing: [What user sees during]
Success Result: [Final state]
Failure Result: [Error handling]
Undo Option: [If available]
```
```

### Step 3: Create Component Behavior Matrix

Create `reqs/4-components/behaviors/behavior-matrix.md`:

```markdown
# Component Behavior Matrix

## Interaction Standards Across Components

| Component | Click | Hover | Focus | Loading | Error | Empty |
|-----------|-------|-------|-------|---------|-------|-------|
| Button | Depress + action | Highlight | Outline | Spinner | Disabled | N/A |
| List Item | Select/Navigate | Preview | Highlight | Skeleton | Alert | "No items" |
| Input Field | Focus | Cursor change | Border | Disabled | Red border | Placeholder |
| Card | Expand/Navigate | Elevate | Border | Blur content | Error icon | "No data" |
| Modal | N/A | N/A | Trap focus | Overlay spinner | Error state | N/A |

## Timing Standards

### Feedback Timing
- Hover effects: 0ms (instant)
- Click feedback: <50ms
- Loading indicator: Show after 200ms
- Timeout warning: After 10s
- Auto-timeout: After 30s

### Animation Timing
- Micro-animations: 200ms
- Page transitions: 300ms
- Modal appearance: 250ms
- Collapse/Expand: 350ms
- Loading progress: Smooth/continuous

## Consistency Rules

### Visual Feedback Language
- **Success**: Green check ✅
- **Warning**: Yellow triangle ⚠️
- **Error**: Red circle ❌
- **Info**: Blue circle ℹ️
- **Loading**: Spinning circle ⟳

### Action Patterns
- **Primary actions**: Filled buttons, right side
- **Cancel/Back**: Text buttons, left side
- **Destructive**: Red, requires confirmation
- **Disabled**: 50% opacity, cursor not-allowed

### State Transitions
All state changes should:
1. Acknowledge trigger immediately
2. Show progress if >200ms
3. Confirm completion clearly
4. Provide next actions
5. Allow undo when possible
```

### Step 4: Create Notification Behaviors

Create `reqs/4-components/behaviors/notification-behaviors.md`:

```markdown
# Notification & Feedback Behaviors

## Notification Types

### Toast Notifications
Position: Top-right (desktop), Top (mobile)
Duration: Auto-dismiss after 5s (success), Stay (error)

```
Success Toast:
┌─────────────────────────────────┐
│ ✅ Changes saved successfully   │
│                         [✕]     │
└─────────────────────────────────┘

Error Toast:
┌─────────────────────────────────┐
│ ❌ Failed to save changes       │
│ [View Details]          [✕]     │
└─────────────────────────────────┘

Info Toast:
┌─────────────────────────────────┐
│ ℹ️ New features available       │
│ [Learn More]            [✕]     │
└─────────────────────────────────┘
```

### Inline Notifications
Appear within content flow, push content down

```
┌─────────────────────────────────────┐
│ ⚠️ Your session will expire in      │
│ 5 minutes. Save your work.          │
│ [Save Now] [Extend Session]         │
└─────────────────────────────────────┘
```

### Badge Notifications
For counts and status indicators

```
Inbox (3)  ← New items
      ●    ← Red dot for attention
    [!]    ← Important marker
```

## Notification Behaviors

### Appearance
- Slide in from edge (300ms)
- Fade in opacity (200ms)
- Push content (not overlay) for inline

### Interaction
- Click to dismiss (if dismissible)
- Click action to perform
- Swipe to dismiss (mobile)
- Escape key to dismiss all

### Stacking
```
When multiple notifications:
┌─────────────────────────┐
│ Notification 3 (newest) │
├─────────────────────────┤
│ Notification 2          │
├─────────────────────────┤
│ Notification 1 (oldest) │
└─────────────────────────┘
Max stack: 3 (older ones queue)
```

### Priority Handling
1. **Critical**: Error, data loss risk - Never auto-dismiss
2. **Important**: Warnings - Dismiss after 10s
3. **Standard**: Success, info - Dismiss after 5s
4. **Low**: Background updates - 3s or status bar only

## Sound & Haptic Feedback

### Sound Cues (if enabled)
- Success: Subtle chime
- Error: Soft buzz
- Notification: Gentle pop
- Warning: Two-tone alert

### Haptic Feedback (mobile)
- Success: Light tap
- Error: Double tap
- Long press: Strong tap
- Drag threshold: Micro tap
```

## Quality Checks

Before proceeding:
- [ ] Every component has complete behavior documentation
- [ ] All states (including edge cases) are specified
- [ ] Timing and feedback patterns are consistent
- [ ] Accessibility behaviors are defined
- [ ] Error recovery paths are clear
- [ ] Mobile adaptations are specified

## Remember

> "Users don't care about your components. They care about their tasks."

Component behaviors should be invisible when working correctly and helpful when something goes wrong. Every behavior should move users toward their goals.

## Next Steps

After defining behaviors:
1. Review behaviors against user journeys
2. Ensure consistency across components
3. Create behavior testing checklist
4. Document any technical constraints

## Update Progress Report

After completing behavior definitions:
1. Update `reqs/progress-report.md`:
   - Add task: `[x] Define user-facing behaviors (4b)`
   - Note number of components with behaviors
   - Record key behavior patterns
   - Update activity log
   - Flag any behaviors needing technical validation