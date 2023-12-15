$(() => {
	handleUploadImages();
	$(".btn-edit-product").on("click", function () {
		var $modal = $("#modalUpdateProduct");
		var id = $(this).attr("data-id-product");
		_callAjax.store.GetProduct(id, function (data) {
			$modal.find("#id").val(data.id);
			$modal.find("#idCategoryProduct").val(data.idCategoryProduct);
			$modal.find("#img-product").attr("src", "/imgs/" + data.image);
			$modal.find("#price").val(data.price);
			$modal.find("#name").val(data.name);
			$modal.find("#description").val(data.description);
			$modal.modal("show");
		});
	});
	$(".btn-delete-product").on("click", function () {
		var $modal = $("#modalDeleteProduct");
		var id = $(this).attr("data-id-product");
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
	$(".btn-active-product").on("click", function () {
		var $modal = $("#modalActiveProduct");
		var id = $(this).attr("data-id-product");
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
	$("#formUpdateProduct").submit(function (e) {
		e.preventDefault();
		_callAjax.store.UpdateProduct($(this));
	});
	$("#formDeleteProduct").submit(function (e) {
		e.preventDefault();
		_callAjax.store.DeleteProduct($(this).find("#id").val());
	});
	$("#formActiveProduct").submit(function (e) {
		e.preventDefault();
		_callAjax.store.ActiveProduct($(this).find("#id").val());
	});
	$("#filterProduct").submit(function (e) {
		e.preventDefault();
		_callAjax.store.FilterProduct($(this));
	});
	$("#slc-sort-by").on("change", function () {
		_callAjax.store.FilterProduct($("#filterProduct"));
	});
	$("#slc-sort-stores").on("change", function () {
		_callAjax.store.FilterProduct($("#filterProduct"));
	});
	$("#slc-sort-status").on("change", function () {
		_callAjax.store.FilterProduct($("#filterProduct"));
	});
	$("#clearFilter").on("click", function () {
		_callAjax.store.ClearFilterProduct();
	});
	// slider call
	var max = parseInt($('#maxPriceFirst').val());
	var max_value = parseInt($('#maxPrice').val());
	var min_value = parseInt($('#minPrice').val());
	$('#slider').slider({
		range: true,
		step: 1000,
		min: 0,
		max: max,
		values: [min_value, max_value],
		slide: function (event, ui) {
			$("#minPrice").val(ui.values[0]);
			$("#maxPrice").val(ui.values[1]);
			var min = ui.values[0].toLocaleString('it-IT', { style: 'currency', currency: 'VND' });
			var max = ui.values[1].toLocaleString('it-IT', { style: 'currency', currency: 'VND' })
			$('.ui-slider-handle:eq(0) .price-range-min').html(min);
			$('.ui-slider-handle:eq(1) .price-range-max').html(max);
			$('.price-range-both').html('<i>' + min + ' - </i>' + max);
		}
	});

	$('.ui-slider-range').append('<span class="price-range-both value"><i>' + $('#slider').slider('values', 0).toLocaleString('it-IT', { style: 'currency', currency: 'VND' }) + ' - </i>' + $('#slider').slider('values', 1).toLocaleString('it-IT', { style: 'currency', currency: 'VND' }) + '</span>');

	$('.ui-slider-handle:eq(0)').append('<span class="price-range-min value">' + $('#slider').slider('values', 0).toLocaleString('it-IT', { style: 'currency', currency: 'VND' }) + '</span>');

	$('.ui-slider-handle:eq(1)').append('<span class="price-range-max value">' + $('#slider').slider('values', 1).toLocaleString('it-IT', { style: 'currency', currency: 'VND' }) + '</span>');
})