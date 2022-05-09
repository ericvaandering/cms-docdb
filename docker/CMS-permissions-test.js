/* 
TODO: can we figure out what actual egroups the user is in?
*/

/* add exact contains matching */
jQuery.expr[":"].econtains = function(obj, index, meta, stack){
return (obj.textContent || obj.innerText || $(obj).text() || "").toLowerCase() == meta[3].toLowerCase();
}



/* Now replace select with a radio control */
function createRadioButton(elm, value_txt, title, selected_shortName){
  var name = elm+"_radio";
  /* get the group ID by title */
  var active_option = jQuery('select[name='+elm+'] option:econtains('+value_txt+')');
  var value = active_option.val();
  var extra = (active_option.text() == selected_shortName)?' checked="checked" ':'';

  var input = jQuery('<div><input style="border: none" type="radio" name="'+name+'" id="'+name+'_'+value+'" value="'+value+'" '+extra+'/><label for="'+name+'_'+value+'">'+title+'</label></div>');
 /* set up a event handler to set the actual select which will be hidden */
  return input;
}

function createRadioList(elm, choices, container){

	var cont = jQuery('<div id="' + elm + '-radios" style="width:200px"></div>');
	var sel_opt =  jQuery('select[name='+elm+'] option:selected').first();
	var sel_shortName = sel_opt.text();

	if (sel_shortName ==''){
		sel_shortName = 'CMS';
	}
	
        //console.log(sel_opt.text());
	/* is the selected Permission in  Short list (All, CMS, Physics) ? */
	if (sel_shortName in choices){

	
		        //console.log(choices);
		jQuery.each(choices, function(shortName, title){			
		        //console.log(shortName, title);
			cont.append(createRadioButton(elm, shortName, title, sel_shortName));
		});





		/* handle the onchange event so this control  the initial element */
		cont.find('input[name='+elm+'_radio]').change(function(){
		    var value = jQuery('input[name='+elm+'_radio]:checked').first().val();
		    //console.log(value);
		    jQuery('select[name='+elm+']').val(value).change();
		});
		/* hide the old control  */
		jQuery('select[name='+elm+']').hide();
	}
	container.append(cont);

	/* show notice if a different value was selected than the defaults. show it the first time too.. */
	container.append(jQuery('<div id="' + elm + '-perm-error" class="permission-error-message" style="display:none;background-color:#f9f9f9;width:185px;border: 1px solid #eee;-moz-border-radius: 5px; -webkit-border-radius: 5px; padding: 4px;"><span class="perm-error-attention" style="color:#d33;font-weight: bold;">Attention:</span> If you are not in <span class="perm-group">Physics</span> group you will NOT be able to access this document<span class="physics-perm-error">, even if you are physicist. For instance, Tracker and Offline is not Physics</span>.</div>'));

	container.find('select[name='+elm+']').change(function(){
    	    var error_msg = jQuery('#' + elm + '-perm-error');
	    var sel_opt =  jQuery('select[name='+elm+'] option:selected').first();	
   
	    if (!(sel_opt.text() in choices) || sel_opt.text() == 'Physics'){
		/* set the group name in error message to the currently selected one */
	    	error_msg.find("span.perm-group").text(sel_opt.text());
		var physics_error = error_msg.find("span.physics-perm-error");
		/* provide specific error for Physics */
		if (sel_opt.text() == 'Physics') 
			physics_error.show();
		else physics_error.hide();

        	error_msg.show();
	    } else {
        	error_msg.hide();
	   }
	}).change(); 


/* add the new radios driven control */

	if (sel_shortName in choices){
		/* add a toggle button */
		container.append(jQuery('<div class="permission-advanced-toggle" />').append(
				jQuery('<a class="perm-switch" style="color:#999">advanced</a>').click(function(){
			 		jQuery('select[name='+elm+'],div#'+elm+'-radios').toggle(); 
					var show_less ='show less';
					jQuery(this).text(
						(jQuery(this).text() == show_less)?'advanced':show_less
					);
					/* if we've just displayed the simple mode make sure the value gets updated and a valid value gets selected otherwise select the Default (CMS) */
					if (jQuery('div#'+elm+'-radios').is(":visible")){
						var sel_opt =  jQuery('select[name='+elm+'] option:selected').first();	

						if (!(sel_opt.text() in choices)) {
							var cms_value = jQuery('select[name='+elm+'] option:econtains(CMS)').val();
							//console.log(cms_value, sel_opt.text(), choices);
							jQuery('div#'+elm+'-radios input[name='+elm+'_radio]').val([cms_value]); //We need a good setter!
							jQuery('div#'+elm+'-radios input[name='+elm+'_radio]').change();
						} else {
							jQuery('div#'+elm+'-radios input[name='+elm+'_radio]').val([sel_opt.val()]); //We need a good setter!
						}
					}
				})
		));
	} // end add toggle if in choices

}


function CmsTransformPermissions(){
	var view_td = jQuery("select[name=security]").parents("td").first();
	var modify_td = jQuery("select[name=modify]").parents("td").first();

	view_td.find("strong>a").text('Who can see this?');
	modify_td.find("strong>a").text('Who can modify this?');

	/* view permission */
	var security_choices  = {
	'Public': 'The whole world',
	'CMS': 'All CMS people',
	'Physics': 'Only CMS Physicists'
	};
	createRadioList('security', security_choices, view_td);
	/* modify permission */
	var modify_choices  = {
	'CMS': 'All CMS people',	
	'Physics': 'Only CMS Physicists'
	};
	createRadioList('modify', modify_choices, modify_td);
}

//CmsTransformPermissions();
