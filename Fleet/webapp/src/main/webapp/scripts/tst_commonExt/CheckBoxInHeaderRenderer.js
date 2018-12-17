
dojo.declare("tavant.twms.summaryTableExt.CheckBoxInHeaderRenderer", null, {
	render : function(/*cell*/ th) {
		var elementMarkup = "<span ><input  name='masterCheckBox' id='masterCheckBox' type='checkbox' onclick='masterCheckBoxChecked(this)'></span>";
		th.innerHTML = elementMarkup;
	}
});