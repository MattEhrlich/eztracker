//Grabs alert-message's and auto-closes them after 2.5 seconds.
$("#alert-message").alert();
window.setTimeout(function() { $("#alert-message").alert('close'); }, 4500);
//-----End------