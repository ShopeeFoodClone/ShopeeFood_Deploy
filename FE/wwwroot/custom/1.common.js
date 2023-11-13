$(".dropdown-item").on("click", function () {
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
	$(".number-only").on("keydown", function (e) {
		// Only allow if the e.key value is a number or if it's 'Backspace'
		if (isNaN(e.key) && e.key !== 'Backspace' && e.key !== 'Tab') {
			e.preventDefault();
		}
	});
	/*For total*/
	$(".detail-cart").each(function () {
		$(this).on("input", ".quantity", function () {
			var price = +$(".price").data("price");
			var quantity = +$(this).val();
			$("#total").text("$" + price * quantity);
		})

		var $buttonPlus = $(this).find('.increase-btn');
		var $buttonMin = $(this).find('.decrease-btn');
		var $quantity = $(this).find('.quantity');

		/*For plus and minus buttons*/
		$buttonPlus.click(function () {
			$quantity.val(parseInt($quantity.val()) + 1).trigger('input');
		});

		$buttonMin.click(function () {
			$quantity.val(Math.max(parseInt($quantity.val()) - 1, 1)).trigger('input');
		});
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
	$(document).ready(function () {
		$(window).scroll(function () {
			var x = $(this).scrollTop();
			if (x - 50 > scrollVal) {
				$("header").removeClass("header-sticky")
				$("#back-top").css("opacity", "1");
			} else {
				$("header").addClass("header-sticky")
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