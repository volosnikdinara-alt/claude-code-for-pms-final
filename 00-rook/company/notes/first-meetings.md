# First meetings — questions to ask

Roles, not names: confirm who's who against the Team directory once
rook-wiki connects. Questions are in priority order.

## Engineering manager (start here)
- [ ] How is "acceptance rate" calculated — per offer or per callout? Can you pull fill rate and time-to-fill per callout?
- [ ] Since 12 Aug, how many non-accepts were turned down vs. missed (timed out)?
- [ ] Before 4.2, what share of accepts came between 60 and 90 seconds?
- [ ] Where are acceptance scores stored in production? Do they survive restarts?
- [ ] Who decided the 4.2 numbers (weights, 60s timeout), and on what data?
- [ ] What's the process for changing `config.py`? Any review or tests?

## Staff engineer (built routing)
- [ ] Walk me through routing one callout end to end — let's write it down together.
- [ ] Your 2019 note: should scores ease back toward neutral? What would you do now?
- [ ] Is treating a timeout the same as a refusal deliberate? Still right?
- [ ] Are scores keyed by name in production, or by a unique ID?
- [ ] Why does capability count for only 15%? Should people who can't do the job be asked at all?
- [ ] What happens to responders more than 45 minutes away?

## Support lead
- [ ] What exactly are handlers complaining about since 4.2 — slow fills, wrong people, same people over and over?
- [ ] Are responders complaining too? About what?
- [ ] Can you introduce me to a responder who's gone quiet, and a handler like Kip?
- [ ] How many tickets are about console filter persistence? Is it really noise?

## Director of Product
- [ ] Which items cut from 4.2 are still Q3 commitments?
- [ ] Who owns Bulk callout and the Routing override audit log? (Changelog says shipped; briefs are open.)
- [ ] For the one-pager: what does success look like, and who decides what ships?
- [ ] Is reverting any part of 4.2 off the table?

## Rook Supply team
- [ ] Which fields of the Dispatch availability record do you rely on?
- [ ] Would a "driving / can't answer" status affect your scheduling?
- [ ] How much notice do you need before a change?

## A quiet responder
- [ ] When did you stop getting or taking callouts? Do you know why?
- [ ] What happens when an offer arrives while you're driving?

## A handler (e.g. Kip)
- [ ] Walk me through the last callout that was hard to fill — what did you wait for, what did you do?

---

## Messages to book meetings

**Engineering manager:** Hi — I'm the new PM on Dispatch. Could we grab 30 minutes this week? I'd like to understand how acceptance rate is measured and get a few numbers on 4.2 (missed vs. turned-down offers, time-to-fill).

**Staff engineer:** Hi — I'm the new Dispatch PM. Priya mentioned you're the person to learn routing from. Could we do 45 minutes for you to walk me through how a callout gets routed? I'd like to write it up with you.

**Support lead:** Hi — new Dispatch PM here. Could we set up a standing 15 minutes each week? I'd love to hear what handlers and responders are raising since 4.2.

**Director of Product:** Hi — could we find 30 minutes to go through which items cut from 4.2 are still Q3 commitments, and to align on the one-pager you asked for?

**Rook Supply:** Hi — I'm the new Dispatch PM. I understand Supply reads our availability record. Could we do 20 minutes so I know what you depend on before we change anything near it?
