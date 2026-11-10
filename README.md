# QYRRAVO — Quietly better

An international multi-vendor marketplace: sellers list real items, moderators review the listing photos (plus a one-time code photographed next to the item) before anything goes public, buyers pay through a payment provider, and every money movement is recorded in a ledger.

**Status: working build in TEST MODE.** Payments use a built-in simulator. No real money moves. Nothing here is ready for real customers until the items in `docs/LEGAL-CHECKLIST.md` and `docs/PAYMENTS.md` are done.

## Run it (2 minutes)
Needs Node 22.13+ and nothing else (zero npm dependencies; SQLite is built into Node).
```
cp .env.example .env
npm start                       # http://localhost:3000
node scripts/create-admin.js you@example.com admin     # admin/moderator accounts can only be made from the server
npm test                        # 51 backend tests
# or, without the folder: put qyrravo.js anywhere and run  node qyrravo.js   (one file; unpacks itself on first start)
```
Browser test: `NODE_PATH=<dir containing playwright> node --disable-warning=ExperimentalWarning e2e/run.js` (51 checks incl. front/back camera, screenshots incl. mobile).

## What is built
- Accounts, email verification, password reset, sessions (hashed tokens, CSRF, rate limits, lockout). Roles: visitor, buyer, seller, moderator, admin — enforced on the server.
- Seller onboarding, multi-step listing form (draft, preview, validation, upload progress, duplicate-submit protection, edit/delete, status).
- Photo review: server-generated expiring code tied to seller + listing; moderator queue (approve / reject / request more info / flag / history); every decision logged. Only approved listings are public. The UI says what this does **not** prove (ownership, authenticity, honesty).
- Safe images: JPEG/PNG/WebP by content, size/dimension limits, EXIF/GPS stripped, random names, stored outside the public folder, verification photos never public.
- Plans (all enforced in the backend, editable by admin): **Free $0 — one item for sale at a time, up to $100 · Premium $20/month — up to $10,000 · VIP $100/month — up to $100,000.** Every plan has one item for sale at a time and one unit per listing; when the item sells (or is withdrawn/rejected) the next one can be listed. Paid plans turn on only after a verified provider webhook. Upgrading Premium → VIP starts a new paid month; no downgrade mid-period.
- Camera: sellers can take listing and verification photos with the back or front camera in the browser (needs https or localhost; otherwise it opens the phone's camera app).
- Orders per seller, stock reservation, state machine, refunds, disputes, payouts (only earned money, no double payout).
- Ledger with idempotency keys; admin finance view keeps subscription income, gross orders, commission, fees, refunds, seller balances, payouts and net platform revenue separate, per currency. Pending money is never counted as income.
- Commission is configurable. **500 bps (5%) is a placeholder, flagged as such in the admin screen — you must choose the real rate.**
- Countries (all 200 in the list) and currency selection; prices are shown in the listing's own currency, with converted amounts labelled as estimates.
- Buyer side: search, filters, sort, product and seller pages, wishlist, recently viewed, compare, cart, checkout, orders, reporting listings.
- Admin/moderator screens, audit log, error log, webhook log, email outbox.

## Docs
- `docs/PAYMENTS.md` — provider research, what is/isn't implemented, how to go live
- `docs/LEGAL-CHECKLIST.md` — Qatar and general requirements, guardian note
- `docs/DEPLOY.md` — hosting, backups, env vars, external services
- `docs/LIMITATIONS.md` — known gaps. Read this.

## v3 changes
- **Buying is by email.** Buy / plan buttons open a ready-to-send email to qyrravo@gmail.com (open mail app or copy). No "test mode" text is shown.
- **Owner account.** Set `OWNER_EMAIL` and `OWNER_PASSWORD` in `.env` (never in code). On start-up the account is created as admin, named `QYRRAVO 👑`, with the logo avatar. Click/hover the 👑 anywhere to see the owner card. `#/owner` is the owner profile. Nobody else can register a name with the crown or "QYRRAVO".
- **Admin panel** (`#/admin`): Users & admins (only the owner can make/remove admins), grant plans, verify emails, suspend; All listings (edit/delete anyone's listing, logged, seller notified). Admins get VIP free.
- **Help bot** (bottom right). Built-in answers; set `ANTHROPIC_API_KEY` to make it a Claude-powered assistant that answers any question.

