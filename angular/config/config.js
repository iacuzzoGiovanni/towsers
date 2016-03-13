app.config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $locationProvider.html5Mode(true);
    $routeProvider.when('/', {
      controller: 'Main',
      controllerAs: 'mainCtrl',
      templateUrl: myLocalized.partials + 'main.html'
    }).when('/contact', {
      controller: 'Contact',
      controllerAs: 'contactCtrl',
      templateUrl: myLocalized.partials + 'contact.html'
    }).otherwise({
      redirectTo: '/'
    });
  }
]);
