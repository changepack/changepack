const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.rb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  corePlugins: {
    container: false
  },
  theme: {
    extend: {
      fontFamily: {
        sans: [...defaultTheme.fontFamily.sans],
      },
      fontSize: {
        xs: ['0.75rem', '1.38'],
        sm: ['0.875rem', '1.61'],
        base: ['1rem', '1.84'],
        lg: ['1.125rem', '2.07'],
        xl: ['1.25rem', '2.3'],
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
    function ({ addComponents }) {
      addComponents({
        '.container': {
          maxWidth: '100%',
          '@screen sm': {
            maxWidth: '640px',
          },
          '@screen md': {
            maxWidth: '768px',
          },
          '@screen lg': {
            maxWidth: '1024px',
          },
          '@screen xl': {
            maxWidth: '1024px',
          }
        }
      })
    }
  ]
}
