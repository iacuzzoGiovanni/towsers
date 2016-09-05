
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
  cWavesurfer.directive('customAudioSource', function() {
    return {
      restrict: 'E',
      scope: {
        url: '@'
      },
      link: function(scope, element, attrs, audio) {
        return console.log(scope.url);
      }
    };
  });
})();
