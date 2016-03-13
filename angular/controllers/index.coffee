app.controller 'Index', [
  '$scope'
  '$rootScope'
  ($scope, $rootScope) ->
    $scope.myDirectory = myDirectoryI.directory
    console.log $scope.myDirectory
    $rootScope.showBanner = true
]