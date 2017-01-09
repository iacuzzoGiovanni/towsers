<!DOCTYPE html>
<html lang="en" ng-app="app">
       
    <head>
        <base href="/towsers/">
        <meta charset="UTF-8">
        <title>TOWSERS - OFFICIAL</title>
        <link rel="apple-touch-icon" sizes="180x180" href="<?php bloginfo('template_directory'); ?>/assets/favicons/apple-touch-icon.png">
        <link rel="icon" type="image/png" href="<?php bloginfo('template_directory'); ?>/assets/favicons/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="<?php bloginfo('template_directory'); ?>/assets/favicons/favicon-16x16.png" sizes="16x16">
        <link rel="manifest" href="<?php bloginfo('template_directory'); ?>/assets/favicons/manifest.json">
        <link rel="mask-icon" href="<?php bloginfo('template_directory'); ?>/assets/favicons/safari-pinned-tab.svg" color="#5bbad5">
        <meta name="theme-color" content="#ffffff">
        <?php wp_head(); ?>
    </head>
    
    <body ng-controller="Index">
        <div loading-view on-screen="{{$root.showBanner}}" directory="{{myDirectory}}"></div>
        <div ng-view></div>
        <?php wp_footer(); ?>
    </body>
    
</html>