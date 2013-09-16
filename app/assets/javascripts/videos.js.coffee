api_call = () ->
	dev_key = "AI39si4fWNCFVy6-i7GdE8lh4_LpfAF-Hto6MQedytR3mT78kAtUy_oKC3lM-WuiKKQv2JhWWdzE1w9-NHaBkgEib19H7e7YIQ"
	console.log dev_key
	# http://gdata.youtube.com/feeds/api/users/default/favorites
	$.ajax 
		url: 'http://gdata.youtube.com/feeds/api/videos?v=2',		
		type: 'GET'
		data: 
			"api-key": "AIzaSyAOfBgH4yIffYHU1tweqeagwjYMXsdQaDA"
		headers: 
			'X-GData-Key': 'key='+dev_key
		dataType: 'xml'
		error: (jqXHR, textStatus, errorThrown) ->
			$('body').append "AJAX Error: #{textStatus}"
		success: (xml) ->
			#console.log(xml)
			$(xml).find('entry').each () ->
				published = $(this).find('published').text()
				title = $(this).find('title').text()
				console.log title
				console.log published 
				console.log "######"
	null 

load_youtube_api_script = () ->
	if $("tag#iframe_api").length == 0
		tag = document.createElement('script');
		tag.src = "https://www.youtube.com/iframe_api";
		tag.id = "iframe_api"
		firstScriptTag = $('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	true

load_video = ->
	load_youtube_api_script()

	#This function creates an <iframe> (and YouTube player) after the API code downloads.
	onYouTubeIframeAPIReady = () ->
		player = new YT.Player('player',
			'height': '390'
			'width': '640'
			'videoId': 'M7lc1UVf-VE'
			'events': 
				'onReady': onPlayerReady
				'onStateChange': onPlayerStateChange
		)

	onPlayerReady = (event) ->
		event.target.playVideo()

	done = false
	#The API calls this function when the player's state changes.
	onPlayerStateChange = (event) -> 
		if (event.data == YT.PlayerState.PLAYING && !done)
			setTimeout(stopVideo, 6000);
			done = true;
		true

	stopVideo = () ->
		player.stopVideo();





api_call()
