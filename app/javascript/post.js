$(function(){
  $.fn.raty.defaults.path = "/assets/raty";
  $('.raty').raty({
    half: true,
    readOnly: function() {
      return $(this).attr('read_only');
    },
    score: function() {
      return $(this).attr('data_score');
    },
  });
  let scrollPos;//topからのスクロール位置
  $('.js-modal-open').on('click',function(){
      scrollPos = $(window).scrollTop();//topからのスクロール位置を格納
      $('.js-modal').fadeIn(10);
      $('body').addClass('fixed').css({ top: -scrollPos });//背景固定
      return false;
  });
  $('.js-modal-close').on('click',function(){
      $('.js-modal').fadeOut(10);
      $('body').removeClass('fixed').css({ top: 0 });//背景固定を解除
      $(window).scrollTop(scrollPos);//元の位置までスクロール
      return false;
  });
});