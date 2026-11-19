# Civio About Us + Become a Provider

The original UI is unchanged. Both features use the existing popup modal.

## Required one-time setup
1. Open Supabase Dashboard > SQL Editor > New query.
2. Paste and run `supabase/provider_applications.sql`.
3. Upload the updated `index.html` to your GitHub Pages repository. Keep your current configured `config.js` and logo files.
4. Sign in with a verified account, open the sidebar, select Become a Provider, and submit a test application.
5. Open Supabase > Table Editor > `provider_applications` to review submissions. You can edit `status` there as project owner.

## What is stored
User ID, full name, phone, locality, provider category, skill description, submission time and review status. The email is available through the authenticated user's account in Supabase Authentication; it is not copied into the public table.

## Email alerts
Applications are delivered to your private Supabase dashboard, NOT automatically emailed. To receive inbox notifications, configure a server-side Supabase Database Webhook / Edge Function and an email provider such as Resend. Never put an email API key in `index.html` or `config.js`.

## Privacy and safety
Only signed-in users can submit. The table has RLS and INSERT-only grants for authenticated clients; submissions are not publicly readable. The Supabase project owner can inspect them in Table Editor. Add a privacy notice and retention policy before inviting public applicants. Supabase email verification must be enabled separately.

## Editing About Us
Search `showAboutCivio` in `index.html` and edit its text.
