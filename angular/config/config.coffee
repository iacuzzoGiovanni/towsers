app.config [
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $locationProvider.html5Mode true
    $routeProvider
    .when('/',
      controller: 'Main'
      controllerAs: 'mainCtrl'
      templateUrl: myLocalized.partials + 'main.html')
    .when('/tour-dates',
      controller: 'Tourdates'
      controllerAs: 'tourdatesCtrl'
      templateUrl: myLocalized.partials + 'tourdates.html')
    .when('/music',
      controller: 'Music'
      controllerAs: 'musicCtrl'
      templateUrl: myLocalized.partials + 'music.html')
    .otherwise redirectTo: '/'
    return
]