$(function () {
	_configDatePicker.initDateMinus100Plus50($("#startDate"));
	_configDatePicker.initDateMinus100Plus50($("#endDate"));

	$(".quantity").on("input", function () {
		var quantity = $(this).val();
		var idProduct = $(this).attr("data-id-product")
		if (quantity > 0) {
			_callAjax.cart.UpdateDetailsCart(idProduct, quantity);
		}
	});

	$("#formConfirmOrder").submit(function (e) {
		e.preventDefault();
		var phoneNumber = $(this).find("#phoneNumber").val();
		var deliveryAddress = $(this).find("#address").val();
		_callAjax.cart.Order(phoneNumber, deliveryAddress);
	})

	$("#btn-statistic").on("click", function () {
		var $form = $("#statistic-filter");
		_callAjax.cart.FilterHistoryOrder($form);
	});
	$("#slc-status").on("change", function () {
		var $form = $("#statistic-filter");
		_callAjax.cart.FilterHistoryOrder($form);
	});
});