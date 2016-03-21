app.directive('customNav', function() {
  return {
    restrict: 'A',
    templateUrl: myLocalized.partials + 'nav.html',
    scope: {
      menuItemActive: '@'
    }
  };
});

app.directive('customNavLink', function($timeout, $location, $rootScope) {
  return {
    restrict: 'A',
    templateUrl: myLocalized.partials + 'custom-nav-link.html',
    scope: {
      active: '@',
      page: '@',
      link: '@'
    },
    replace: true,
    link: function(scope, elem) {
      return scope.goTo = function($event) {
        $event.preventDefault();
        $rootScope.showBanner = true;
        return $timeout((function() {
          $location.path($event.target.getAttribute('href'));
        }), 1000);
      };
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
