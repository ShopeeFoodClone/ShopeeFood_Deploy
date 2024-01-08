function FormatStringToGeneral(str) {
	str = str.toLowerCase();
	str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
	str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
	str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
	str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
	str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
	str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
	str = str.replace(/đ/g, "d");
	return str;
}
function ShowPopupSuccess(message, title) {
	var $modal = $('#modalAPI');
	$modal.find('.modal-title').html(title ?? "Thành công")
	$modal.find('.modal-text').html(message ?? "Thành công")
	$modal.modal("show");
}

function ShowPopupFail(message, title) {
	var $modal = $('#modalAPI');
	$modal.find('.modal-title').html(title ?? "Thất bại")
	$modal.find('.modal-text').html(message ?? "Thất bại")
	$modal.modal("show");
}
function RedirectToUrl(res) {
	window.location.href = res.url ?? res
}
function AppendLoading() {
	if ($('body').find(".loading").length == 0) {
		var div = document.createElement('div');
		div.classList.add("loading");
		document.body.appendChild(div);
	}
}
function RemoveLoading() {
	const loader = document.querySelector(".loading")
	loader.classList.add("loading-hidden")
	loader.addEventListener("transitionend", () => {
		setTimeout(function () {
			try {
				const load = document.querySelector(".loading")
				document.body.removeChild(load);
			} catch (e) {
			}
		}, 500);
	});
}
$(function () {
	$('.dropdown-menu').click(function (e) {
		if ($(e.target).is(':checkbox')) {
			return true;
		}
		if ($(e.target).is('form')) {
			return true;
		}
		if ($(e.target).is('button')) {
			return true;
		}
		if ($(e.target).is('a')) {
			return true;
		}
		e.preventDefault();
		e.stopImmediatePropagation();
		return false;
	});

	// sort table
	$('.th-sort').click(function () {
		var table = $(this).parents('table').eq(0)
		var type = $(this).attr("type-sort")
		var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index(), type))
		this.asc = !this.asc
		if (!this.asc) { rows = rows.reverse() }
		for (var i = 0; i < rows.length; i++) { table.append(rows[i]) }
	})
	function comparer(index, type) {
		return function (a, b) {
			var valA = getCellValue(a, index, type), valB = getCellValue(b, index, type)
			return compareValues(valA, valB);
		}
	}
	function compareValues(valA, valB) {
		if ($.isNumeric(valA) && $.isNumeric(valB)) {
			return valA - valB;
		} else {
			const dateA = stringToDate(valA);
			const dateB = stringToDate(valB);
			if (!isNaN(dateA) && !isNaN(dateB)) {
				return dateA - dateB;
			} else {
				return valA.toString().localeCompare(valB);
			}
		}
	}
	function stringToDate(dateString) {
		try {
			let dateParts = dateString.split(/\/|\s|:/); // Split by "/", " ", or ":"
			let year = parseInt(dateParts[2], 10);
			let month = parseInt(dateParts[1], 10) - 1; // Months are 0-based in JavaScript Date
			let day = parseInt(dateParts[0], 10);
			let hours = parseInt(dateParts[3], 10);
			let minutes = parseInt(dateParts[4], 10);

			let dateObject = new Date(year, month, day, hours, minutes);
			return dateObject;
		} catch (e) {
			return '';
		}
	}

	function getCellValue(row, index, type) {
		var $row_selectd = $(row).children('td').eq(index).find(".value-td");
		var value = $row_selectd.text().trim();
		if (type == "number")
			value = parseInt(value.replace(/[^\d]/g, ''), 10);
		return value
	}

	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		return new bootstrap.Tooltip(tooltipTriggerEl)
	})
	$(".dropdown-item").on("click", function () {
		var nameCity = $(this).find(".dropdown-item-value").html();
		var id = $(this).find(".dropdown-item-value").attr("data-id-city");
		var $dropdown_display = $(this).parent().parent().find(".dropdown-toggle");
		//$dropdown_display.html(nameCity);
		//$dropdown_display.attr("data-id-city", id);
		// set local storage
		localStorage.setItem("data-id-city", id);
		localStorage.setItem("data-name-city", nameCity);
		if ($(this).attr("data-admin") == 'true') {
			var url = `/Admin/Home/Index?idCity=${id}`;
		}
		else {
			var url = `/?idCity=${id}`;
		}
		RedirectToUrl(url);
	});
	// Handle scroll direction
	var lastScrollTop = 0;
	var header = $("header");
	$(window).scroll(function () {
		var st = window.pageYOffset || document.documentElement.scrollTop;
		if (st > lastScrollTop) { // Scroll down
			header.removeClass("header-sticky");
		} else if (st < lastScrollTop) { // scroll top
			header.addClass("header-sticky");
		}
		lastScrollTop = st <= 0 ? 0 : st;
	});

	// Handle provinces select
	if ($(".slc-cities").length > 0) {
		var $cities = $(".slc-cities");
		_callAjax.common.LoadCities(function (data) {
			$cities.html(data);
		});

		$cities.on("change", function () {
			$districts = $(".slc-districts");
			var idCity = $cities.find("option:selected").val();
			_callAjax.common.LoadDistricts(idCity, function (data) {
				$districts.html(data);

				// Remove existing "change" event handlers on districts
				$districts.off("change");

				$districts.on("change", function () {
					console.log("district call api");
					$wards = $(".slc-wards");
					var idDistricts = $districts.find("option:selected").val();
					_callAjax.common.LoadWards(idDistricts, function (data) {
						$wards.html(data);
					});
				});
			});
		});
	}

	// handle input enter only digit
	$(".number-only").on("keydown", function (e) {
		// Only allow if the e.key value is a number or if it's 'Backspace'
		if (isNaN(e.key) && e.key !== 'Backspace' && e.key !== 'Tab' && e.key !== 'Ctrl' && e.key !== 'ArrowLeft' && e.key !== 'ArrowRight') {
			e.preventDefault();
		}
	});
	//loading
	const loader = document.querySelector(".preload")
	loader.classList.add("loading-hidden")
	loader.addEventListener("transitionend", () => {
		setTimeout(function () {
			try {
				const load = document.querySelector(".preload")
				document.body.removeChild(load);
			} catch (e) {
			}
		}, 500);
	});
	// dropdown city header
	//var id = localStorage.getItem("data-id-city");
	//var nameCity = localStorage.getItem("data-name-city");
	//var $slc_city = $('#select-city').find('.dropdown-toggle');
	//$slc_city.html(nameCity)
	//$slc_city.attr('data-id-city', id);
	// Search in header
	$("#formSearchHeader").submit(function (e) {
		e.preventDefault();
		var searchText = $(this).find("#searchText").val();
		_callAjax.store.Search(searchText);
	})

	// handle scroll down
	var scrollVal = 0;
	$(window).scroll(function () {
		var x = $(this).scrollTop();
		if (x - 50 > scrollVal) {
			$("#back-top").css("opacity", "1");
		} else {
			$("#back-top").css("opacity", "0");
		}
	});
	$("#back-top").click(function () {
		$("html, body").animate({
			scrollTop: 0,
		},
			0
		);
	});
});
function HideAllModal() {
	$(".modal").modal("hide");
}