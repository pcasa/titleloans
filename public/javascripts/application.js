// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
	
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
	$('.date-picker').datepicker({ dateFormat: 'M d yy' });
	$('.datetime-picker, .task-datetime').datetimepicker({ dateFormat: 'M d yy', ampm: true });
	
	
	
});