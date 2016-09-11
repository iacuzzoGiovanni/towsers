
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
        audio.tracks.push(trackScope);
      };
      audio.setTrack = function(t) {
        if (audio.track) {
          audio.track.src = '';
          return audio.track = new Audio(audio.tracks[t].url);
        } else {
          return audio.track = new Audio(audio.tracks[t].url);
        }
      };
      audio.play = function(e) {
        var idx;
        e.preventDefault();
        idx = angular.element(e.target).data('index');
        audio.setTrack(idx);
        return audio.track.play();
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
