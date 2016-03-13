app.controller 'Main', [
  '$scope'
  '$timeout'
  '$rootScope'
  ($scope, $timeout, $rootScope) ->
    $scope.myDirectory = myDirectory.directory
    $rootScope.showBanner = true
    
    $scope.$on '$viewContentLoaded', ->
      $timeout (->
        $rootScope.showBanner = false
        return
      ), 1000
      return
]