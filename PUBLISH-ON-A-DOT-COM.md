# Publish QYRRAVO on a .com (no command line)

Payment on QYRRAVO is **money only** (arranged by email). There is no card payment.

## Easiest way: Render.com (all in the browser)
1. **Buy the domain** (qyrravo.com) at Namecheap / Cloudflare / GoDaddy.
2. **GitHub**: create a free account, click New repository (choose **Private**), then "uploading an existing file" and drag in ALL the files of this folder. Click Commit.
3. **Render.com**: sign up with GitHub > New > **Blueprint** > pick your repository. Choose the plan with a disk (Starter). The disk keeps your accounts and listings.
4. Open the service > **Environment** and paste the values from `PRIVATE-ENV-TO-PASTE.txt` (owner login, Gemini key for the help bot, APP_URL). Save. It restarts.
5. Service > **Settings > Custom Domains**: add `qyrravo.com` and `www.qyrravo.com`, then add the DNS records it shows in your domain's DNS page. HTTPS is automatic.
6. Open your site, Sign in with the owner email and password. Admin panel is at `/#/admin`.

Never upload `PRIVATE-ENV-TO-PASTE.txt` to GitHub or share it.

## Other hosts
Any host that runs Node 22 works (Railway, Fly.io, cPanel "Setup Node.js App", a VPS). Upload the folder, set the same environment variables, start command: `node server/index.js`.

## Help bot
It uses `GEMINI_API_KEY` from the Environment page. If the bot says it can't answer, the key is missing or invalid on the host.
