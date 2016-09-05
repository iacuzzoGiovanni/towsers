###
# Created by Iacuzzo Giovanni
###

do ->
  'use-strict'
  ###
  # @module {custoWavesurfer}
  ###
    
  cWavesurfer = angular.module('custoWavesurfer', [])
  
  cWavesurfer.directive 'customAudioSource', ->
    {
        restrict: 'E'
        scope: url: '@'
        link: (scope, element, attrs, audio) ->
            console.log scope.url
    }  

  return 