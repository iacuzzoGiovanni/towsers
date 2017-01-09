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
      '$attrs', '$element', '$scope', '$interval', '$location', '$rootScope', '$routeParams'
      (attributes, $element, $scope, $interval, $location, $rootScope, $routeParams) ->
        audio = @
        audio.tracks = []
        audio.currentTrack = null
        audio.track
        audio.currentTrackDuration
        audio.currentTimeTrackDuration
        audio.currentTrackArtist
        audio.currentTrackTitle
        audio.currentTrackCover
        audio.paused = true
        audio.progressBar

        $rootScope.$on '$routeChangeStart', (e, current, pre) ->
            if $location.path() != '/music'
                audio.track.src = 'data:audio/mpeg,0'
                audio.track.removeEventListener 'timeupdate', audio.getCurrentTimeTrack
            return

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
                    audio.startInterval()
                    audio.paused = false
                else
                    audio.track.pause()
                    audio.track.removeEventListener 'timeupdate', audio.getCurrentTimeTrack
                    audio.paused = true

        audio.backward = (e) ->
            if audio.getCurrentTrack() == null
                audio.setTrack(0)
                audio.track.play()
                audio.paused = false
            else
                if audio.currentTrack - 1 < 0
                    audio.setTrack(audio.tracks.length - 1)
                    audio.track.play()
                else
                    audio.setTrack(audio.currentTrack - 1)
                    audio.track.play()

        audio.forward = (e) ->
            if audio.getCurrentTrack() == null
                audio.setTrack(0)
                audio.track.play()
                audio.paused = false
            else
                if audio.currentTrack + 1 <= audio.tracks.length - 1
                    audio.setTrack(audio.currentTrack + 1)
                    audio.track.play()
                else
                    audio.setTrack(0)
                    audio.track.play()

        audio.convertToHumanMinutes = (d) ->
            mm = Math.floor(d / 60)
            ss = Math.round(d % 60)
            if ss < 10 then ss = '0'+ss
            dur = mm + ':' + ss

        audio.startInterval = () ->
            if audio.track
                audio.track.addEventListener 'timeupdate', audio.getCurrentTimeTrack, false

        audio.getCurrentTimeTrack = () ->
            audio.currentTimeTrackDuration = @currentTime
            audio.setProgressBarPosition()
            $scope.$digest()

        audio.setProgressBarPosition = () ->
            position =  (audio.currentTimeTrackDuration / audio.currentTrackDuration) * 100
            oWidth =  audio.progressBar.find('#progressBar')[0].offsetWidth
            dragger = audio.progressBar.find('#position')[0]
            barInner = audio.progressBar.find('#bar-inner')[0]
            dragger.style.left = oWidth / 100 * position - dragger.offsetWidth + 'px'
            barInner.style.width = oWidth / 100 * position + 'px'

        audio.setTrackPosition = (e, down, rangeLeft, rangeWidth, dragger, draggerWidth, barInner) ->
            position = audio.currentTrackDuration * ((e.pageX - rangeLeft) / rangeWidth)
            audio.track.currentTime = position
            audio.currentTimeTrackDuration = position
            $scope.$digest()

        audio.updateDragger = (e, down, rangeLeft, rangeWidth, dragger, draggerWidth, barInner) ->
            if down and e.pageX >= rangeLeft and e.pageX <= rangeLeft + rangeWidth
                dragger.style.left = e.pageX - rangeLeft - draggerWidth + 'px'
                barInner.style.width = e.pageX - rangeLeft + 'px'
            return

        audio.onSlide = (el) ->
            range = el.find('#progressBar')[0]
            rangeParent = el.parent()[0]
            dragger = angular.element(range).find('#position')[0]
            barInner = angular.element(range).find('#bar-inner')[0]
            draggerWidth = 16
            down = false
            rangeWidth = range.offsetWidth
            rangeLeft = range.offsetLeft + rangeParent.offsetLeft

            dragger.style.width = draggerWidth + 'px'
            dragger.style.left = -draggerWidth + 'px'
            dragger.style.marginLeft = draggerWidth / 2 + 'px'

            range.addEventListener 'mousedown', (e) ->
                if e.which == 1 and audio.track
                    audio.updateDragger e, down, rangeLeft, rangeWidth, dragger, draggerWidth, barInner
                    audio.track.removeEventListener 'timeupdate', audio.getCurrentTimeTrack
                    down = true
                    false

            document.addEventListener 'mousemove', (e) ->
                audio.updateDragger e, down, rangeLeft, rangeWidth, dragger, draggerWidth, barInner
                return

            document.addEventListener 'mouseup', (e) ->
                if audio.track and down == true
                    audio.startInterval()
                    audio.setTrackPosition e, down, rangeLeft, rangeWidth, dragger, draggerWidth, barInner
                down = false
                return

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
                audio.onSlide(audio.progressBar)
                return
        }
  ]

  return