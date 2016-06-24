exports.config = {
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },
    stylesheets: {
      joinTo: "css/app.css",
      order: {
        before: 
          [ 
            "web/static/css/util/fonts.scss",
            "web/static/css/util/reset.scss"
          ]
      }
    }
  },

  conventions: {
    assets: /^(web\/static\/assets)/
  },

  paths: {
    watched: [
      "web/static"
    ],

    public: "public"
  },

  plugins: {
    babel: {
      ignore: [/web\/static\/vendor/]
    }
  },

  npm: {
    enabled: true
  }
};
