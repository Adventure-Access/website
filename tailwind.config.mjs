/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,ts,tsx}'],
  theme: {
    extend: {
      colors: {
        cream: '#f5f1ea',
        paper: '#ebe4d6',
        ink: '#2b3540',
        'ink-soft': '#5a6470',
        saffron: '#d97a2c',
        'saffron-dark': '#b85e1a',
        rust: '#9c4a17',
      },
      fontFamily: {
        display: ['Fraunces', 'Georgia', 'serif'],
        sans: ['Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'],
      },
      letterSpacing: {
        tightest: '-0.04em',
      },
      maxWidth: {
        '8xl': '88rem',
      },
      aspectRatio: {
        '4/5': '4 / 5',
        '5/4': '5 / 4',
        '4/3': '4 / 3',
      },
    },
  },
  plugins: [],
};
