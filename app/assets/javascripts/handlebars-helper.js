Handlebars.registerHelper('as_date', function(date_string) {
	var data = date_string.split("T")
    var str = data[0].split("-").reverse().join("/")
    return new Handlebars.SafeString(str);
});

Handlebars.registerHelper('seconds_to_time', function(seconds) {
	var total = typeof(seconds) == "string" ? parseInt(seconds) : seconds
	var secs = total % 60
	total -= secs
	total /= 60
	var mins = total % 60
	total -= mins
	total /= 60
	var hours = total 
    var str = ""
    if(hours > 0){
    	str = hours + ":"
    	if(mins < 10){
    		str += "0" + mins + ":"
    	}
    }
    if(mins > 0){
		str += mins + ":"	
    }
    if(secs < 10){
    	str += "0" + secs
    }	
    else{
    	str+= secs
    }
    return new Handlebars.SafeString(str);
});

Handlebars.registerHelper('iluminate', function(a, b) {
    s1 = parseInt(a)
    s2 = parseInt(b) + 0.5
    //s2 = parseInt(b)
    //s3 = s2 - s1 
    str = s1 <= s2 ? "active" : ""
    return new Handlebars.SafeString(str);
});