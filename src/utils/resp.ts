/**
 * Responsive image helper.
 *
 * Pre-sized variants live in /public/images/resp/<basename>-{800,1400,2000}.jpg
 * (generated from the originals at quality 78). Call respSrcset() ONLY for
 * images that have variants there — it builds the srcset string by convention.
 *
 * To add a new image: drop 800/1400/2000px JPEGs into public/images/resp/
 * following the naming pattern, then use respSrcset(originalPath) at the
 * call site.
 */
const WIDTHS = [800, 1400, 2000];

export function respSrcset(originalPath: string): string | undefined {
  const m = originalPath.match(/([^/]+)\.(jpe?g)$/i);
  if (!m) return undefined;
  const base = m[1];
  return WIDTHS.map((w) => `/images/resp/${base}-${w}.jpg ${w}w`).join(', ');
}

/** Full-bleed image: browser picks based on viewport width. */
export const SIZES_FULL = '100vw';
/** Half-width image on desktop, full-bleed on mobile. */
export const SIZES_HALF = '(min-width: 1024px) 50vw, 100vw';
