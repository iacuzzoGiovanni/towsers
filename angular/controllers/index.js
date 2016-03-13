app.controller('Index', [
  '$scope', '$rootScope', function($scope, $rootScope) {
    $scope.myDirectory = myDirectoryI.directory;
    console.log($scope.myDirectory);
    return $rootScope.showBanner = true;
  }
]);
