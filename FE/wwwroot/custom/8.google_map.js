

function calculateAndDisplayRoute(directionsService, directionsRenderer) {
	const selectedMode = "DRIVING";
	const origin2 = "@Model.Store.Address";
	const destinationA = "@Model.Information.Address";
	geocode({ address: origin2 }, function (data) {
		var origin = data;
		const origin1 = data;
		geocode({ address: destinationA }, function (data) {
			var destination = data;
			const destinationB = data;
			directionsService
				.route({
					origin: origin,
					destination: destination,
					travelMode: google.maps.TravelMode[selectedMode],
				})
				.then((response) => {
					directionsRenderer.setDirections(response);
					//
					calculatorDistance(origin1, origin2, destinationA, destinationB);
				})
				.catch((e) => console.log("Directions request failed due to " + status));
		});
	});
}

function calculatorDistance(origin1, origin2, destinationA, destinationB) {
	// build request
	const request = {
		origins: [origin1, origin2],
		destinations: [destinationA, destinationB],
		travelMode: google.maps.TravelMode.DRIVING,
		unitSystem: google.maps.UnitSystem.METRIC,
		avoidHighways: false,
		avoidTolls: false,
	};
	// get distance matrix response
	service.getDistanceMatrix(request).then((response) => {
		var distance = response.rows[0].elements[0].distance.text;
		var minutes = response.rows[0].elements[0].duration.text;
		var originAddresses = response.originAddresses[0]
		var destinationAddresses = response.destinationAddresses[1]
		$("#distance").html(distance)
		$("#minutes").html(minutes)
		//
		$("#origin").html("Từ: " + originAddresses)
		$("#destination").html("Đến: " + destinationAddresses)
	});
}

function geocode(request, callBack) {
	geocoder
		.geocode(request)
		.then((result) => {
			const { results } = result;
			var jsonString = JSON.stringify(results[0].geometry.location, null, 2);
			var jsonObject = JSON.parse(jsonString);
			callBack(jsonObject)
		})
		.catch((e) => {
			console.log("Geocode was not successful for the following reason: " + e);
		});
}
window.initMap = initMap;