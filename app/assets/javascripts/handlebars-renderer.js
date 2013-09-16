function Renderer(_template){  
  if(typeof(_template)=="string"){
    _template = this.buildTemplate(_template);
  }
  this.template = _template;
  
  buildTemplate = function(source_container){
    return this.buildTemplate(source_container);
  }
  buildTemplate = function(source_container){
    var source;
    if(typeof(source_container)=="string"){ 
      source = $(source_container).html();
    }else{
      source = source_container.html();
    }
    return Handlebars.compile(source);
  }

  this.display = function(json, container){
    var html = this.template(json);
    $(container).append(html)
  }
}
