// Generated by CoffeeScript 1.11.1
app.controller('Main', [
  '$scope', '$timeout', '$rootScope', function($scope, $timeout, $rootScope) {
    $scope.myDirectory = myDirectory.directory;
    return $scope.$on('$viewContentLoaded', function() {
      $timeout((function() {
        $rootScope.showBanner = false;
      }), 1000);
    });
  }
]);
