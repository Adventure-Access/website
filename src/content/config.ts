import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    /** Shown in blog cards and used as the SEO meta description. Max 155 chars. */
    excerpt: z.string().optional(),
    /** Path to the hero/featured image, e.g. /images/2025/11/my-photo.jpg */
    featured_image: z.string().optional(),
    /**
     * Optionally links this post to a destination page.
     * When set, a contextual CTA block is rendered below the article
     * pointing readers to /destinations/{destination}.
     */
    destination: z.enum(['ladakh', 'nepal', 'bhutan', 'yunnan']).optional(),
    /** Optional photo gallery shown at the bottom of the post. */
    gallery: z.array(z.string()).optional(),
  }),
});

export const collections = { blog };
