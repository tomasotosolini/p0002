

function toggle_explaincheck(check, explain){
	var c = $(check);
	var e = $(explain);

	if( c.checked  ){
		e.style.display = 'block';
	}
	else {
		e.style.display = 'none';
	}
}
 
function toggle_checkcontrolleditem(check, controlleditem){
	var c = $(check);
	var ci = $(controlleditem);

	if( c.checked  ){
		ci.style.display = 'block';
	}
	else {
		ci.style.display = 'none';
	}
}





function clonable_group_remove_form3(hidden, group, num) {

	list = $(hidden).value.split(',');


	for ( i=0; i < list.length ; i++) {
		if (list[i] == num) {
			list.splice(i,1)
			$(hidden).value = list.join(',');
			Element.remove(group)
			return false;
		}
	}


}

function toggle_select_explain(seii, explain_options, val) {

    var el = $(seii); 
    if(explain_options.indexOf(val) > -1){ 
        el.setStyle({ display: 'block' });
    } else {
        el.setStyle({ display: 'none' });
    }
    return true;

}









function file_upload_monitor(target_file_upload_process) {

//     // make an ajax request to understand the upload process' status
// 
// 
//     req = new Ajax.Request(target_file_upload_process, 
//         {asynchronous:true, evalScripts:true});
// 
//     sleep(1);
// 
//     s = req.evalResponse();
// 
// alert(s)
// 
//     switch ( s ) {
// 
//         case 'processing' :
// 
//             setTimeout( 'file_upload_monitor(\''+ target_file_upload_process + '\');', 1000 );
// 
//             break;
// 
//         case 'success' :
//             // make an ajax request to change the file description in the form
//             break;
//     
//         default:
//             // nothing to do
// 
//     }

}











/**
*
*  AJAX IFRAME METHOD (AIM)
*  http://www.webtoolkit.info/
*
**/

AIM = {

	frame : function(c) {
		var n = 'f' + Math.floor(Math.random() * 99999);
		var d = document.createElement('DIV');
		d.innerHTML = '<iframe style="display:none" src="about:blank" id="'+n+'" name="'+n+'" onload="AIM.loaded(\''+n+'\')"></iframe>';
		document.body.appendChild(d);

		var i = document.getElementById(n);

		return n;
	},

	form : function(f, name) {
		f.setAttribute('target', name);
	},

	submit : function(f, c) {
		AIM.form(f, AIM.frame(c));
        f.submit();
        return true;
	},

	loaded : function(id) {
		var i = document.getElementById(id);
		if (i.contentDocument) {
			var d = i.contentDocument;
		} else if (i.contentWindow) {
			var d = i.contentWindow.document;
		} else {
			var d = window.frames[id].document;
		}
// 		if (d.location.href == "about:blank") {
// 			return;
// 		}

        eval($A(d.body.childNodes)[0].innerHTML);
	}


}








