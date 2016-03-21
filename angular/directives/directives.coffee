app.directive 'customNav', ->
    {
        restrict: 'A'
        templateUrl: myLocalized.partials + 'nav.html'
        scope: menuItemActive: '@'
    }

app.directive 'customNavLink', ($timeout, $location, $rootScope) ->
    {
        restrict: 'A'
        templateUrl: myLocalized.partials + 'custom-nav-link.html'
        scope: active: '@', page: '@', link: '@'
        replace: true
        link: (scope, elem) ->
          
          scope.goTo = ($event) ->
            $event.preventDefault()
            $rootScope.showBanner = true
            $timeout (->
              $location.path $event.target.getAttribute('href')
              return
            ), 1000
            return
    }

app.directive 'loadingView', ->
    {
        restrict: 'A'
        templateUrl: myLocalized.partials + 'loading-view.html'
        scope: onScreen: '@', directory: '@'
    }
