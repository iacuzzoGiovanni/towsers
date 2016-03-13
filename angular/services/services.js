app.service('Contact', [
  '$http', function($http) {
    var myService;
    myService = {
      get: function() {
        var promise;
        promise = $http.get('api/?json=get_page&slug=contact').then(function(response) {
          return response.data;
        });
        return promise;
      }
    };
    return myService;
  }
]);
