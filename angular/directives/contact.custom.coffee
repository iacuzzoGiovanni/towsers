###
# Created by Iacuzzo Giovanni
###

do ->
  'use-strict'
  ###
  # @module {customContact}
  ###

  cContact = angular.module('customContact', ['angular-click-outside'])

  cContact.controller 'contactController', [
    '$scope', 'Contact', '$location'
    ($scope, Contact, $location) ->
      contact = @
      contact.isOpen = false

      Contact.get().then (d) ->
        contact.data = d
        return

      contact.onOpen = () ->
        if contact.isOpen == false
          contact.isOpen = true

      contact.onClose = () ->
        if contact.isOpen == true
          contact.isOpen = false

      return
  ]

  cContact.directive 'contactModal', [
    () ->
      {
        restrict: 'E'
        templateUrl: myLocalized.partials + 'contact.html'
        controller: 'contactController'
        controllerAs: 'contact'
        link: (scope, element, attrs, contact) ->
          contact.modalDialog = element[0]
          return
      }
  ]

  cContact.directive 'contactNavLink', [
    () ->
      {
        restrict: 'E'
        require: '^?contactModal'
        templateUrl: myLocalized.partials + 'contact-nav-link.html'
        link: (scope, element, attrs) ->
          return
      }
  ]

  return