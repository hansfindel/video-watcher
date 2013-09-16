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
				json = 
					title: title
					date: published
				display_video(json)
	null 

video_renderer = () ->
	if renderer == undefined
		renderer = new Renderer(Handlebars.TEMPLATES["_film"])
	renderer 

display_video = (json) ->
	container = $(".videos-container")
	render = video_renderer()
	render.display(json, container)

api_call()
