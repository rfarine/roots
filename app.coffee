axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
browserify   = require 'roots-browserify'
contentful   = require 'roots-contentful'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: 'assets/css/*.styl'),
    browserify(files: "assets/js/main.coffee", out: 'js/build.js')
  ],
  [
    contentful
      access_token: 'YOUR_ACCESS_TOKEN'
      space_id: 'xxxxxx'
      content_types:
        blog_posts:
          id: 'xxxxxx'
          template: 'views/templates/_post.jade'
          filters: { 'fields.environment[in]': ['staging', 'production'] }
          path: (e) -> "blogging/#{e.category}/#{slugify(e.title)}"
        press_links:
          id: 'xxxxxx'
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true