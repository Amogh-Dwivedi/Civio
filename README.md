# Civio: GitHub Pages + Supabase

This package preserves the original Civio HTML/CSS layout. It replaces the fake login with Supabase email/password authentication, stores hearts per account in a protected database table, and adds listings from a simple editable `services.json` file. This is a static frontend plus a hosted backend (Supabase); GitHub Pages alone cannot store user accounts.

## Set up (about 10 minutes)

1. Create a free project at https://supabase.com (free plan availability/limits may change).
2. Open **SQL Editor**, paste `supabase/setup.sql`, and run it. This creates the favourites table with row-level security.
3. In **Authentication > Providers > Email**, enable email authentication and enable **Confirm email**. Configure an SMTP provider for reliable production delivery; Supabase's built-in email sender is limited and not intended for production traffic.
4. In **Authentication > URL Configuration**, set **Site URL** to your exact GitHub Pages URL, e.g. `https://USERNAME.github.io/civio/`, and add the same URL to allowed **Redirect URLs**. If testing locally, also add `http://localhost:8000/`.
5. In **Project Settings > API Keys** (or Connect), copy your project URL and **publishable** (or legacy **anon**) key into `config.js`. The public key is safe in frontend code *only because* the database has RLS. NEVER use the secret/service_role key.
6. Upload `index.html`, `config.js`, `services.json`, `assets/`, and `supabase/` to your GitHub repository, keeping the folder structure. Enable GitHub Pages from Settings > Pages > Deploy from main branch root.
7. Open the published site, create an account, click the email verification link, sign in, save a heart, sign out and sign back in. The heart should still be saved.

## Local testing

Run `python -m http.server 8000` from the project folder, then visit `http://localhost:8000/`. Opening the HTML directly with `file://` may prevent fetching `services.json` and break email redirect handling.

## Add a new listing

Open `services.json`. Copy an object, insert a comma between objects, and change `id`, `category`, `title`, `seller`, `price`, and `images`. The `id` must be unique and should NEVER change after users start favouriting it. Categories: `food`, `handicraft`, `tutor`. Put image files in `assets/services/` and list the filenames in `images`. Example:

```json
{
  "id": "craft-handmade-candle-001",
  "category": "handicraft",
  "title": "Handmade Soy Candle",
  "seller": "Civio Crafts",
  "price": 299,
  "distance_km": 2,
  "rating": 4.9,
  "review_count": 3,
  "emoji": "🕯️",
  "images": ["candle-front.jpg", "candle-side.jpg"]
}
```

Commit the updated JSON and image files to GitHub. Once Pages deploys (and the browser reloads), the new service appears. The provided sample is a placeholder. The old demo listings are intentionally retained unchanged. To remove an old demo listing, remove its card from `index.html` manually.

## Email verification

Supabase sends a verification link to the entered email address. This verifies control of the inbox, not the user's real-world identity. Configure SMTP and anti-abuse protections before accepting public registrations. Password reset emails use the same sender.

## What is live, what is not

Live: signup, email confirmation, login, persistent session, logout, reset-password email, per-account saved services, editable listings and images. Existing shopping checkout, tutoring bookings, video lessons, reviews and contact forms remain demos unless separately connected. The account UI is intentionally unchanged.

## Security and maintenance

- Never commit Supabase secret/service_role keys or actual user credentials.
- Row-level security protects users' favourites from other accounts.
- Set a custom SMTP provider and email rate limits / CAPTCHA in Supabase Auth before public launch.
- Use only trusted admins to edit `services.json` and upload images; do not accept arbitrary file uploads through this static site.
- Back up your Supabase data periodically. A static GitHub repo cannot back up account data.
- The old `index.html` has prototype text and nonfunctional checkout/booking controls; don't claim they process payments or create meetings.

## Change the Civio logo and browser tab icon

Replace `assets/branding/logo.svg` with your own logo (keep the same filename). This one file is used for the login screen, header, sidebar, and favicon/browser tab. The included image is a temporary placeholder, not your official Civio logo. If your actual logo is PNG, change the image paths in `index.html` and the favicon `type` to `image/png`.

The round account button now shows the first letter of the signed-in user's full name (from Supabase metadata), or `G` for Guest. No profile image file is required.

## About Us / Provider Applications
See `PROVIDER_SETUP.md` and run `supabase/provider_applications.sql` before accepting applications.
