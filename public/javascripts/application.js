var currentPage = '';
jQuery.ajaxSetup({ cache: true });

$(function() {
	flashNotice();
	
	$(".pagination a").live("click", function() {	
	    	$.getScript(this.href);
			currentPage = this.href;
			history.pushState(null, this.href, this.href);
	    	return false;
	  });
	
	$(window).bind("popstate", function() {
			if (currentPage != location.pathname && currentPage != '')
			{
				currentPage = location.pathname;
			 	$.getScript(location.pathname);
			}
		});
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