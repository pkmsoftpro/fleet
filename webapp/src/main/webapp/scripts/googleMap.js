/**
 * Added for Google Map API
 */

function openMap() {
	dijit.byId("displayGoogleMap").show();
}

function closeMap() {
	dojo.byId("travel_location").value = dojo.byId("formatedAddress").innerHTML;
	dijit.byId("displayGoogleMap").hide();
		calculateDistances();
}

function calculateDistances() {
	var service = new google.maps.DistanceMatrixService();
	var origin = dojo.byId("servicing_location_id").value.split(",");
	var destination = document.getElementById('formatedAddress').innerHTML;
	service.getDistanceMatrix({
		origins : origin,
		destinations : [ destination ],
		travelMode : google.maps.TravelMode.DRIVING,
		unitSystem : google.maps.UnitSystem.IMPERIAL,
		avoidHighways : false,
		avoidTolls : false
	}, callback);
}

function callback(response, status) {
	if (status == google.maps.DistanceMatrixStatus.OK) {
		var shortestDistance = null;
		var travelHours = null;
		dojo.forEach(response.rows, function(row) {
			if(row.elements[0].distance !=null)
			{
			var distance = row.elements[0].distance.value;
			if (shortestDistance == null || distance < shortestDistance) {
				shortestDistance = distance;
				travelHours=row.elements[0].duration.value;
			}
			}
		});
		if(dojo.byId("travel_distance"))
			dojo.byId("travel_distance").value = shortestDistance * 0.00062137119;
		if(dojo.byId("travel_hours"))
			dojo.byId("travel_hours").value = travelHours * 0.0166667;
	}
}