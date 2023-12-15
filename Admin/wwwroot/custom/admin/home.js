function LoadBar(data) {
	var xValues = [];
	var yValues = [];
	var barColors = []

	var color = "#ff9130";
	data.forEach((e) => {
		xValues.push(e.nameStore);
		yValues.push(e.numCart);
		barColors.push(color);
	});
	var date = new Date();
	var title = "Tổng đơn hàng của các cửa hàng trong hôm nay " + date.toLocaleDateString();
	new Chart("NumCarts", {
		type: "bar",
		data: {
			labels: xValues,
			datasets: [{
				backgroundColor: barColors,
				data: yValues
			}]
		},
		options: {
			legend: { display: false },
			title: {
				display: true,
				text: title
			},
			scales: {
				yAxes: [{
					display: true,
					stacked: true,
					ticks: {
						min: 0, // minimum value
						stepSize: 1
					}
				}]
			}
		}
	});
}
$(() => {
	_callAjax.cart.GetNumCartEachStore(function (data) {
		LoadBar(data)
		console.log(data)
	});
	const yValues = [];
	_callAjax.store.GetNumStoresByCity(localStorage.getItem("data-id-city"), function (data) {
		var num = data;
		yValues.push(num)
		_callAjax.store.GetNumBranchStoresByCity(function (data) {
			var numa = data;
			yValues.push(numa)
			LoadDonut(yValues);
		});
	});
});

function LoadDonut(yValues) {
	const xValues = ["Số cửa cửa hàng", "Số chi nhánh trong hệ thống"];
	const barColors = [
		"#f3b664",
		"#ec8f5e"
	];
	var title = "Thông tin chung về thành phố: " + $('#select-city').find(".dropdown-toggle").html();
	new Chart("infoCommon", {
		type: "doughnut",
		data: {
			labels: xValues,
			datasets: [{
				backgroundColor: barColors,
				data: yValues
			}]
		},
		options: {
			title: {
				display: true,
				text: title
			}
		}
	});
}