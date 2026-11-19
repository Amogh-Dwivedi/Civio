# Civio Contact Us (simple version)

This reverts the email form and Supabase Edge Function. The existing Contact Us sidebar entry opens a small window displaying the email address and social channels. No backend or Resend configuration is required.

## Edit contact information
Open `index.html` and search for `CIVIO_CONTACT`.

- `email`: change the public contact address. Clicking it opens the visitor's email application.
- `instagram`, `linkedin`, `whatsapp`: paste your full HTTPS social URL between the quotes. Blank values show "Coming soon" instead of a broken link.

Upload the contents of this folder to your existing GitHub Pages repository. Keep your existing configured `config.js` (the ZIP contains a template configuration), and retain your real logo in `assets/branding/logo.svg`.

All other functionality is unchanged.
