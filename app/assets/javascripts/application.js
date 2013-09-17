// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require_tree ../../../vendor/assets/javascripts/
// require jquery_ujs
// require turbolinks
//= require_tree .
//= require_tree ./templates/

$(document).ready(function(){
	$('body').keypress(function(e){ 
		console.log(e)
		if(e.which == 32){ 
			$("a[data-dismiss='modal']")[0].click()	
		}
	})
	watch_button_click()
	$("form").submit(function(e){
		e.preventDefault();
		input = $(this).children("input")

		t = input.val()
		console.log(t);
		input.val("")
	})
})

function watch_button_click(){ 
	$("button.watch").unbind("click")
	$("button.watch").click(function(){
		click_on_watch_button($(this))
	})
	function click_on_watch_button(button){
		console.log("safasdfasf")
		var video_name = button.data("video-name");
		var video_url = button.data("video-url");
		$("h2.modal-title").html(video_name)
		$(".modal-body").html('<iframe title="YouTube video player" class="youtube-player" type="text/html" width="640" height="390" src="' + 
			//http://www.youtube.com/v/uelHwf8o7_U?version=3&amp;f=videos&amp;d=AfaDH_nQgCuNTKHkPssLQt4O88HsQjpE1a8d1GxQnGDm&amp;app=youtube_gdata" 
			video_url + '"' + 
			'frameborder="0" allowFullScreen></iframe>')
	}

}
watch_button_click()