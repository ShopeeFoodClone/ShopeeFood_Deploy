$(function () {
	_configDatePicker.initDateMinus100($("#dob"));
	// Button show hide password
	$(".btn-show-hide-password").on("click", function () {
		const $btn = $(this);
		const $divParent = $btn.parent();
		const $inputPassword = $divParent.find("input");
		const passwordFieldType = $inputPassword.attr('type');
		if ($inputPassword.val() != "") {
			if (passwordFieldType == 'password') {
				$inputPassword.attr('type', 'text');
				$btn.attr('src', '/imgs/Invisible.png');
			}
			else if (passwordFieldType == 'text') {
				$inputPassword.attr('type', 'password');
				$btn.attr('src', '/imgs/Eye.png');
			}
		}
	});
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
	var $newPassword = $("#formChangePassword").find("#newPassword");
	var $validate = $(this).find("#validate-password");
	var isValid = false;
	if ($("#formChangePassword").length > 0) {
		$newPassword.on("focusout", function () {
			if ($(this).val() == "") {
				$validate.hide();
				return;
			}
			if (RegexPassword($newPassword.val())) {
				isValid = true;
				$validate.hide();
			}
			else {
				isValid = false;
				$validate.html("Mật khẩu mới chưa hợp lệ");
				$validate.show();

			}
		});
	}

	$("#formChangePassword").submit(function (e) {
		e.preventDefault();
		var newPassword = $(this).find("#newPassword").val();
		var confirmPassword = $(this).find("#confirmPassword").val();
		if (isValid) {
			if (newPassword != confirmPassword) {
				ShowPopupFail("Mật khẩu xác nhận không trùng nhau");
				return;
			}
			_callAjax.information.ChangePassword($(this));
		}
	})
});

function RegexPassword(password) {
	return password.match(
		"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$"
	);
}