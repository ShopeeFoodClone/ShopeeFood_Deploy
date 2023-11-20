﻿$(".dropdown-item").on("click", function () {
	var nameCity = $(this).find(".dropdown-item-value").html();
	var id = $(this).find(".dropdown-item-value").attr("data-id-city");
	var $dropdown_display = $(this).parent().parent().find(".dropdown-toggle");
	//$dropdown_display.html(nameCity);
	//$dropdown_display.attr("data-id-city", id);
	// set local storage
	localStorage.setItem("data-id-city", id);
	localStorage.setItem("data-name-city", nameCity);
	var url = `/?idCity=${id}`;
	RedirectToUrl(url);
});
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
	var div = document.createElement('div');
	div.classList.add("loading");
	document.body.appendChild(div);
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
			});
			$districts.on("change", function () {
				$wards = $(".slc-wards");
				var idDistricts = $districts.find("option:selected").val();
				_callAjax.common.LoadWards(idDistricts, function (data) {
					$wards.html(data);
				});
			});
		});
	}

	// handle input enter only digit
	$(".number-only").on("keydown", function (e) {
		// Only allow if the e.key value is a number or if it's 'Backspace'
		if (isNaN(e.key) && e.key !== 'Backspace' && e.key !== 'Tab' && e.key !== 'Ctrl') {
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

	var scrollableElement = document.body; // document.getElementById('scrollableElement');
	var header = $("header");
	var recommend = $("#recommend");

	scrollableElement.addEventListener('wheel', function (event) {
		// Kiểm tra xem sự kiện scroll có xuất phát từ dropdown list hay không
		var isDropdownScroll = header.has(event.target).length > 0 || recommend.has(event.target).length > 0;

		if (!isDropdownScroll) {
			var isScrollingUp = checkScrollDirectionIsUp(event);
			if (isScrollingUp) {
				header.addClass("header-sticky");
			} else {
				header.removeClass("header-sticky");
			}
		}
	});

	function checkScrollDirectionIsUp(event) {
		if (event.wheelDelta) {
			return event.wheelDelta > 0;
		}
		return event.deltaY < 0;
	}
	// handle scroll down
	var scrollVal = 0;
	$(document).ready(function () {
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
});
function HideAllModal() {
	$(".modal").modal("hide");
}