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
      '$scope'
      (attributes, $element, $scope) ->
        audio = @
        audio.tracks = []
        audio.currentTrack = null
        audio.track
        audio.currentTrackDuration
        
        #add audio tracks
        audio.addTrack = (trackScope) ->
            audio.tracks.push trackScope
            tmpTrack = new Audio(audio.tracks[audio.tracks.length - 1].url)
        
        #set the track to a new audio
        audio.setTrack = (t) ->
            if audio.track
                audio.track.src = ''
                audio.track = new Audio(audio.tracks[t].url)
                audio.setTrackDuration(audio.track)
                audio.setCurrentTrack(t)
            else
                audio.track = new Audio(audio.tracks[t].url)
                audio.setTrackDuration(audio.track)
                audio.setCurrentTrack(t)
        
        #Set current track
        audio.setCurrentTrack = (ct) ->
            audio.currentTrack = ct
        
        #Get current track
        audio.getCurrentTrack = () ->
            audio.currentTrack
                
        #Add music from the playlist section
        audio.addFromPlaylist = (e) ->
            e.preventDefault()
            idx = angular.element(e.target).data('index')
            audio.setTrack(idx)
            audio.play()
    
        #play/pause btn
        audio.play = () ->
            if audio.getCurrentTrack() == null
                audio.setTrack(0)
                audio.track.play()
            else
                if audio.track.paused
                    audio.track.play()
                else
                    audio.track.pause()
        
        audio.convertToHumanMinutes = (d) ->
            mm = Math.floor(d / 60)
            ss = Math.round(d % 60)
            if ss < 10 then ss = '0'+ss
            dur = mm + ':' + ss

        audio.setTrackDuration = (t) ->
            t.addEventListener 'canplaythrough', ->
                audio.currentTrackDuration = audio.convertToHumanMinutes(@duration) 
                $scope.$digest()
            , false
        
        return
    ]
    
  cWavesurfer.directive 'player', ->
    {
        restrict: 'E'
        templateUrl: myLocalized.partials + 'custom-player.html'
        controller: 'musicAudioPlayerController'
        controllerAs: 'audio'
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