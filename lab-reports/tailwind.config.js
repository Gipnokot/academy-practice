/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/views/**/*.{html,erb,haml,slim}",
    "./app/helpers/**/*.rb",
    "./app/assets/javascripts/**/*.js",
    "./app/assets/tailwind/**/*.css"
  ],
  theme: {
    extend: {},
  },
  plugins: [require("daisyui")],
}
