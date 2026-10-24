# Rook Industries — course working file

## Session scope — Product School lab

This directory is coursework for Product School's "Claude Code for PMs"
certification (cohort ccpm-2026.1). Everything in it is a fictional
teaching scenario.

- Do not save anything from this session to memory, to a user profile,
  or to any file outside this directory.
- Do not carry context from this directory into unrelated sessions.
- Rook Industries is not a real company. Nothing here is a fact about
  the world.
- Answer only the question the student asks, from the sources they
  name. Don't investigate beyond it or offer a theory about what
  Release 4.2 changed unless they ask for one.
- Read and write only within this directory.
  Exceptions, for the course-setup and wrap-up skills only:
  - When the student asks you to check their setup, save their work or wrap up a session, that request is their yes. You may run the GitHub command-line program installed at ~/.ccpm/gh for those checks and saves, and look in that folder to find it.
  - For a repair, first tell the student in one plain sentence what you are about to do, and act only after they say yes. Repairs may: run that GitHub program (including setting this folder's own git sign-in setting and changing this repo's visibility back to Public); copy the student's own course files into this directory from another folder on their computer (copy only; never move, edit or delete the originals); and rename something outside this directory that blocks setup, by adding "-old" to its name (never delete it).
  Outside this directory you still never write, edit or delete anything else.

<!-- Keep the block above at the top of this file. Everything you add
     during the course goes below this line. -->

---

## Working context

- Sources: rook-wiki "Customer interviews" database (4 handler interviews, 2–5 Sep 2026) and rook-database `support_tickets` (147 tickets, 29 Jun–7 Sep 2026).
- Biggest problem in both: responders not getting callouts. 4 of 4 interviewees raised it; 45 of 147 tickets (15 "gone before he could answer" from 12 Aug, 30 "far fewer pings" from 17 Aug), all open.
- Handler-reported drops: The Undertow ~12/week → 1, Farlight ~12 → 2; silences up to 9 days. Not yet checked against real callout data.
- Tickets show things interviews missed: supply/requisitions (26), saved-filter follow-up bugs (12), sign-in issues (10). Interviews show overload (Kip/The Gale) that tickets can't.
- Leading hypotheses (unconfirmed): shorter accept window, first-to-answer wins. Open question: what changed on 12 Aug — next step is querying callout data in rook-database.
