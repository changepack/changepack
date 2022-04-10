const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,haml,html,slim,rb}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: [...defaultTheme.fontFamily.sans],
      },
      colors: {
        orange: {
          100: '#FFFFE6',
          200: '#FFFFCD',
          300: '#FFFAB3',
          400: '#FFE099',
          500: '#FFC780',
          600: '#FFAE67',
          700: '#FF944D',
          800: '#FF7B34',
          900: '#FF611A',
        },
      },
      boxShadow: {
        'sm': '0 0.125em 0.313em rgba(50, 50, 93, .09), 0 0.063em 0.125em rgba(0, 0, 0, .07)',
        'DEFAULT': '0 0.250em 0.375em rgba(50, 50, 93, .09), 0 0.063em 0.188em rgba(0, 0, 0, .08)',
        'md': '0 0.063em 0.313em 0 rgba(0, 0, 0, .07), 0 0.438em 1.063em 0 rgba(0, 0, 0, .1)',
        'lg': '0 0.938em 2.188em rgba(50, 50, 93, .1), 0 0.313em 0.938em rgba(0, 0, 0, .07)',
        'xl': '0 0.938em 2.188em rgba(50, 50, 93, .15), 0 0.313em 0.938em rgba(0, 0, 0, .1)',
        '2xl': '0 0.938em 2.188em rgba(50, 50, 93, .30), 0 0.313em 0.938em rgba(0, 0, 0, .1)',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
