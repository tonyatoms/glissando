var x = 2;
var y = 4;

function calculatePayment() {

    var elem = document.getElementById("output");

    var agi = document.getElementById("agi").value;

    if(agi) {
	//TODO more validation - needs to be a positive number 
    	
	setTextContent(elem, 'Suggested Payment: '+x+' goats and '+agi+' shiny objects.');   
    }else {
	alert('Please supply an Adjusted Gross Income');
    }	
}

function setTextContent(element, text) {
    while (element.firstChild!==null)
        element.removeChild(element.firstChild); // remove all existing content
    element.appendChild(document.createTextNode(text));
}
