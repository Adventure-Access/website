import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import rehypeRaw from 'rehype-raw';
// NOTE: @astrojs/sitemap@3.7+ requires Astro 5's astro:routes:resolved hook;
// this project is on Astro 4.16. Re-enable when upgrading to Astro 5, or pin
// sitemap to a 3.6.x version that's still 4.x-compatible. For first deploy
// we skip auto-sitemap generation -- Netlify/Cloudflare Pages don't require it.

export default defineConfig({
  site: 'https://www.adventure-access.com',
  integrations: [
    tailwind({ applyBaseStyles: false }),
  ],
  markdown: {
    // Allow raw HTML in .md files so migrated WordPress posts render correctly.
    // New posts written via Decap CMS also benefit — editors can embed iframes, etc.
    rehypePlugins: [rehypeRaw],
  },
  build: {
    inlineStylesheets: 'auto',
  },
});
