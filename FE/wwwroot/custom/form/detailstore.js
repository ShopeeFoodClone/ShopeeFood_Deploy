$(function () {
	$("#searchProduct").on("input", function () {
		var $divProducts = $("#partial-products");
		var searchText = $(this).val();
		_callAjax.store.SearchProduct(searchText, function (data) {
			$divProducts.html(data);
		});
	});
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
			$("#container-cart").on("input", ".quantity", function () {
				var quantity = $(this).val();
				var idProduct = $(this).attr("data-id-product")
				if (quantity > 0) {
					_callAjax.cart.UpdateDetailsCart(idProduct, quantity, function (res) {
						$("#container-cart").html(res);
						BuildInputPlusMinus();
					});
				}
			});
			$("#container-cart").on("click", "#btnClearCart", function () {
				_callAjax.cart.ClearCart();
			});
			$("#container-cart").on("click", ".btn-remove-details-cart", function () {
				var idProduct = $(this).attr('data-id-product')
				_callAjax.cart.RemoveDetailsCart(idProduct, function (res) {
					$("#container-cart").html(res);
					BuildInputPlusMinus();
				});
			});
			$(".btn-add-to-cart").on("click", function () {
				var id_product = $(this).attr("data-id-product");
				_callAjax.cart.AddToCart(id_product, function (res) {
					$("#container-cart").html(res);
					BuildInputPlusMinus();
				});
			});
		}
		else {
			$(".btn-add-to-cart").on("click", function () {
				ShowPopupFail("Vui lòng đăng nhập để đặt hàng", "Thông Báo");
			});
		}
	}
});

function BuildInputPlusMinus() {
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
}