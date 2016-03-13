app.controller('Contact', [
  '$scope', 'Contact', '$timeout', '$rootScope', function($scope, Contact, $timeout, $rootScope) {
    $scope.myDirectory = myDirectory.directory;
    $rootScope.showBanner = true;
    Contact.get().then(function(d) {
      $scope.data = d;
      console.log($scope.data.page);
    });
    $scope.$on('$viewContentLoaded', function() {
      $timeout((function() {
        $rootScope.showBanner = false;
      }), 1000);
    });
  }
]);
