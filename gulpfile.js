//var requireDir = require('require-dir');
//requireDir('./gulp/tasks', { recurse: true });

var gulp = require('gulp'),
    gutil = require('gulp-util'),
    sass = require('gulp-sass'),
    connect = require('gulp-connect'),
    autoprefixer = require('gulp-autoprefixer'),
    minifyCSS = require('gulp-minify-css'),
    sourcemaps = require('gulp-sourcemaps'),
    coffee = require('gulp-coffee');

gulp.task('lib-copy', function() {
    gulp.src('src/lib/**/*')
        .pipe(gulp.dest('target/scripts'));
});

gulp.task('coffee', function() {
    gulp.src('src/scripts/**/*.coffee')
        .pipe(coffee({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest('target/scripts'))
        .pipe(connect.reload());
});

gulp.task('sass', function(){
   return gulp.src('src/styles/**/*.scss')
       .pipe(sass())
       .pipe(autoprefixer({ browsers: ['last 2 version'] }))
       //.pipe(minifyCSS({keepBreaks:true}))
       .pipe(gulp.dest('target/styles'))
       .pipe(connect.reload());
});

gulp.task('copy-html', function() {
    return gulp.src('src/*.html')
        .pipe(gulp.dest('target'))
        .pipe(connect.reload());
});

gulp.task('copy-images', function(){
    return gulp.src('src/assets/images/**/*')
        .pipe(gulp.dest('target/assets/images'))
        .pipe(connect.reload());
});

gulp.task('watch', [], function(callback) {
    gulp.watch('src/styles/**/*.scss', ['sass']);
    gulp.watch('src/scripts/**/*.coffee', ['coffee']);
    gulp.watch('src/*.html', ['copy-html']);
    gulp.watch('src/assets/images/**/*', ['copy-images']);
});

gulp.task('connect', function() {
    connect.server({
        root: 'target',
        livereload: true
    });
});

gulp.task('default', ['lib-copy', 'coffee', 'sass', 'copy-html', 'copy-images', 'watch', 'connect']);