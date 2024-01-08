$(() => {
	handleUploadImages();
	$("#filterStore").submit(function (e) {
		e.preventDefault();
		_callAjax.store.FilterStoreAdmin($(this));
	});
	$("#slc-sort-by").on("change", function () {
		_callAjax.store.FilterStoreAdmin($("#filterStore"));
	});
	$("#dropdown-district-submit").on("click", function () {
		_callAjax.store.FilterStoreAdmin($("#filterStore"));
	});
	$("#slc-sort-status").on("change", function () {
		_callAjax.store.FilterStoreAdmin($("#filterStore"));
	});
	$("#formCreateStore").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.store.CreateStore($form);
	});
	$("#clearFilter").on("click", function () {
		_callAjax.store.ClearFilterStoreAdmin();
	});
	$(".slc-category").on("change", function () {
		var idCategoryConsumpType = $(this).find("option:selected").val();
		_callAjax.consumpType.GetConsumpTypesByCategory(idCategoryConsumpType, function (data) {
			$(".slc-consumpType").html(data);
			_callAjax.collection.GetCollectionByCategory(idCategoryConsumpType, function (data) {
				$(".slc-collection").html(data);
			});
		});
	});
	$("#formDeleteStore").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.store.DeleteStore($form.find("#id").val());
	});
	$("#formActiveStore").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.store.ActiveStore($form.find("#id").val());
	});
	$(".btn-delete").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalDeleteStore")
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
	$(".btn-active").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalActiveStore")
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
});