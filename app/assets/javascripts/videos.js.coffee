xml_api_call = () ->
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
			console.log(xml)
			$(xml).find('entry').each () ->
				published = $(this).find('published').text()
				title = $(this).find('title').text()
				uploader = $(this).find('author').find('name').text()
				content = $(this).find("link[rel='alternate'][type='text/html']")
				video = content.attr("href")
				
				media = $(this).find("media\:group")
				console.log media
				description = $(media).find("media:description")
				console.log description
				console.log description.text()
				console.log description.html()
				console.log $(description)
				thumb = $(media).find("thumbnail")
				console.log thumb
				thumbnail = $(thumb).attr("url") #["yt:name"="mqdefault"]
				duration = $(this).find("yt:duration").attr("seconds")
				views = $(this).find("yt:statistics").attr("viewCount")
				likes = $(this).find("yt:rating").attr("numLikes")
				dislikes = $(this).find("yt:rating").attr("numDislikes")
				json = 
					author:		 uploader
					date: 		 published
					description: description
					duration: 	 duration
					dislikes:	 dislikes
					likes:		 likes
					title:		 title
					thumbnail:	 thumbnail
					views:		 views
					video_url:	 video
				console.log(json)
				console.log "#####################################"
				display_video(json)
	null 

api_call = () ->
	dev_key = "AI39si4fWNCFVy6-i7GdE8lh4_LpfAF-Hto6MQedytR3mT78kAtUy_oKC3lM-WuiKKQv2JhWWdzE1w9-NHaBkgEib19H7e7YIQ"
	console.log dev_key
	# http://gdata.youtube.com/feeds/api/users/default/favorites
	$.ajax 
		url: 'http://gdata.youtube.com/feeds/api/videos?v=2&alt=json',		
		type: 'GET'
		data: 
			"api-key": "AIzaSyAOfBgH4yIffYHU1tweqeagwjYMXsdQaDA"
		headers: 
			'X-GData-Key': 'key='+dev_key
		dataType: 'JSON'
		error: (jqXHR, textStatus, errorThrown) ->
			$('body').append "AJAX Error: #{textStatus}"
		success: (data) ->
			console.log(data)
			entries = data["feed"]["entry"]
			entries.map (entry) ->
				id = entry["id"]["$t"]
				content = entry["link"][0] #[rel='alternate'][type='text/html']")
				video = content.href
				published = entry['published']["$t"]
				title = entry['title']["$t"]
				uploader = entry['author'][0]["name"]["$t"]
				media = entry["media$group"]
				description = media["media$description"]["$t"]
				thumb = media["media$thumbnail"]
				thumbnail = thumb[1]["url"] #["yt:name"="mqdefault"]
				duration = media["yt$duration"]["seconds"]
				views = entry["yt$statistics"]["viewCount"]
				likes = entry["yt$rating"]["numLikes"]
				dislikes = entry["yt$rating"]["numDislikes"]
				json = 
					videoId:	 id
					author:		 uploader
					date: 		 published
					description: description
					duration: 	 duration
					dislikes:	 dislikes
					likes:		 likes
					title:		 title
					thumbnail:	 thumbnail
					views:		 views
					videoUrl:	 video
				#console.log(json)
				#console.log "#####################################"
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


#xml_api_call()
api_call()