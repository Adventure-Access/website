import type { APIRoute } from 'astro';
import destinations from '../data/destinations.json';
import posts from '../data/blog-posts.json';

const SITE = 'https://www.adventure-access.com';

const staticUrls = [
  { loc: '/',                                  priority: '1.0', changefreq: 'weekly'  },
  { loc: '/about/',                            priority: '0.7', changefreq: 'monthly' },
  { loc: '/transformational-travel/',          priority: '0.9', changefreq: 'monthly' },
  { loc: '/tours/',                            priority: '0.9', changefreq: 'weekly'  },
  { loc: '/blog/',                             priority: '0.9', changefreq: 'weekly'  },
  { loc: '/privacy-cookie-policy/',            priority: '0.3', changefreq: 'yearly'  },
  { loc: '/payment-terms-cancellation-policy/', priority: '0.3', changefreq: 'yearly' },
  { loc: '/thank-you/',                        priority: '0.1', changefreq: 'yearly'  },
];

export const GET: APIRoute = () => {
  const urls = [
    ...staticUrls,
    ...(destinations as any[]).map((d) => ({
      loc:        `/destinations/${d.slug}/`,
      priority:   '0.8',
      changefreq: 'monthly',
    })),
    ...(posts as any[]).map((p) => ({
      loc:        `/blog/${p.slug}/`,
      lastmod:    p.date ? p.date.slice(0, 10) : undefined,
      priority:   '0.6',
      changefreq: 'monthly',
    })),
  ];

  const xml =
    `<?xml version="1.0" encoding="UTF-8"?>\n` +
    `<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n` +
    urls
      .map((u: any) => {
        const lastmod = u.lastmod ? `    <lastmod>${u.lastmod}</lastmod>\n` : '';
        return (
          `  <url>\n` +
          `    <loc>${SITE}${u.loc}</loc>\n` +
          lastmod +
          `    <changefreq>${u.changefreq}</changefreq>\n` +
          `    <priority>${u.priority}</priority>\n` +
          `  </url>`
        );
      })
      .join('\n') +
    `\n</urlset>\n`;

  return new Response(xml, {
    headers: { 'Content-Type': 'application/xml; charset=utf-8' },
  });
};
