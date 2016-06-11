<?php

    function towsers_setup() {
        
        register_nav_menus( array(
            'primary' => __( 'Towsers Menu', 'towsers' )
        ) );
        add_action( 'init', 'register_nav_menus' );
        
        //STYLES
        wp_enqueue_style('main', get_template_directory_uri() . '/css/main.css');
        wp_enqueue_style('hover', get_template_directory_uri() . '/css/hover-min.css');
        
    }
    add_action( 'init', 'towsers_setup' );

    function towsers_scripts() {
        
        //Angular files
        wp_enqueue_script('angularjs', get_stylesheet_directory_uri() . '/angular-js/angular.min.js');
        wp_enqueue_script('angularjs-route', get_stylesheet_directory_uri() . '/angular-js/angular-route.min.js');
        
        //Angular app
        wp_enqueue_script('towsers-app', get_stylesheet_directory_uri() . '/angular/app.js', array('angularjs', 'angularjs-route'));
                          
        //Angular config
        wp_enqueue_script('config', get_stylesheet_directory_uri() . '/angular/config/config.js', array( 'angularjs', 'angularjs-route', 'towsers-app'));
        
        //Angular services
        wp_enqueue_script('services', get_stylesheet_directory_uri() . '/angular/services/services.js', array( 'angularjs', 'angularjs-route', 'towsers-app', 'config'));
        
        //Angular controllers
        wp_enqueue_script('index', get_stylesheet_directory_uri() . '/angular/controllers/index.js', array( 'angularjs', 'angularjs-route', 'towsers-app', 'config', 'services'));
        
        wp_enqueue_script('main', get_stylesheet_directory_uri() . '/angular/controllers/main.js', array( 'angularjs', 'angularjs-route', 'towsers-app', 'config', 'services'));
        
        wp_enqueue_script('contact', get_stylesheet_directory_uri() . '/angular/controllers/contact.js', array( 'angularjs', 'angularjs-route', 'towsers-app', 'config', 'services'));
        
        wp_enqueue_script('tourdates', get_stylesheet_directory_uri() . '/angular/controllers/tourdates.js', array( 'angularjs', 'angularjs-route', 'towsers-app', 'config', 'services'));
        
        //Angular directives
        wp_enqueue_script('directives', get_stylesheet_directory_uri() . '/angular/directives/directives.js', array( 'angularjs', 'angularjs-route', 'towsers-app', 'config'));   
        
        //PHP TO JS
        wp_localize_script(
            'config',
            'myLocalized',
            array(
                'partials' => trailingslashit( get_template_directory_uri() ) . 'angular/partials/'
                )
	    );
        
        wp_localize_script(
            'directives',
            'myLocalized',
            array(
                'partials' => trailingslashit( get_template_directory_uri() ) . 'angular/partials/'
                )
	    );
        
        wp_localize_script(
            'main',
            'myDirectory',
            array(
                'directory' => trailingslashit( get_template_directory_uri() )
                )
	    );
        
        wp_localize_script(
            'index',
            'myDirectoryI',
            array(
                'directory' => trailingslashit( get_template_directory_uri() )
                )
	    );
        
    }
    add_action( 'wp_enqueue_scripts', 'towsers_scripts' );


