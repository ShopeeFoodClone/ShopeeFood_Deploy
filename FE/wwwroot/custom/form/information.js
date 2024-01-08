$(function () {
	$("#editAddress").change(function () {
		if ($(this).is(":checked") == true) {
			$("#front").addClass("d-flex");
			$("#back").hide();
		}
		else {
			$("#front").removeClass("d-flex");
			$("#back").show();
		}
	});
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
	var $formUpdate = $("#formUpdateProfile");
	if ($formUpdate.length > 0) {
		var $validate_email = $("#validate-email");
		var $validate_phone = $("#validate-phone");
		var $email = $formUpdate.find("#email");
		var $phoneNumber = $formUpdate.find("#phoneNumber");
		var $address = $formUpdate.find("#address");
		var isValidEmail = true;
		var isValidPhone = true;
		//
		var emailOld = $email.val();
		var phoneOld = $phoneNumber.val();
		var addressOld = $address.val();
		$email.on("focusout", function () {
			if ($email.val() == "") {
				isValidEmail = false;
				$validate_email.hide();
				return;
			}
			if (RegexEmail($email.val())) {
				if ($email.val() != emailOld) {
					_callAjax.auth.CheckEmail($email, function (data) {
						if (data) {
							$validate_email.html("Email đã được sử dụng, vui lòng sử dụng email khác")
							$validate_email.show();
							isValidEmail = false;
						}
						else {
							isValidEmail = true;
							$validate_email.hide();
						}
					});
				}
				else {
					isValidEmail = true;
					$validate_email.hide();
				}
			}
			else {
				isValidEmail = false;
				$validate_email.html("Email không hợp lệ")
				$validate_email.show();
			}
		})
		$phoneNumber.on("focusout", function () {
			if ($phoneNumber.val() == "") {
				isValidPhone = false;
				$validate_phone.hide();
				return;
			}
			if (RegexPhonenumber($phoneNumber.val())) {
				if ($phoneNumber.val() != phoneOld) {
					_callAjax.auth.CheckPhoneNumber($phoneNumber, function (data) {
						if (data) {
							$validate_phone.html("Số điện thoại đã được sử dụng, vui lòng sử dụng số khác")
							$validate_phone.show();
							isValidPhone = false;
						}
						else {
							isValidPhone = true;
							$validate_phone.hide();
						}
					});
				}
				else {
					isValidPhone = true;
					$validate_phone.hide();
				}
			}
			else {
				$validate_phone.html("Số điện thoại chưa hợp lệ")
				$validate_phone.show();
				isValidPhone = false;
			}
		})
		$formUpdate.submit(function (e) {
			e.preventDefault();
			if (isValidEmail && isValidPhone) {
				if ($("#editAddress").is(":checked")) {
					var city = $formUpdate.find(".slc-cites option:selected").val();
					var district = $formUpdate.find(".slc-district option:selected").val();
					var ward = $formUpdate.find(".slc-wards option:selected").val();
					var street = $formUpdate.find("#street").val();
					if (city == "" || district == "" || ward == "" || street == "") {
						ShowPopupFail("Vui lòng nhập địa chỉ đầy đủ");
						return;
					}
					_callAjax.common.FullAddress(ward, function (fulladdress) {
						fulladdress = street + ", " + fulladdress.data;
						_callAjax.information.UpdateProfile(fulladdress, $formUpdate);
					});
				}
				else {
					_callAjax.information.UpdateProfile(addressOld, $formUpdate);
				}
			}
		});
	}

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

function RegexPhonenumber(phoneNumber) {
	const regexPhoneNumber = /(84|0[3|5|7|8|9])+([0-9]{8})\b/g;
	return phoneNumber.match(regexPhoneNumber) ? true : false;
}

function RegexEmail(email) {
	return email.match(
		/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
	);
}