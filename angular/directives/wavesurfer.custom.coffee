###
# Created by Iacuzzo Giovanni
###

do ->
  'use-strict'
  ###
  # @module {custoWavesurfer}
  ###
    
  cWavesurfer = angular.module('custoWavesurfer', [])

  cWavesurfer.factory 'mdWavesurferUtils', [
    '$q'
    '$document'
    '$timeout'
    ($q, $document, $timeout) ->
        { getLength: (object) ->
            deferred = $q.defer()
            estimateLength = (url) ->
                audio = $document[0].createElement('audio')
                audio.src = url
                audio.addEventListener 'loadeddata', ->
                    deferred.resolve @duration
                    audio.removeEventListener 'loadeddata', @
                    audio.src = 'data:audio/mpeg,0'
                    return
                audio.addEventListener 'error', (e) ->
                    deferred.resolve e.target.error
                    return
                return
            estimateLength(object)
            deferred.promise
        }
    ]

  cWavesurfer.filter 'convertToHumanMinutes', ->
    (d) ->
        mm = Math.floor(d / 60)
        ss = Math.round(d % 60)
        if ss < 10 then ss = '0'+ss
        dur = mm + ':' + ss
    
  cWavesurfer.controller 'musicAudioPlayerController', [
      '$attrs', 
      '$element',
      '$scope'
      '$interval'
      (attributes, $element, $scope, $interval) ->
        audio = @
        audio.tracks = []
        audio.currentTrack = null
        audio.track
        audio.currentTrackDuration
        
        #add audio tracks
        audio.addTrack = (trackScope) ->
            if audio.tracks.indexOf(trackScope) < 0
                audio.tracks.push trackScope
        
        #set the track to a new audio
        audio.setTrack = (t) ->
            if audio.track
                audio.track.src = ''

            audio.track = new Audio(audio.tracks[t].url)
            audio.currentTrackDuration = audio.tracks[t].duration
            audio.setCurrentTrack(t)
            $scope.digest()
        
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
                audio.getCurrentTrackPosition()
            else
                if audio.track.paused
                    audio.track.play()
                    audio.getCurrentTrackPosition()
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
                console.log @currentTime 
                $scope.$digest()
            , false

        audio.startInterval = () ->
            #console.log t 
            audio.track.addEventListener 'ontimeupdate', (->
                console.log @
                return
            ), false

        
        
        return
    ]
    
  cWavesurfer.directive 'player', ->
    {
        restrict: 'E'
        templateUrl: myLocalized.partials + 'custom-player.html'
        controller: 'musicAudioPlayerController'
        controllerAs: 'audio'
    } 
  
  cWavesurfer.directive 'customAudioSource', [
      'mdWavesurferUtils'
      (mdWavesurferUtils) ->
        {
            restrict: 'E'
            require: '^player'
            scope: url: '@', title: '@', artist: '@', cover: '@'
            link: (scope, element, attrs, audio) ->
                audio.addTrack(scope)
                console.log scope.url
                thepromise = mdWavesurferUtils.getLength(scope.url)
                thepromise.then ((duration) ->
                    console.log 'Success: ' + duration
                    scope.duration = duration
                    return
                ), (reason) ->
                    console.log 'Failed: ' + reason
                    return
        }
  ]

  return 