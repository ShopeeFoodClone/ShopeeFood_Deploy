$(function () {
	// Search product
	$('#searchProduct').on('change', function () {
		var $divProducts = $("#partial-products");
		var searchText = $(this).val();
		SearchProduct($divProducts, searchText);
	});
	$('#searchProduct').on('input', function () {
		$(this).data('unsaved', true);
		clearTimeout(this.delayer);
		var context = this;
		this.delayer = setTimeout(function () {
			jQuery(context).trigger('change');
		}, 1000);
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
			BuildInputPlusMinus();
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
					$("#toastAddToCart").find("#toastContent").html("Đã xóa khỏi giỏ hàng");
					$("#toastAddToCart").toast("show");
					$("#container-cart").html(res);
					BuildInputPlusMinus();
				});
			});

			$("#partial-products").on("click", ".btn-add-to-cart", function () {
				var id_product = $(this).attr("data-id-product");
				_callAjax.cart.AddToCart(id_product, function (res) {
					$("#toastAddToCart").find("#toastContent").html("Đã thêm vào giỏ hàng");
					$("#toastAddToCart").toast("show");
					$("#container-cart").html(res);
					BuildInputPlusMinus();
				});
			});
		}
		else {
			$("#partial-products").on("click", ".btn-add-to-cart", function () {
				ShowPopupFail("Vui lòng đăng nhập để đặt hàng. <a href='/auth/login'>Đăng nhâp ngay</a>", "Thông Báo");
			});
		}
	}
});
function SearchProduct($divProducts, searchText) {
	_callAjax.store.SearchProduct(searchText, function (data) {
		$divProducts.html(data);
	});
}
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