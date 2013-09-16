function Renderer(_template){  
  var source;
  if(typeof(_template)=="string"){
     source = $(_template).html();
  }
  else{
    source = _template.html();
  }
  
  this.template = Handlebars.compile(source);;
  
  this.display = function(json, container){
    var html = this.template(json);
    //$(container).append(html)
    console.log(html)
    $(html).appendTo(container)
  }
}
