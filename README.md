# Adventure Access — Rebuilt Site

A refreshed, static rebuild of [www.adventure-access.com](https://www.adventure-access.com), built with [Astro](https://astro.build) + [Tailwind CSS](https://tailwindcss.com).

## Design direction

This project uses **Direction A — Editorial Mountain**. Magazine feel: Fraunces display serif + Inter body, warm cream paper background, slate ink, saffron accent. Generous whitespace, full-bleed photography, asymmetric editorial layouts.

## Run locally

You'll need [Node.js 18+](https://nodejs.org).

```bash
npm install
npm run dev          # local dev server with hot reload
# open http://localhost:4321
```

Build a static production site:

```bash
npm run build        # outputs to ./dist
npm run preview      # serve ./dist locally
```

The `dist/` folder is the deployable artifact — drop it on Netlify, Cloudflare Pages, Vercel, or any static host.

## Deploy

### Cloudflare Pages (recommended — free, global edge)
1. Push this folder to a GitHub repo.
2. In Cloudflare Pages: **Create a project → Connect to Git → pick the repo**.
3. Build command: `npm run build` · Output directory: `dist` · Node version: `18`.
4. Add your custom domain in **Custom domains**.

### Netlify
Same steps. Build: `npm run build` · Publish directory: `dist`.

## Project structure

```
src/
├── layouts/Base.astro          ← page shell (head, fonts, nav, footer)
├── components/
│   ├── Nav.astro
│   ├── Footer.astro            ← includes the inquiry form
│   ├── DestinationCard.astro
│   └── TourCard.astro
├── data/
│   ├── destinations.json       ← Ladakh, Nepal, Bhutan, Yunnan content
│   ├── tours.json              ← 17 tour itineraries from WP export
│   └── legal-pages.json        ← Privacy + Payment Terms HTML
├── pages/
│   ├── index.astro             ← Homepage
│   ├── about.astro
│   ├── transformational-travel.astro  ← Destinations hub + all itineraries
│   ├── privacy-cookie-policy.astro
│   ├── payment-terms-cancellation-policy.astro
│   ├── destinations/[slug].astro      ← One template, four destinations
│   ├── tours/[slug].astro             ← One template, 17 tours
│   └── blog/
│       ├── index.astro                ← Journal listing
│       └── [slug].astro               ← Post placeholders (see below)
└── styles/global.css
```

## What's complete

- ✅ Homepage with hero, intro, four destinations, testimonial, featured article
- ✅ Destinations hub (`/transformational-travel`) with all 4 destinations + itineraries grouped by category
- ✅ Four destination detail pages (Ladakh, Nepal, Bhutan, Yunnan) with editorial chapters, related itineraries, galleries
- ✅ 17 tour detail pages from the WordPress products export (Everest Base Camp, Annapurna, Upper Mustang, Tiger Leaping Gorge, Jade Dragon, Amdo Overland, multiple Songpan rides, etc.)
- ✅ About page with team
- ✅ Privacy + Payment Terms (real content from the export)
- ✅ Blog index with all 12+ articles as cards
- ✅ Inquiry form in the footer (currently shows a confirmation alert — wire up to your backend on launch)

## What's TODO (waiting on content)

- 🟡 **Blog post bodies.** The WP export didn't include the `post` type. Once you re-export Posts (Tools → Export → "Posts"), drop the XML in chat and the placeholder `/blog/[slug]` pages will be filled in with the real article content.
- 🟡 **Page-builder pages.** Home, About, etc. use a Redux-themed page builder that stores layout in postmeta, not the export. I've reconstructed these from the live HTML — review the copy carefully and let me know what to tweak.
- 🟡 **Custom destination CPT.** If your WP install has a `destination` post type with structured ACF fields, those didn't come through either — I reconstructed the four destination pages from the live HTML. If there's more content (FAQ, packing list, etc.) in ACF fields, an export of that CPT would let me port it.
- 🟡 **Media migration.** The site currently references images at `adventure-access.com/wp-content/uploads/...`. After you download and re-host them (e.g. via Cloudflare R2 or the project's own `public/images/` folder), do a find-and-replace in the JSON data files.
- 🟡 **Inquiry form backend.** Wire up to a Formspree / Netlify Forms / your own endpoint.

## Content editing

All content lives in plain JSON files under `src/data/`. To edit:

- **A destination's text or gallery:** edit `src/data/destinations.json`
- **A tour itinerary:** edit `src/data/tours.json`
- **Legal pages:** edit `src/data/legal-pages.json`
- **About / Homepage / Transformational Travel page copy:** edit the corresponding `.astro` file in `src/pages/`

After any edit, the dev server hot-reloads automatically.

## Design tokens

Edit `tailwind.config.mjs` to change the palette:

```js
cream: '#f5f1ea',      // page background
paper: '#ebe4d6',      // section background
ink: '#2b3540',        // primary text & dark sections
'ink-soft': '#5a6470', // secondary text
saffron: '#d97a2c',    // accent
'saffron-dark': '#b85e1a',
```

Fonts (`Fraunces` for display, `Inter` for body) come from Google Fonts and are wired up in `src/layouts/Base.astro`.
