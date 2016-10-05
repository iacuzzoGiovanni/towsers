
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
    '$attrs', '$element', function(attributes, $element) {
      var audio;
      audio = this;
      audio.tracks = [];
      audio.currentTrack = null;
      audio.track;
      audio.addTrack = function(trackScope) {
        return audio.tracks.push(trackScope);
      };
      audio.setTrack = function(t) {
        if (audio.track) {
          audio.track.src = '';
          audio.track = new Audio(audio.tracks[t].url);
          return audio.setCurrentTrack(t);
        } else {
          audio.track = new Audio(audio.tracks[t].url);
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
          audio.track.play();
          return audio.getTrackDuration();
        } else {
          if (audio.track.paused) {
            audio.track.play();
            return audio.getTrackDuration();
          } else {
            audio.getTrackDuration();
            return audio.track.pause();
          }
        }
      };
      audio.getTrackDuration = function() {
        return audio.track.addEventListener('canplaythrough', (function() {
          var d, mm, ss;
          d = this.duration;
          mm = Math.floor(d / 60);
          ss = Math.round(d % 60);
          if (!ss > 10) {
            ss = '0' + ss;
          }
          console.log(ss);
        }), false);
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
