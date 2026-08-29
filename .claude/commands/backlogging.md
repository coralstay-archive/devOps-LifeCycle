---
description: Turn a plan or discussion into Epic -> Story -> Task items in the backlog, using the backlog CLI only
---

Turn the following into a proper Epic -> Story -> Task structure in this repo's backlog, using the `backlog` CLI exclusively -- never hand-edit files under `backlog/` directly, per this project's established convention (see README.md's "Learning backlog" section, and milestone `m-19` for a worked example).

Source material: $ARGUMENTS

If $ARGUMENTS is empty or says something like "the plan"/"this", use the plan or design just discussed earlier in this conversation as the source material -- do not ask the user to repeat it.

Steps:
1. Run `backlog milestone list --plain` first. If an existing milestone already clearly covers this scope, reuse it instead of creating a duplicate.
2. Otherwise create one new milestone (`backlog milestone add "<name>" --description "..."`) as the Epic.
3. Break the work into Stories: `backlog task create "<title>" -m "<milestone>" --type task --desc "..."`, one per logical phase or deliverable, not per tiny step.
4. Break each Story into concrete child Tasks: `backlog task create "<title>" -p <story-id> --type task --desc "..."` -- each one a real, executable, unambiguous unit of work (not vague restatements of the story).
5. Use `--dep <task-id>` to chain stories that have a real ordering dependency (mirror how TASK-178 depends on TASK-177 in `m-19`, etc.) -- skip this when stories are genuinely independent.
6. Leave every created item in the default "To Do" status. Do not start implementing anything from the backlog as part of running this command -- backlogging is planning only.
7. Report back: the milestone ID/title, and the full Story -> Task ID tree (e.g. `TASK-177` -> `TASK-177.1`, `TASK-177.2`).

Style notes, from the `m-19` example:
- Story/task descriptions should carry real context (why, what was already confirmed/ruled out, concrete file paths) -- not generic restatements of the title.
- Prefer `--type task` for both stories and children when this is real engineering work meant to get done (matches `m-17`/`m-18`/`m-19`). Only use `--type spike` for genuinely conceptual/learning-oriented parent stories, matching the existing `m-0`..`m-16` convention -- don't mix the two styles within one milestone without a clear reason.
