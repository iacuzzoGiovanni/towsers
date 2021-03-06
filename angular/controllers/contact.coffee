app.controller 'Contact', [
  '$scope'
  'Contact'
  '$timeout'
  '$rootScope'
  ($scope, Contact, $timeout, $rootScope) ->
    $scope.myDirectory = myDirectory.directory
    
    Contact.get().then (d) ->
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