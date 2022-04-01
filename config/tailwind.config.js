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
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        primary: '#ff611a',
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
