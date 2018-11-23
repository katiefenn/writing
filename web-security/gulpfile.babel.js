var gulp = require('gulp');
var markdown = require('gulp-markdown');
var include = require("gulp-include");
var plugin = require('./lib/jsx-template');
var Template = require('./lib/template').default

gulp.task('default', function() {
  return gulp.src('manuscript.md')
      .pipe(include())
      .pipe(markdown())
      .pipe(plugin(Template, {}))
      .pipe(gulp.dest('./'));
});
