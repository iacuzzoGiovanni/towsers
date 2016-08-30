app.controller('Music', [
  '$scope', 'Music', '$timeout', '$rootScope', function($scope, Music, $timeout, $rootScope) {
    $scope.myDirectory = myDirectory.directory;
    Music.get().then(function(d) {
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
