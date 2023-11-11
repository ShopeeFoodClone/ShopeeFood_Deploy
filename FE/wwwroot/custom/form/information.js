$(function () {
	_configDatePicker.initDateMinus100($("#dob"));
	$("#formUploadImage").submit(function (e) {
		e.preventDefault();
		var $formUpload = $(this);
		_callAjax.information.UploadAvatar($formUpload);
	});
	$("#formUpdateProfile").submit(function (e) {
		e.preventDefault();
		var $formUpdate = $(this);
		_callAjax.information.UpdateProfile($formUpdate);
	});

	$("#formChangePassword").submit(function (e) {
		e.preventDefault();
		var newPassword = $(this).find("#newPassword").val();
		var confirmPassword = $(this).find("#confirmPassword").val();
		if (newPassword != confirmPassword) {
			HideAllModal();
			ShowPopupFail("Mật khẩu mới không trùng nhau");
			return;
		}
		_callAjax.information.ChangePassword($(this));
	})
});