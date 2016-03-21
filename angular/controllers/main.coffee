app.controller 'Main', [
  '$scope'
  '$timeout'
  '$rootScope'
  ($scope, $timeout, $rootScope) ->
    $scope.myDirectory = myDirectory.directory
    
    $scope.$on '$viewContentLoaded', ->
      $timeout (->
        $rootScope.showBanner = false
        return
      ), 1000
      return
]