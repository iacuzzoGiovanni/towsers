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
    '$scope', 'Contact'
    ($scope, Contact) ->
      contact = @
      contact.isOpen = false

      Contact.get().then (d) ->
        contact.data = d.page.custom_fields
        return

      contact.onOpen = () ->
        if contact.isOpen == false
          contact.isOpen = true
          contact.webpage.classList.add('contactModalIsOpen')

      contact.onClose = () ->
        if contact.isOpen == true
          contact.isOpen = false
          contact.webpage.classList.remove('contactModalIsOpen')

      contact.collectionHas = (a, b) ->
        #helper function (see below)
        i = 0
        len = a.length
        while i < len
          if a[i] == b
            return true
          i++
        false

      contact.findParentBySelector = (elm, selector) ->
        all = document.querySelectorAll(selector)
        cur = elm.parentNode
        while cur and !contact.collectionHas(all, cur)
          #keep going up until you find a match
          cur = cur.parentNode
          #go up
        console.log cur
        cur
        #will return null if not found


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
          contact.modalDialog = element[0].querySelector('#contactModal')
          contact.webpage = contact.findParentBySelector(element[0], '.page')
          contact.modalDialog.style.left = Math.round((window.innerWidth - contact.modalDialog.offsetWidth)/2) + 'px'
          window.addEventListener 'resize', () ->
            contact.modalDialog.style.left = Math.round((window.innerWidth - contact.modalDialog.offsetWidth)/2) + 'px'
          , false
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