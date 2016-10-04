###
# Created by Iacuzzo Giovanni
###

do ->
  'use-strict'
  ###
  # @module {custoWavesurfer}
  ###
    
  cWavesurfer = angular.module('custoWavesurfer', [])
    
  cWavesurfer.controller 'musicAudioPlayerController', [
      '$attrs', 
      '$element',
      (attributes, $element) ->
        audio = this
        audio.tracks = []
        audio.currentTrack = null
        audio.track
        
        #add audio tracks
        audio.addTrack = (trackScope) ->
          audio.tracks.push trackScope
          #myMusic = new Audio(audio.tracks[audio.tracks.indexOf(trackScope)].url)
        
        #set the track to a new audio
        audio.setTrack = (t) ->
            if audio.track
                audio.track.src = ''
                audio.track = new Audio(audio.tracks[t].url)
                audio.setCurrentTrack(t)
            else
                audio.track = new Audio(audio.tracks[t].url)
                audio.setCurrentTrack(t)
        
                
                
        #Set current track
        audio.setCurrentTrack = (e) ->
            audio.currentTrack = e
        
        #Get current track
        audio.getCurrentTrack = () ->
            console.log audio.currentTrack
                
        #play music
        audio.play = (e) ->
            e.preventDefault()
            idx = angular.element(e.target).data('index')
            audio.setTrack(idx)
            audio.track.play()
    
        #play/pause btn
        audio.test = () ->
            console.log 'play pause'
        
        return
    ]
    
  cWavesurfer.directive 'player', ->
    {
        restrict: 'E'
        templateUrl: myLocalized.partials + 'custom-player.html'
        controller: 'musicAudioPlayerController'
        controllerAs: 'player'
    } 
  
  cWavesurfer.directive 'customAudioSource', ->
    {
        restrict: 'E'
        require: '^player'
        scope: url: '@'
        link: (scope, element, attrs, audio) ->
            audio.addTrack(scope)
    }  

  return 