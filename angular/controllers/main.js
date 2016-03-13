app.controller('Main', [
  '$scope', '$timeout', '$rootScope', function($scope, $timeout, $rootScope) {
    $scope.myDirectory = myDirectory.directory;
    $rootScope.showBanner = true;
    return $scope.$on('$viewContentLoaded', function() {
      $timeout((function() {
        $rootScope.showBanner = false;
      }), 1000);
    });
  }
]);
