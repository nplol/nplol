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
            "web/css/reset.scss"
          ]
      }
    }
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

  modules: {
    autoRequire: {
      "js/app.js": ["web/js/main"]
    }
  },

  npm: {
    enabled: true
  }
};
