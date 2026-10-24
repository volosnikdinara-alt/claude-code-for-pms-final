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

- rook-wiki and rook-database failed to connect all session (proxy 403 in the cloud session); setup check also showed GitHub not signed in. Nothing from the wiki or database has been read yet; CLAUDE.md product/people/vocab summary still to write.
- From repo code: 4.2 cut offer timeout 90s→60s and reweighted proximity 0.45→0.60, recent acceptance 0.40→0.25. offer.py scores a missed (timed-out) offer the same as a decline (−0.12 vs +0.08 for accept), and scores never decay back (2019 TODO in history.py).
- Handoff (Priya, 21 Aug) calls the dip mostly seasonal and warns against reverting 4.2; not yet checked against data. Rook Supply reads Dispatch's availability record (contract noted only in availability.py).
- Contradiction: CHANGELOG says Bulk callout (4.1) and Routing override audit log (4.0) shipped, but their briefs are still open/unowned.
- Open questions and booking messages for first meetings are in 00-rook/company/notes/first-meetings.md. Customer interviews (Module 2) not yet read.
