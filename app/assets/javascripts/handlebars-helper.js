Handlebars.registerHelper('as_date', function(date_string) {
	var data = date_string.split("T")
    var str = data[0].split("-").reverse().join("/")
    return new Handlebars.SafeString(str);
});