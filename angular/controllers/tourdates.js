app.controller('Tourdates', [
  '$scope', 'Tourdates', '$timeout', '$rootScope', function($scope, Tourdates, $timeout, $rootScope) {
    $scope.myDirectory = myDirectory.directory;
    Tourdates.get().then(function(d) {
      $scope.data = d;
      console.log($scope.data);
    });
    $scope.$on('$viewContentLoaded', function() {
      $timeout((function() {
        $rootScope.showBanner = false;
      }), 1000);
    });
  }
]);
