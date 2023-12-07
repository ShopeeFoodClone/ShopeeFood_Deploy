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
	$(".btn-paynow").on("click", function () {
		var phoneNumber = $("#formConfirmOrder").find("#phoneNumber").val();
		var deliveryAddress = $("#formConfirmOrder").find("#address").val();
		if (phoneNumber == "" || deliveryAddress == "") {
			ShowPopupFail("Vui lòng nhập thông tin đầy đủ");
			return;
		}
		var paymentType = $(this).attr("data-payment-type");
		_callAjax.cart.Order(phoneNumber, deliveryAddress, paymentType);
	});
	$("#formConfirmOrder").submit(function (e) {
		e.preventDefault();
	})

	$("#btn-statistic").on("click", function () {
		var $form = $("#statistic-filter");
		_callAjax.cart.FilterHistoryOrder($form);
	});
	$("#slc-status").on("change", function () {
		var $form = $("#statistic-filter");
		_callAjax.cart.FilterHistoryOrder($form);
	});

	$("#slc-sort").on("change", function () {
		var $form = $("#statistic-filter");
		_callAjax.cart.FilterHistoryOrder($form);
	});
});