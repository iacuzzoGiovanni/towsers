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

app.service('Tourdates', [
  '$http', function($http) {
    var myService;
    myService = {
      get: function() {
        var promise;
        promise = $http.get('api/?json=get_posts&post_type=tour_dates').then(function(response) {
          return response.data;
        });
        return promise;
      }
    };
    return myService;
  }
]);

app.service('Music', [
  '$http', function($http) {
    var myService;
    myService = {
      get: function() {
        var promise;
        promise = $http.get('tracks').then(function(response) {
          console.log(response);
          return response.data;
        });
        return promise;
      }
    };
    return myService;
  }
]);
