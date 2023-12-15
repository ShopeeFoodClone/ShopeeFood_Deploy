$(() => {
	$(".btn-edit").on("click", function () {
		var id = $(this).attr("data-id")
		_callAjax.consumpType.GetConsumpType(id, function (data) {
			var $modal = $("#modalUpdateConsumpType")
			$modal.find("#id").val(data.data.id)
			$modal.find("#title").val(data.data.title)
			$modal.modal("show");
		})
	});
	$("#formUpdateConsumpType").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.consumpType.UpdateConsumpType($form);
	});
	$("#formCreateConsumpType").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.consumpType.CreateConsumpType($form);
	});

	$("#formDeleteConsumpType").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.consumpType.DeleteConsumpType($form.find("#id").val());
	});
	$(".btn-delete").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalDeleteConsumpType")
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
});
