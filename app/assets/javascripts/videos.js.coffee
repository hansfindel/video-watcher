api_call = (data) ->
	dev_key = "AI39si4fWNCFVy6-i7GdE8lh4_LpfAF-Hto6MQedytR3mT78kAtUy_oKC3lM-WuiKKQv2JhWWdzE1w9-NHaBkgEib19H7e7YIQ"
	# http://gdata.youtube.com/feeds/api/users/default/favorites
	if data == undefined || data == null
		data = {}
	data["v"] = "2"
	data["alt"] = "json"
	#console.log data	
	data["max-results"] = 10
	data["api-key"] = "AIzaSyAOfBgH4yIffYHU1tweqeagwjYMXsdQaDA"
	if data["q"] == undefined || data["q"] == null
		data["q"] = "javascript"
	$.ajax 
		url: 'http://gdata.youtube.com/feeds/api/videos?',		
		type: 'GET'
		data: data
		headers: 
			'X-GData-Key': 'key='+dev_key
		dataType: 'JSON'
		error: (json, textStatus, errorThrown) ->
			# $('body').append "AJAX Error: #{textStatus}"
			console.log("ajax error!: #{textStatus}")
		success: (data) ->
			#console.log(data)
			entries = data["feed"]["entry"]
			entries.map (entry) ->
				#console.log entry
				id = entry["id"]["$t"]
				#content = entry["link"][0] #[rel='alternate'][type='text/html']")
				#video = content.href
				video = entry["content"]["src"] #flash
				category = entry["category"][1]["term"]
				comment_info = entry["gd$comments"]["gd$feedLink"]
				comment_count = comment_info["countHint"]
				published = entry['published']["$t"]
				title = entry['title']["$t"]
				uploader = entry['author'][0]["name"]["$t"]
				media = entry["media$group"]
				description = media["media$description"]["$t"]
				thumb = media["media$thumbnail"]
				thumbnail = thumb[1]["url"] #["yt:name"="mqdefault"]
				duration = media["yt$duration"]["seconds"]
				views = entry["yt$statistics"]["viewCount"]
				likes    = entry["yt$rating"]["numLikes"]
				dislikes = entry["yt$rating"]["numDislikes"]
				rating = entry["gd$rating"]["average"]
				json = 
					videoId:		 id
					author:			 uploader
					category:	 	 category
					comment_count: 	 comment_count
					date: 			 published
					description:	 description
					duration:	 	 duration
					dislikes:		 dislikes
					likes:			 likes
					rating: 		 rating
					title:			 title
					thumbnail:		 thumbnail
					views:			 views
					videoUrl:		 video
				#console.log(json)
				display_video(json)
			watch_button_click()
	this 

video_renderer = () ->
	if renderer == undefined
		renderer = new Renderer(Handlebars.TEMPLATES["_film"])
	renderer 

display_video = (json) ->
	container = $(".videos-container")
	render = video_renderer()
	render.display(json, container)

#api_call()
$(document).ready ->
	pager = new Paginator(api_call) # registers the function to call
	pager.check()
	#pager.startScrolling()
	pager.fetch()
	true
	