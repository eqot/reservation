gulp = require 'gulp'

$ = require('gulp-load-plugins')()

paths =
  scripts: ['*.coffee', '!gulpfile.coffee']

gulp.task 'scripts', ->
  return gulp.src paths.scripts
    .pipe $.coffee({bare: true})
    .pipe gulp.dest('dist')

gulp.task 'clean', require('del').bind null, ['dist']

gulp.task 'serve', ->
  gulp.watch paths.scripts, ['scripts']

gulp.task 'default', ['clean'], ->
  gulp.start 'serve'
