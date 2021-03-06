app.controller 'Tourdates', [
  '$scope'
  'Tourdates'
  '$timeout'
  '$rootScope'
  ($scope, Tourdates, $timeout, $rootScope) ->
    $scope.myDirectory = myDirectory.directory
    
    Tourdates.get().then (d) ->
      $scope.data = d
      return
    
    $scope.$on '$viewContentLoaded', ->
      $timeout (->
        $rootScope.showBanner = false
        return
      ), 1000
      return

    return
]