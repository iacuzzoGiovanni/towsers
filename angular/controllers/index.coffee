app.controller 'Index', [
  '$scope'
  '$rootScope'
  ($scope, $rootScope) ->
    $scope.myDirectory = myDirectoryI.directory
    $rootScope.showBanner = true
]