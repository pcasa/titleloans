$(document).ready(function(){
	$('#menu li').hover(
		function() { $('ul', this).slideDown('fast'); },
		function() { $('ul', this).slideUp('fast'); });
	
	$("#tabs").tabs({
		cache:true,
		   load: function (e, ui) {
		     $(ui.panel).find(".tab-loading").remove();
			 $(ui.panel).css({float: 'none', textAlign: 'left'});
		   },
		   select: function (e, ui) {
		     var $panel = $(ui.panel);

		     if ($panel.is(":empty")) {
		         $panel.append("<div class='tab-loading'><img src='/images/spinner.gif' /><br />Loading...</div>");
				 $panel.css({float: 'none', textAlign: 'center'});
				// $panel.css({float: 'none', display: 'inline'});
				// $panel.css({float: 'none'});
		     }
		    }
	});	
		
	$('#tabs ul li a').click(function () {location.hash = $(this).attr('href');});
	$(".new-task-button").click(function () {
	$(".new-task-form").toggle("slow");
	});
	$(".new-task-form").bind('ajax:success', function(evt, data, status, xhr){
	    var $this = $(this);
	    $this.find('input:text,textarea').val('');
			
	  });
	$(".close-dashboard-tasks").click(function(){
		$("#dashboard-tasks").slideUp("slow");
		$(this).fadeOut("fast");
		$(".open-dashboard-tasks").fadeIn();
	});
	$(".open-dashboard-tasks").click(function(){
		$("#dashboard-tasks").slideDown("slow");
		$(this).fadeOut("fast");
		$(".close-dashboard-tasks").fadeIn();
	});
	
	$('.delete-task').bind('ajax:success', function() {  
	    $(this).closest('tr').fadeOut();
	  	
	});
	
	
	
	$('.toggle-comment-form').click(function () {
		$(this).parents('tr').next('tr').toggle('slow');
		return false;
	});
	
	$('.date-picker').datepicker({ dateFormat: 'M d yy' });
	
	$('input.ui-datetime-picker, .task-datetime, .datetime-picker').datetimepicker({ dateFormat: 'M d yy', ampm: true });
	$('.created-at-datetime').datetimepicker({dateFormat: 'M dd, yy ', ampm: true});
	$('.task-picker').removeClass('hasDatepicker').datetimepicker({ onSelect: function() { $(".ui-datepicker a").removeAttr("href"); }, dateFormat: 'M dd, yy ', ampm: true });
	
	// to use datetimepicker put it on page.
	// conflicts with fancybox...
	// $('.datetime-picker').datetimepicker({ dateFormat: 'M d yy', ampm: true });
	
});