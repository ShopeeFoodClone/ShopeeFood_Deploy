
$(() => {
	$(".btn-edit").on("click", function () {
		var id = $(this).attr("data-id")
		_callAjax.consumpType.GetCategoryConsumpType(id, function (data) {
			var $modal = $("#modalUpdateCategoryConsumpType")
			$modal.find("#id").val(data.data.id)
			$modal.find("#title").val(data.data.title)
			$modal.modal("show");
		})
	});
	$("#formUpdateCategoryConsumpType").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.consumpType.UpdateCategoryConsumpType($form);
	});
	$("#formCreateCategoryConsumpType").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.consumpType.CreateCategoryConsumpType($form);
	});

	$("#formDeleteCategoryConsumpType").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.consumpType.DeleteCategoryConsumpType($form.find("#id").val());
	});
	$(".btn-delete").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalDeleteCategoryConsumpType")
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
});
