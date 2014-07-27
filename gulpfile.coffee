gulp = require 'gulp'
gutil = require 'gulp-util'
fs = require 'fs'

$ = require('gulp-load-plugins')()

paths =
  scripts: ['src/*.coffee']
  html: ['src/*.html']

gulp.task 'scripts', ->
  return gulp.src paths.scripts
    .pipe($.coffee({bare: true}).on('error', gutil.log))
    .pipe gulp.dest('dist')
    .pipe $.replace '__ID__', ->
      return  (fs.readFileSync '.secret').toString().trim()
    .pipe gulp.dest('dist/secret')

gulp.task 'html', ['scripts'], ->
  return gulp.src paths.html
    .pipe $.replace '__SCRIPT__', ->
      return  (fs.readFileSync 'dist/form.js').toString().trim()
    .pipe gulp.dest('dist')

gulp.task 'clean', require('del').bind null, ['dist']

gulp.task 'serve', ->
  gulp.watch paths.scripts, ['html']
  gulp.watch paths.html, ['html']

gulp.task 'default', ['clean'], ->
  gulp.start 'serve'
