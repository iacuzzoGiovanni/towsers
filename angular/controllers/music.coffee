app.controller 'Music', [
  '$scope'
  'Music'
  '$timeout'
  '$rootScope'
  ($scope, Music, $timeout, $rootScope) ->
    $scope.myDirectory = myDirectory.directory
    
    Music.get().then (d) ->
      $scope.data = d
      console.log $scope.data
      return
    
    $scope.$on '$viewContentLoaded', ->
      $timeout (->
        $rootScope.showBanner = false
        return
      ), 1000
      return

    return
]