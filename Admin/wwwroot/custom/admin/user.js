$(() => {
	$("#formDeleteUser").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.auth.DeleteUser($form.find("#id").val());
	});
	$("#formActiveUser").submit(function (e) {
		e.preventDefault();
		var $form = $(this);
		_callAjax.auth.ActiveUser($form.find("#id").val());
	});
	$(".btn-delete").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalDeleteUser")
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
	$(".btn-detail").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalDetailUser")
		_callAjax.auth.GetUser(id, function (res) {
			const optionsDMYHM = {
				day: '2-digit',
				month: '2-digit',
				year: 'numeric',
				hour: '2-digit',
				minute: '2-digit',
				hour12: false,
			};
			const optionsDMY = {
				day: '2-digit',
				month: '2-digit',
				year: 'numeric',
			};
			$modal.find("#name").html(res.fullName);
			$modal.find("#phone").html(res.phoneNumber);
			const dob = new Date(res.dob);
			const formattedDateDob = new Intl.DateTimeFormat('en-GB', optionsDMY).format(dob);

			$modal.find("#dob").html(formattedDateDob);
			$modal.find("#email").html(res.email);
			var avatar = res.image ?? "avatar.png";
			$modal.find("#avatar").attr("src", "/imgs/" + avatar);
			$modal.find("#address").html(res.address);
			const createdTime = new Date(res.createdTime);
			const updatedTime = new Date(res.updatedTime);
			const formattedDateCreatedTime = new Intl.DateTimeFormat('en-GB', optionsDMYHM).format(createdTime);
			const formattedDateUpdatedTime = new Intl.DateTimeFormat('en-GB', optionsDMYHM).format(updatedTime);
			$modal.find("#createdTime").html(formattedDateCreatedTime);
			$modal.find("#updatedTime").html(formattedDateUpdatedTime);
			$modal.find("#gender").html(res.gender);
			$modal.modal("show");

		});
	});
	$(".btn-active").on("click", function () {
		var id = $(this).attr("data-id")
		var $modal = $("#modalActiveUser")
		$modal.find("#id").val(id);
		$modal.modal("show");
	});
});