app.service 'Contact', [
  '$http'
  ($http) ->
    myService = get: ->
      # $http returns a promise, which has a then function, which also returns a promise
      promise = $http.get('api/?json=get_page&slug=contact').then((response) ->
        # The then function here is an opportunity to modify the response
        # The return value gets picked up by the then in the controller.
        response.data
      )
      # Return the promise to the controller
      promise
    myService
]

app.service 'Tourdates', [
  '$http'
  ($http) ->
    myService = get: ->
      # $http returns a promise, which has a then function, which also returns a promise
      promise = $http.get('api/?json=get_posts&post_type=tour_dates').then((response) ->
        # The then function here is an opportunity to modify the response
        # The return value gets picked up by the then in the controller.
        response.data
      )
      # Return the promise to the controller
      promise
    myService
]