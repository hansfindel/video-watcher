function Paginator(data, fn){
	if(data==undefined || data==null){
		data = {}
	}
	per_page = function(){return 10;}
	get_page = function(){
		return $("article").length / per_page() + 1
	}
	get_data = function(){
		page =  get_page()
		start = (page - 1) * per_page() + 1
		info = {
			"start-index": start
		}
		return info;
	}
	this.fetch = function(){
		//this.stopScrolling()
		console.log("con this")
		self = this;

		this.data = get_page();
		console.log(this.data)
		fn(this.data)
		
	}
	fetch = function(){
		//stopScrolling()
		//console.log("sin this")		
		info = get_data()
		fn(info)
	}
	
	nearBottom = function(){
		if(window.length > 0){
			//console.log($(window).scrollTop(), " - " ,$(".videos-container").height())
			return $(window).scrollTop() > $(".videos-container").height() - 1000;
		}else{
			return false;
		}
	}
	this.check = function(){
		//console.log("checking. . .")
		if(nearBottom()){
				console.log("fetching...")
				//this.fetch();
				fetch();
		}
		self = this;
		setTimeout(function(){ 
			self.check();
		}, 1000)
	}
}
