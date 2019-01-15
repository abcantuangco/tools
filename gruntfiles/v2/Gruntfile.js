module.exports = function(grunt) {
    'use strict';

    var pageJSConsolidatedMaps = {};
    var commonJSFiles = {};

    try {
        pageJSConsolidatedMaps = grunt.file.readJSON('js/mapping.json');
    } catch(e){
        // console.log(e);
    }
     try {
        commonJSFiles = grunt.file.readJSON('js/common.json');
    } catch(e){
        // console.log(e);
    }

    var JSFiles = [];

    var env = grunt.option('env') || 'dev';
    var is_page = grunt.option('page') || false;

    var getSize = function (obj) {
        if (!obj || obj === null || obj === "") {
            return 0;
        }
        if (Array.isArray()) {
            return obj.length;
        } else {
            var size = 0,
                    key;
            for (key in obj) {
                 if (obj.hasOwnProperty(key))
                         size++;
            }
            return size;
        }
    }

    var appendCommonFiles = function(mainData, toAppendData) {
        if (typeof mainData === "undefined" || typeof toAppendData === "undefined" || mainData.length <= 0)
            return;

        if (toAppendData.length > 0) {
            toAppendData.forEach(function(file){
                mainData.src.unshift(file);
            });
        }

        return mainData;
    }

    if (typeof commonJSFiles.common !== "undefined" && getSize(commonJSFiles.common) > 0) {
        commonJSFiles.common.reverse();
    }

    if (typeof pageJSConsolidatedMaps !== "undefined" && getSize(pageJSConsolidatedMaps) > 0) {
        for (var page in pageJSConsolidatedMaps) {
            if (pageJSConsolidatedMaps.hasOwnProperty(page)) {
                if (typeof commonJSFiles.common !== "undefined" && getSize(commonJSFiles.common) > 0) {
                    JSFiles.push(appendCommonFiles(pageJSConsolidatedMaps[page], commonJSFiles.common));
                } else {
                    JSFiles.push(pageJSConsolidatedMaps[page]);
                }
            }
        }
    }

    grunt.initConfig({
        uglify: {
            static_mappings: {
                files: JSFiles
            }
        },
        concat: {
            dev: {
                files: JSFiles
            }
        },
        clean: {
            css: ['css/dist/*'],
            js: ['js/dist/*']
        },
        sass: {
            dist: {
                options: {
                    sourcemap: 'none',
                    style: 'compressed',
                    noCache: true
                },
                files: [{
                     // Set to true for recursive search
                     expand: true,
                     cwd: './scss/',
                     src: ['**/*.scss'],
                     dest: 'css/dist/',
                     ext: '.css'
                 }]
            },
            dev: {
                options: {
                    sourcemap: 'none',
                    style: 'expanded',
                    trace: true,
                    lineNumbers: true,
                    update: true,
                    quiet: false
                    // debugInfo: true
                },
                files: [{
                     // Set to true for recursive search
                     expand: true,
                     cwd: './scss/',
                     src: ['**/*.scss'],
                     dest: 'css/dist/',
                     ext: '.css'
                 }]
            }
        },
        //specifying the settings for watch
        watch: {
            grunt: {
                options: {
                reload: true
                },
                files: ['Gruntfile.js']
            },
            css: {
                files: ['scss/*.scss', 'scss/**/*.scss'],
                tasks: ['sass:dev']
            },
            js: {
                files: ['js/src/**/*.js', 'js/libs/**/*.js'],
                tasks: ['concat:dev']
            }
        },
        
    });

    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-watch');

    switch(env) {
        case 'prod': {
            grunt.registerTask('build', ['clean','uglify','sass:dist']);
            grunt.registerTask('default', ['build']);
        }
        break;
        default: {
            grunt.registerTask('build', ['concat','sass:dev']);
            grunt.registerTask('default', ['build','watch']);
        }
    };
};