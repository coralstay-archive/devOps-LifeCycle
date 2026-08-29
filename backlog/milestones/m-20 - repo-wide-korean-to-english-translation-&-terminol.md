---
id: m-20
title: "Repo-wide Korean-to-English Translation & Terminology Sourcing"
---

## Description

Root README.md, all 36 module READMEs, all 30 scenario READMEs, and the
m-0..m-16 learning backlog (294 of 358 task files) all currently mix Korean
into what's otherwise an English-first repo -- 30 lines in the root README,
Korean sections in every module/scenario README (e.g. official-docs links,
known-constraints notes), and the entire m-0..m-16 learning curriculum's
titles/descriptions written in Korean by original design.

Goal: translate all of it to English. Quality bar, not just literal
translation -- every technical term (AWS service names, Terraform concepts,
tool names, etc.) needs to be traceable to how it's actually described in
that term's own official documentation or GitHub repo, not paraphrased from
memory. Wrap each such sourced term in single quotes at first meaningful
use per file, and note where it was sourced from (a doc link, README
section, or similar) so the sourcing is checkable later, not just asserted.

Scope note: this changes the learning backlog's original identity (an
intentionally Korean-language curriculum) to English -- confirmed
deliberately with the repo owner, not an assumption.

Too large for one sitting -- broken into Stories below, each independently
completable and re-enterable.
