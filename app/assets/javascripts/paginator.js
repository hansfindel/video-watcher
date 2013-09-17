function Paginator(fn){
	per_page = function(){return 10;}
	get_page = function(){
		return $("article").length / per_page() + 1
	}
	get_data = function(){
		page =  get_page()
		start = (page - 1) * per_page() + 1
		query = $(".videos-container").data("q")
		info = {
			"start-index": start
		}
		if(query!=""){
			info["q"] = query;
		}
		return info;
	}
	this.fetch = function(){
		//this.stopScrolling()
		data = get_page();
		fn(data)
	}
	fetch = function(){
		info = get_data()
		fn(info)
	}
	
	nearBottom = function(){
		if(window.length > 0){
			//console.log($(window).scrollTop(), " - " ,$(".videos-container").height())
			var l = $(".videos-container").data("l")
			if(l == "false"){
				$(".videos-container").data("l", "true")
				return $(window).scrollTop() > $(".videos-container").height() - 1000;	
			}
			else{
				$(".videos-container").data("l", "false")
				return false;
			}
		}else{
			return false;
		}
	}
	this.check = function(){
		//console.log("checking. . .")
		if(nearBottom()){
				//console.log("fetching...")
				fetch();
		}
		self = this;
		setTimeout(function(){ 
			self.check();
		}, 1000)
	}
}
