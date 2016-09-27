exports.config = {
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },
    stylesheets: {
      joinTo: "css/style.css",
      order: {
        before: 
          [ 
            "web/css/reset.scss",
            "web/css/variables.scss"
          ]
      }
    }
  },

  conventions: {
    assets: /^(web\/static\/assets)/
  },

  paths: {
    watched: [
      "web/"
    ],

    public: "public"
  },

  plugins: {
    babel: {
      ignore: [/web\/js\/vendor/]
    }
  },

  npm: {
    enabled: true
  }
};
