$(() => {
	handleUploadImages();
	$("#slc-category-consumptype").on("change", function () {
		var idCategory = $(this).find("option:selected").val();
		var url = '/Admin/Collection?IdCategoryConsumpType=' + idCategory
		RedirectToUrl(url);
	});
	$(".btn-edit").on("click", function () {
		var id = $(this).attr("data-id")
		_callAjax.collection.GetCollection(id, function (data) {
			var $modal = $("#modalUpdateCollection")
			$modal.find("#id").val(data.data.id)
			$modal.find("#title").val(data.data.title)
			$modal.find("#description").html(data.data.description)
			$modal.find("#image").attr("src", '/imgs/' + data.data.image)
			$modal.modal("show");
		})
	});
	$("#formUpdateCollection").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.collection.UpdateCollection($form);
	});
	$("#formCreateCollection").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.collection.CreateCollection($form);
	});
	$("#formDeleteCollection").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.collection.DeleteCollection($form.find("#id").val());
	});
	$("#formActiveCollection").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.collection.ActiveCollection($form.find("#id").val());
	});
	$(".btn-delete").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalDeleteCollection")
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
	$(".btn-active").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalActiveCollection")
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
});
