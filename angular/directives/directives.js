app.directive('customNav', function() {
  return {
    restrict: 'A',
    templateUrl: myLocalized.partials + 'nav.html',
    scope: {
      menuItemActive: '@'
    }
  };
});

app.directive('loadingView', function() {
  return {
    restrict: 'A',
    templateUrl: myLocalized.partials + 'loading-view.html',
    scope: {
      onScreen: '@',
      directory: '@'
    }
  };
});
