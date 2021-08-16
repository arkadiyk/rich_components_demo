const colors = require("tailwindcss/colors");
const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  // mode: "jit",
  theme: {
    themeVariants: ["dark"],
  },
  darkMode: "class", // or 'media' or 'class
  theme: {
    customForms: (theme) => ({
      default: {
        "input, textarea": {
          "&::placeholder": {
            color: theme("colors.gray.400"),
          },
        },
      },
    }),
    extend: {
      typography: {
        editor: {
          css: {
            p: {
              margin: 0,
            },
          },
        },
      },
      colors: {
        primary: colors.blue,
        teal: colors.teal,
        orange: colors.orange,
        coolGray: colors.coolGray,
      },
      maxHeight: {
        xl: "36rem",
      },
      fontFamily: {
        sans: ["Inter", ...defaultTheme.fontFamily.sans],
      },
      gridTemplateColumns: {
        "post-line": "10rem auto auto auto",
      },
    },
  },
  purge: [
    "./**/*.{js,css,scss,ts}",
    "../lib/**/*.{eex,leex,sface,ex}",
    "../lib/**/*_view.ex",
    "../lib/**/views/*.ex",
    "../lib/**/components/*.ex",
    "../lib/**/live/*.ex",
  ],
  plugins: [require("@tailwindcss/forms"), require("@tailwindcss/typography")],
};
