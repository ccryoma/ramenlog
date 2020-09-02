$(document).on('turbolinks:load', function(){
  $.fn.raty.defaults.path = "/images/raty";
  $('.raty').raty({
    number: 5,
    half: true,
    readOnly: function() {
      return $(this).attr('read_only');
    },
    score: function() {
      return $(this).attr('data_score');
    },
  });
  // 星をクリック時に数値を更新
  $('.raty').on('click',function(){
    $('.postform_point_num').text($('.postform_point input[name="score"]').val());
  });

  // 投稿フォームと画像のモーダル表示
  let scrollPos;//topからのスクロール位置
  $('.js_modal_open').on('click',function(){
      scrollPos = $(window).scrollTop();//topからのスクロール位置を格納
      let open = '.js_modal.' + $(this).attr('id');
      $(open).fadeIn(10);
      $('body').addClass('fixed').css({ top: -scrollPos });//背景固定
      return false;
  });
  $('.js_modal_close').on('click',function(){
      $('.js_modal').fadeOut(10);
      $('body').removeClass('fixed').css({ top: 0 });//背景固定を解除
      $(window).scrollTop(scrollPos);//元の位置までスクロール
      return false;
  });
});