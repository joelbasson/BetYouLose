$(function() {
	flashNotice();
});

function flashNotice() {
  	var flash = $('.flash');
	  if (flash.length > 0) {
	    flash.show().animate({height: flash.outerHeight()}, 300);

	    window.setTimeout(function() {
	      flash.slideUp();
	    }, 3000);
	  }
}