---
name: one-on-one-template
description: "Create 1:1 templates and manager updates from the signed-in user's last 14 days of Microsoft 365 and MCAPS context. Use for one-on-one prep, weekly recaps, Scott Bounds updates, RYG highlights, blockers, opportunity and milestone status, meeting follow-ups, email, calendar, Teams, document summaries, WorkIQ, MCAPSIQ, and MSX context."
argument-hint: "[optional focus such as account, opportunity, or date range]"
user-invocable: true
allowed_tools:
   - workiq
   - mcaps-iq:mcaps
   - msx
license: MIT
---

# One-on-One Template Builder

This skill prepares a concise one-on-one brief for the user's manager **Scott Bounds** (`sbounds@microsoft.com`) using the signed-in user's recent workplace context from the last 14` days.

## Defaults

- Manager: Scott Bounds (`sbounds@microsoft.com`)
- Time window: last 14 days
- Perspective: signed-in user
- Output: a concise one-on-one template in the exact format below

If the user explicitly provides a different manager, date range, or focus area, treat that as an override.

## When to Use

- Preparing a weekly 1:1 with Scott Bounds
- Turning recent activity into Red / Yellow / Green highlights
- Summarizing blockers, milestones, opportunities, and follow-ups
- Pulling together recent context from WorkIQ, MCAPSIQ, MSX, email, calendar, Teams, documents, and meeting follow-ups

## Source Priority

1. Use `workiq` first for the signed-in user's Microsoft 365 context across email, meetings, calendar, Teams messages, files, and documents.
2. Use `mcaps-iq:mcaps` for MCAPS, opportunity, milestone, account, and sales execution context.
3. Look for MSX-related context in accessible workplace sources and include it when it materially affects opportunities, milestones, customer actions, or asks.
4. Pull recent follow-ups, action items, open loops, and manager asks from meetings, chats, email threads, and documents.

If a source is unavailable because of access, EULA, auth, or missing tooling, say so plainly and continue with the sources that are available. Do not invent missing context.

## Procedure

1. Gather the signed-in user's last 14 days of evidence across Microsoft 365 and MCAPS-related sources.
2. Extract only high-signal items that are relevant for a manager one-on-one:
   - blockers, risks, dependencies, and escalation paths
   - wins, momentum, customer progress, and completed work
   - opportunities or milestones with meaningful status movement
   - follow-ups that need visibility or manager help
   - training, career development, D&I, mentoring, speaking, or other top-of-mind items
3. De-duplicate items that appear across multiple sources.
4. Rank items by urgency, impact, and whether Scott should know or act.
5. Categorize the content using these meanings:
   - **Red**: items or blockers that need immediate attention
   - **Yellow**: items that need attention or awareness
   - **Green**: items going well or showing positive momentum
   - **Opportunity/Milestone Detail**: current status of active opportunities and milestones
   - **Misc**: any other items worth discussing
6. Write concise bullets. Prefer named opportunities, milestones, owners, dates, and next steps when available.
7. Call out where Scott's help, escalation, decision, or air cover would help.
8. If a section has no meaningful evidence, write `No major items from the last 14 days.`

## Output Format

Use exactly this shape:

```markdown
Highlights:

Red:
- ...

Yellow:
- ...

Green:
- ...

Opportunity/Milestone Detail:
- ...

Misc:
- ...
```

## Quality Bar

- Use evidence from the last 14 days unless the user requests a different range.
- Summarize instead of copying long passages from emails, chats, or documents.
- Keep the final draft concise enough to review live in a 1:1.
- The manager does not need to know every detail, but should come away with a clear sense of the most important recent developments, wins, risks, and asks.
- The target duration is 20 minutes so that the last ten minutes can be spent discussing whatever additional material the manager/employee want.
- Never fabricate source material, status, or follow-up actions.
