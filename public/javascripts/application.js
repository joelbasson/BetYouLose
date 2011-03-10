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
		
	$("#bet_search").live("submit", function(){
		var url = $("#bet_search").serialize();
		var fullUrl = $("#bet_search").attr("action") + "?" + url
		$.get($("#bet_search").attr("action"), url, null, "script");
		currentPage = url;
		history.pushState(null, fullUrl, fullUrl);
    	return false;
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