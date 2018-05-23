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
  $('.ticket').addClass("hide");

  // $('#radio').click(function() {
  $('.free-radio').click( function() {
    if ( $('#event_free_0').prop('checked')) {
      $('.ticket').addClass("hide");
      $('#persons').removeClass("hide");
    } else if ( $('#event_free_1').prop('checked')){
      $('.ticket').removeClass("hide");
      $('#persons').addClass("hide");
    }
  });
});

// チケット価格の表示
$(function() {
  $('#profit').on('input', function(event) {
    var value = $('#profit').val();
    var profit = Math.ceil(value / 1.1);
    $('#price').text(profit);
  });
  // $(document).on('input', '#profit2', function(event) {
  //   var value2 = $('#profit2').val();
  //   var profit2 = Math.ceil(value2 / 1.1);
  //   $('#price2').text(profit2);
  // });
  // $(document).on('input', '#profit3', function(event) {
  //   var value3 = $('#profit3').val();
  //   var profit3 = Math.ceil(value3 / 1.1);
  //   $('#price3').text(profit3);
  // });
});

// // チケットの追加
// $(function() {
//   $('#button2').hide();
//   $("#button1").click(function() {
//     $("#button1").after(
//       '<div id="ticket2"><div class="mt-3 pt-2 border-top">2つ目の商品</div><input type="button" id="del2" value="削除する">' +
//       '<h5 class="pt-3">商品名</h5>' +
//       '<input name="name" class="form-control" value="チケット">' +
//       '<h5 class="pt-3">販売価格(100円〜9999円)</h5>' +
//       '<input type="number" name="price" class="form-control" min="100" max="9999" placeholder="販売価格を入力" id="profit2">' +
//       '利益額: <span id="price2"></span>' +
//       '<h5 class="pt-3">在庫(1個〜30個)</h5>' +
//       '<input type="count" class="form-control" min="1" max="29" placeholder="個数を記載してください">' +
//       '<h5 class="pt-3">詳細</h5>' +
//       '<input type="content" class="form-control" placeholder="商品の内容を記載"></div>'
//       );
//       $(this).hide();
//       $('#button2').show();
//   });
//
//   $("#button2").click(function() {
//     $("#button2").after(
//       '<div id="ticket3"><div class="mt-3 pt-2 border-top">3つ目の商品</div><input type="button" id="del3" value="削除する">' +
//       '<h5 class="pt-3">商品名</h5>' +
//       '<input name="name" class="form-control" value="チケット">' +
//       '<h5 class="pt-3">販売価格(100円〜9999円)</h5>' +
//       '<input type="number" name="price" class="form-control" min="100" max="9999" placeholder="販売価格を入力" id="profit3">' +
//       '利益額: <span id="price3"></span>' +
//       '<h5 class="pt-3">在庫(1個〜30個)</h5>' +
//       '<input type="count" class="form-control" min="1" max="29" placeholder="個数を記載してください">' +
//       '<h5 class="pt-3">詳細</h5>' +
//       '<input type="content" class="form-control" placeholder="商品の内容を記載"></div>'
//       );
//       $(this).hide();
//       $('#del2').hide();
//   });
//
//   $(document).on('click', '#del2', function() {
//     $('#ticket2').hide();
//     $('#button1').show();
//     $('#button2').hide();
//   });
//
//   $(document).on('click', '#del3', function() {
//     $('#ticket3').hide();
//     $('#button2').show();
//     $('#del2').show();
//   });
// });
