var paper=null;
var circle = [];
function startit() {
	
	paper = Raphael(document.getElementById('intro'), 0, 0, 220, 100);
		// Creates circle at x = 50, y = 40, with radius 10
    var i = 0;
    paper.setSize(220,200);
    paper.rect(0, 0, 220,200, 10).attr({"fill": "grey", "fill-opacity":0.25});
    
    var mytext = paper.text(80,30,"");
	for ( i=0;i<30;i++) {
	    circle[i] = paper.circle(250*Math.random(), 200*Math.random(), 20*Math.random());
		// Sets the fill attribute of the circle to red (#f00)
		circle[i].attr("fill", "#f00");
		 circle[i].attr({
      "fill": "90-#f00:5-#00f:95",
      "fill-opacity": 0.5
    });
		// Sets the stroke attribute of the circle to white
		circle[i].attr("stroke", "#fff"); 
		circle[i].hover(function() {
			 
			 mytext.attr('text',this.attr('cx'));
			}, null);
	}
	
	//paper.rect(0, 0, 320,200, 10).attr({"fill": "grey", "fill-opacity":0.25});
}
function kaboom() {
	// Creates circle at x = 50, y = 40, with radius 10
	for ( i=0;i<30;i++) {
		
		var anim = Raphael.animation({cx: Math.random()*250, cy: Math.random()*200}, 3000);
		circle[i].animate(anim); // run the given animation immediately
	
	}
	
}

function redraw() {
	//paper.clear();
	kaboom();
}
