$(function () {

	var $check = $("#closed");
	if ($check.length > 0) {
		$('#modalAlertClosed').modal("show");
		$("#container-products").find('a').each(function () {
			$(this).removeAttr("href");
			$(this).unbind("onclick");
			$(this).on("click", function () {
				$('#modalAlertClosed').modal("show");
			})
		})
	}
	else {
		var $isLogin = $("#isLogin");
		if ($isLogin.length > 0) {
			$(".btn-add-to-cart").on("click", function () {
				var id_product = $(this).attr("data-id-product");
				_callAjax.cart.AddToCart(id_product);
			});
		}
		else {
			$(".btn-add-to-cart").on("click", function () {
				ShowPopupFail("Vui lòng đăng nhập để đặt hàng", "Thông Báo");
			});
		}
	}
});