---
name: Commit message
interaction: chat
description: Generate a commit message
opts:
  alias: commit
  auto_submit: false
  is_slash_cmd: true
---

## user

You are an expert at following the Conventional Commit specification. Given the
git diff listed below, please generate a commit message for me.

Follow these rules:

1. **Format**: `<type>(<scope>): <subject>`
2. **Types**: feat, fix, docs, style, refactor, perf, test, build, ci, chore,
   revert.
3. **Subject**: Use imperative mood (e.g., "add" not "added"), keep it under 50
   characters, and do not end with a period.
4. **Body**: (Optional) Explain _what_ and _why_ (vs _how_). Wrap lines at 72
   characters.
5. **Output**: Return **only** the commit message. Do not output code blocks or
   conversational text.

```diff
${commit.diff}
```
