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
      '$attrs', '$element', '$scope', '$interval',
      (attributes, $element, $scope, $interval) ->
        audio = @
        audio.tracks = []
        audio.currentTrack = null
        audio.track
        audio.currentTrackDuration
        audio.currentTimeTrackDuration
        audio.currentTrackArtist
        audio.currentTrackTitle
        audio.currentTrackCover
        audio.progessBarWidth = 0
        audio.paused = true

        #add audio tracks
        audio.addTrack = (trackScope) ->
            if audio.tracks.indexOf(trackScope) < 0
                audio.tracks.push trackScope

        #set the track to a new audio
        audio.setTrack = (t) ->
            if audio.track
                audio.track.src = 'data:audio/mpeg,0'
                audio.track.removeEventListener 'timeupdate', audio.getCurrentTimeTrack

            audio.track = new Audio(audio.tracks[t].url)
            audio.currentTrackDuration = audio.tracks[t].duration
            audio.currentTrackArtist = audio.tracks[t].artist
            audio.currentTrackTitle = audio.tracks[t].title
            audio.currentTrackCover = audio.tracks[t].cover
            audio.startInterval()
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
                audio.paused = false
            else
                if audio.track.paused
                    audio.track.play()
                    audio.paused = false
                else
                    audio.track.pause()
                    audio.paused = true

        audio.convertToHumanMinutes = (d) ->
            mm = Math.floor(d / 60)
            ss = Math.round(d % 60)
            if ss < 10 then ss = '0'+ss
            dur = mm + ':' + ss

        audio.startInterval = () ->
            audio.track.addEventListener 'timeupdate', audio.getCurrentTimeTrack, false

        audio.getCurrentTimeTrack = () ->
            audio.currentTimeTrackDuration = @.currentTime
            audio.setProgressBarPosition()
            $scope.$digest()

        audio.setProgressBarPosition = () ->
            audio.progessBarWidth = (audio.currentTimeTrackDuration/audio.currentTrackDuration) * 100 + '%'

        #audio.getProgressBarPosition = (e) ->
            #console.log Math.round(e.layerX / @.offsetWidth * 100)

        audio.onSlideDown = (e) ->
            @addEventListener 'mousemove', audio.onSlideMove, false
            @addEventListener 'mouseup', audio.onSlideUp, false

        audio.onSlideMove = (e) ->
            position = angular.element(@).find('#position')[0]
            barInner = angular.element(@).find('#bar-inner')[0]
            position.style.marginLeft = Math.round(e.layerX / @.offsetWidth * 100) + '%'
            barInner.style.width = Math.round(e.layerX / @.offsetWidth * 100) + '%'

        audio.onSlideUp = (e) ->
            @removeEventListener 'mousemove', audio.onSlideMove
            position = angular.element(@).find('#position')[0]
            barInner = angular.element(@).find('#bar-inner')[0]
            position.style.marginLeft = Math.round(e.layerX / @.offsetWidth * 100) + '%'
            barInner.style.width = Math.round(e.layerX / @.offsetWidth * 100) + '%'

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
                thepromise = mdWavesurferUtils.getLength(scope.url)
                thepromise.then ((duration) ->
                    scope.duration = duration
                    return
                ), (reason) ->
                    return
        }
  ]

  cWavesurfer.directive 'playerProgressBar', [
      () ->
        {
            restrict: 'E'
            templateUrl: myLocalized.partials + 'player-progress-bar.html'
            require: '^player'
            link: (scope, element, attrs, audio) ->
                audio.progressBar = element
                barOuter = element.find('#progressBar')[0]
                barOuter.addEventListener 'mousedown', audio.onSlideDown, false

                return
        }
  ]

  return