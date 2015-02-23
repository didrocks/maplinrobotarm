// Move Robot Script
function move(grips,wrist,elbow,shoulder,base,led)
{
	$.ajax({
	    url: 'http://'+window.location.hostname+':8787/robot/move/'+grips+'/'+wrist+'/'+elbow+'/'+shoulder+'/'+base+'/'+led+'/false',
	    type: 'GET' 
	});
}
// Move Robot Script
function moveto(grips,wrist,elbow,shoulder,base)
{
	var led=0;
	if(document.getElementById('mtled').checked)
	{
	   led=2;
	}
	$.ajax({
	    url: 'http://'+window.location.hostname+':8787/robot/moveto/'+grips+'/'+wrist+'/'+elbow+'/'+shoulder+'/'+base+'/'+led,
	    type: 'GET' 
	});
}
