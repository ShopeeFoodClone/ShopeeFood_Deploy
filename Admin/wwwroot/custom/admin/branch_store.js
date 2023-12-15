$(() => {
	handleUploadImages();
	$("#filterBranchStore").submit(function (e) {
		e.preventDefault();
		_callAjax.branchStore.FilterBranchStore($(this));
	});
	$("#slc-sort-by").on("change", function () {
		_callAjax.branchStore.FilterBranchStore($("#filterBranchStore"));
	});
	$("#slc-sort-status").on("change", function () {
		_callAjax.branchStore.FilterBranchStore($("#filterBranchStore"));
	});
	$(".btn-edit").on("click", function () {
		var id = $(this).attr("data-id")
		_callAjax.branchStore.GetBranchStore(id, function (data) {
			var $modal = $("#modalUpdateBranchStore")
			$modal.find("#id").val(data.data.id)
			$modal.find("#title").val(data.data.name)
			$modal.find("#image").attr("src", '/imgs/' + data.data.image)
			$modal.modal("show");
		})
	});
	$("#formUpdateBranchStore").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.branchStore.UpdateBranchStore($form);
	});
	$("#formCreateBranchStore").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.branchStore.CreateBranchStore($form);
	});

	$("#formDeleteBranchStore").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.branchStore.DeleteBranchStore($form.find("#id").val());
	});

	$("#formActiveBranchStore").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.branchStore.ActiveBranchStore($form.find("#id").val());
	});
	$(".btn-delete").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalDeleteBranchStore")
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
	$(".btn-active").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalActiveBranchStore")
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
});