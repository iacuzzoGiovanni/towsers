app.directive 'customNav', ->
  {
    restrict: 'A'
    templateUrl: myLocalized.partials + 'nav.html'
    scope: menuItemActive: '@'
  }

app.directive 'loadingView', ->
  {
    restrict: 'A'
    templateUrl: myLocalized.partials + 'loading-view.html'
    scope: onScreen: '@', directory: '@'
  }
