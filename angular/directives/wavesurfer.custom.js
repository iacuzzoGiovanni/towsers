
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
      audio.setCurrentTrack = function(e) {
        return audio.currentTrack = e;
      };
      audio.getCurrentTrack = function() {
        return console.log(audio.currentTrack);
      };
      audio.play = function(e) {
        var idx;
        e.preventDefault();
        idx = angular.element(e.target).data('index');
        audio.setTrack(idx);
        return audio.track.play();
      };
      audio.test = function() {
        return console.log('play pause');
      };
    }
  ]);
  cWavesurfer.directive('player', function() {
    return {
      restrict: 'E',
      templateUrl: myLocalized.partials + 'custom-player.html',
      controller: 'musicAudioPlayerController',
      controllerAs: 'player'
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
