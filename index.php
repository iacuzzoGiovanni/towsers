<!DOCTYPE html>
<html lang="en" ng-app="app">
       
    <head>
        <base href="/towsers/">
        <meta charset="UTF-8">
        <title>TOWSERS - OFFICIAL</title>
        <?php wp_head(); ?>
    </head>
    
    <body ng-controller="Index">
        <div loading-view on-screen="{{$root.showBanner}}" directory="{{myDirectory}}"></div>
        <div ng-view></div>
        <?php wp_footer(); ?>
    </body>
    
</html>