Linear workflow: create a card, list my active tasks, or close a task. Intent + args in $ARGUMENTS.

Use the linear MCP tools. Default team: SDK Engineering.
Reads are free. Before any write (create/close): show what will be written, then wait for my explicit OK before doing it — never write without it.

Pick one intent from $ARGUMENTS (create | mine | close):

## create — new issue
- Strip the leading intent keyword from $ARGUMENTS; the remainder is the title. Assignee: me. Team: SDK Engineering unless another team is named.
- Description: very brief, plain text/markdown, and only if it adds something beyond the title.
- Show the proposed title, team and assignee, then wait for my explicit OK before creating. Return the identifier + URL.

## mine — my active tasks
- list_issues with assignee = me, excluding Done/Canceled (statusType done/canceled).
- Sort by priority (Urgent → Low), then by most recently updated.
- One line per issue: identifier · priority · status · title. Plain text, no table.

## close — finish a task
- Resolve the issue from $ARGUMENTS: an identifier like SDK-123, else search by title. If ambiguous — ask which one.
- Show the issue and the target state, then wait for my explicit OK before moving it to the workspace done-type state (find it via list_issue_statuses).
