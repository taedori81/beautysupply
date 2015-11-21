module.exports = function(grunt) {
  grunt.initConfig({

    browserSync: {
      dev: {
        bsFiles: {
          src: [
            "shop/static/oscar/css/*.css",
            "shop/static/oscar/js/*.js",
            "shop/**/*.html",
            "allbeauty/static/css/*.css",
            "allbeauty/static/js/*.js",
            "allbeauty/**/*.html"

          ]
        },
        options: {
          open: false,
          port: "3004",
          proxy: "0.0.0.0:8001",
          reloadOnRestart: true,
          watchTask: true
        }
      }
    },

    postcss: {
      options: {
        map: true,
        processors: [
          require("autoprefixer"),
          require("csswring")
        ]
      },
      prod: {
        src: [
          "shop/static/oscar/css/custom.css"
        ]
      }
    },
    less: {
      options: {
        sourceMap: true,
        includePaths: ["shop/static/oscar/less"]
      },
      dist: {
        files: {
          "shop/static/oscar/css/custom.css": "shop/static/oscar/less/custom.less",
          "shop/static/oscar/css/dashboard.css": "shop/static/oscar/less/dashboard.less"
        }
      }
    },

    watch: {
      options: {
        atBegin: true,
        interrupt: false,
        livereload: true,
        spawn: false
      },
      less: {
        files: ["shop/static/oscar/less/**/*.less"],
        tasks: ["less", "postcss"]
      }
    }
  });

  require("load-grunt-tasks")(grunt);

  grunt.registerTask("default", ["less", "postcss"]);
  grunt.registerTask("sync", ["browserSync", "watch"]);
  grunt.registerTask("heroku", ["copy", "sass", "postcss", "babel", "uglify"]);
};
