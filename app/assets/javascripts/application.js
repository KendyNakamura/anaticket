// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require tether
//= require jquery3
//= require popper
//= require bootstrap
//= require activestorage
//= require_tree .

// 制限付きイベント作成時
$(function() {
  $('#password').addClass("hide");
  $('#passwordConfirmation').addClass("hide");

  $('#check').click(function() {
    if ( $(this).prop('checked') == false ) {
      $('#password').addClass("hide");
      $('#passwordConfirmation').addClass("hide");
    } else {
      $('#password').removeClass("hide");
      $('#passwordConfirmation').removeClass("hide");
    }
  });
});

// // 有料、無料のラジオボタン押下時
$(function() {
  $('#ticket').addClass("hide");

  // $('#radio').click(function() {
  $('[name="radio"]:radio').change( function() {
    if ( $('#free').prop('checked')) {
      $('#ticket').addClass("hide");
      $('#persons').removeClass("hide");
    } else if ( $('#toll').prop('checked')){
      $('#ticket').removeClass("hide");
      $('#persons').addClass("hide");
    }
  });
});
