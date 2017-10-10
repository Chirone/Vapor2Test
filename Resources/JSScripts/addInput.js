var counter = 1;

function addInput(divName) {
	var newdiv = document.createElement('div');
	newdiv.innerHTML = "Variable name " + (counter + 1) + "<br><input type='text' name='variables[]'>";
	document.getElementById(divName).appendChild(newdiv);
	counter++;
}
