// Generated by CoffeeScript 1.11.1

/*
 * Created by Iacuzzo Giovanni
 */
(function() {
  'use-strict';

  /*
   * @module {custoWavesurfer}
   */
  var cWavesurfer;
  cWavesurfer = angular.module('custoWavesurfer', []);
  cWavesurfer.controller('musicAudioPlayerController', [
    '$attrs', '$element', '$scope', function(attributes, $element, $scope) {
      var audio;
      audio = this;
      audio.tracks = [];
      audio.currentTrack = null;
      audio.track;
      audio.currentTrackDuration = null;
      audio.tmpDuration;

      /*
      $scope.$watch angular.bind(audio, ->
          audio.currentTrackDuration
           * `this` IS the `this` above!!
      ), (newVal, oldVal) ->
          console.log newVal
          return
       */
      audio.addTrack = function(trackScope) {
        var tmpTrack;
        audio.tracks.push(trackScope);
        return tmpTrack = new Audio(audio.tracks[audio.tracks.length - 1].url);
      };
      audio.setTrack = function(t) {
        if (audio.track) {
          audio.track.src = '';
          audio.track = new Audio(audio.tracks[t].url);
          audio.track.addEventListener('canplaythrough', function() {
            audio.currentTrackDuration = audio.convertToHumanMinutes(this.duration);
            return $scope.$digest();
          }, false);
          return audio.setCurrentTrack(t);
        } else {
          audio.track = new Audio(audio.tracks[t].url);
          audio.track.addEventListener('canplaythrough', function() {
            audio.currentTrackDuration = audio.convertToHumanMinutes(this.duration);
            return $scope.$digest();
          }, false);
          return audio.setCurrentTrack(t);
        }
      };
      audio.setCurrentTrack = function(ct) {
        return audio.currentTrack = ct;
      };
      audio.getCurrentTrack = function() {
        return audio.currentTrack;
      };
      audio.addFromPlaylist = function(e) {
        var idx;
        e.preventDefault();
        idx = angular.element(e.target).data('index');
        audio.setTrack(idx);
        return audio.play();
      };
      audio.play = function() {
        if (audio.getCurrentTrack() === null) {
          audio.setTrack(0);
          return audio.track.play();
        } else {
          if (audio.track.paused) {
            return audio.track.play();
          } else {
            return audio.track.pause();
          }
        }
      };
      audio.convertToHumanMinutes = function(d) {
        var dur, mm, ss;
        mm = Math.floor(d / 60);
        ss = Math.round(d % 60);
        if (ss < 10) {
          ss = '0' + ss;
        }
        return dur = mm + ':' + ss;
      };
    }
  ]);
  cWavesurfer.directive('player', function() {
    return {
      restrict: 'E',
      templateUrl: myLocalized.partials + 'custom-player.html',
      controller: 'musicAudioPlayerController',
      controllerAs: 'audio'
    };
  });
  cWavesurfer.directive('customAudioSource', function() {
    return {
      restrict: 'E',
      require: '^player',
      scope: {
        url: '@'
      },
      link: function(scope, element, attrs, audio) {
        return audio.addTrack(scope);
      }
    };
  });
})();
