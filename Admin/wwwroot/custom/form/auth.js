$(function () {
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
	var $formLogin = $('#formLogin');
	var $formRegister = $('#formRegister');
	var $formForgetPassword = $('#formForgetPassword');

	if ($formLogin.length > 0) {
		$formLogin.on('submit', function (e) {
			e.preventDefault();
			var $validate_password = $formLogin.find("#validate-password");
			var $validate_user = $formLogin.find("#validate-username");
			var $username = $formLogin.find("#Username");
			var $password = $formLogin.find("#Password");
			if ($username.val() == '') {
				$validate_user.html("Vui lòng nhập tài khoản");
				$username.focus();
				$validate_user.show();
				return;
			}
			$validate_user.hide();
			if ($password.val() == '') {
				$validate_password.html("Vui lòng nhập mật khẩu");
				$password.focus();
				$validate_password.show();
				return;
			}
			$validate_password.hide();
			_callAjax.auth.Login($(this));
		})
	}

	if ($formForgetPassword.length > 0) {
		var $email = $formForgetPassword.find("#Email");
		var $validate_email = $("#validate-email");
		$email.on("focusout", function () {
			if ($email.val() == "") {
				$validate_email.hide();
				return;
			}
			if (RegexEmail($email.val())) {
				_callAjax.auth.CheckEmail($email, $validate_email);
			}
			else {
				$validate_email.html("Email không hợp lệ")
				$validate_email.show();
			}
		});
		$formForgetPassword.on('submit', function (e) {
			e.preventDefault();
			if ($email.val() == "") {
				$validate_email.html("Vui lòng nhập email");
				$validate_email.show();
				return;
			}
			if (RegexEmail($email.val())) {
				$validate_email.hide();
				_callAjax.auth.ForgetPassword($(this));
			}
		})
	}

	if ($formRegister.length > 0) {
		var $validate_email = $("#validate-email");
		var $validate_username = $("#validate-username");
		var $validate_phone = $("#validate-phone");
		var $validate_password = $("#validate-password");
		var $validate_confirm_password = $("#validate-confirm-password");
		var $email = $formRegister.find("#Email");
		var $phoneNumber = $formRegister.find("#PhoneNumber");
		var $username = $formRegister.find("#Username");
		var $password = $formRegister.find("#Password");
		var $password_confirm = $formRegister.find("#ConfirmPassword");
		var isValidEmail = false;
		var isValidPhone = false;
		var isValidPassword = false;
		var isValidUsername = false;
		$formRegister.on('submit', function (e) {
			e.preventDefault();
			var $inputs = $formRegister.find("input");
			var isValid = true;
			$inputs.each(function () {
				if ($(this).val() == "") {
					$(this).focus();
					isValid = false;
					return false;
				}
			});

			var city = $formRegister.find(".slc-cites option:selected").val();
			var district = $formRegister.find(".slc-district option:selected").val();
			var ward = $formRegister.find(".slc-wards option:selected").val();
			var street = $formRegister.find("#street").val();
			if (city == "" || district == "" || ward == "" || street == "") {
				ShowPopupFail("Vui lòng nhập địa chỉ đầy đủ", "Thông báo");
				return;
			}
			if (isValid && isValidEmail && isValidPhone && isValidUsername && isValidPassword) {
				if ($password.val() != $password_confirm.val()) {
					$validate_confirm_password.html("Mật khẩu xác nhận không trùng nhau");
					$validate_confirm_password.show();
					return;
				}
				else {
					$validate_confirm_password.hide();
				}
				_callAjax.common.FullAddress(ward, function (fullAddress) {
					fullAddress = street + ", " + fullAddress.data;
					_callAjax.auth.Register(fullAddress, $formRegister);
				});
			}
		})
		$password_confirm.on("focusout", function () {
			if ($password_confirm.val() == "") {
				$validate_confirm_password.hide();
				isValidPassword = false;
				return;
			}
			if ($password.val() != $password_confirm.val()) {
				$validate_confirm_password.html("Mật khẩu xác nhận không trùng nhau");
				$validate_confirm_password.show();
				isValidPassword = false;
				return;
			}
			else {
				$validate_confirm_password.hide();
				isValidPassword = true;
			}
		});
		$password.on("focusout", function () {
			if ($password.val() == "") {
				$validate_password.hide();
				isValidPassword = false;
				return;
			}

			if (RegexPassword($password.val())) {
				$validate_password.hide();
				isValidPassword = true;
			} else {
				$validate_password.html("Chưa thỏa điều kiện mật khẩu");
				$validate_password.show();
				isValidPassword = false;
			}
		});
		$email.on("focusout", function () {
			if ($email.val() == "") {
				isValidEmail = false;
				$validate_email.hide();
				return;
			}
			if (RegexEmail($email.val())) {
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
				_callAjax.auth.CheckPhoneNumber($phoneNumber, function (data) {
					if (data) {
						$validate_phone.html("Số điện thoại đã được sử dụng, vui lòng sử dụng số khác")
						$validate_phone.show();
					}
					else {
						isValidPhone = true;
						$validate_phone.hide();
					}
				});
			}
			else {
				$validate_phone.html("Số điện thoại chưa hợp lệ")
				$validate_phone.show();
				isValidPhone = false;
			}
		})
		$username.on("focusout", function () {
			if ($username.val() == "") {
				isValidUsername = false;
				$validate_username.hide();
				return;
			}
			_callAjax.auth.CheckUsername($username, function (data) {
				if (data) {
					$validate_username.html("Tên tài khoản đã được sử dụng, vui lòng sử dụng tên khác")
					$validate_username.show();
					isValidUsername = false;
				}
				else {
					isValidUsername = true;
					$validate_username.hide();
				}
			});
		})
	}
	$(function () {
		$("#btnResendEmail").on("click", function () {
			$form = $("#verification-code")
			var email = $form.find("#email").val();
			_callAjax.auth.ResendPinCode(email, function () {
				let seconds = 30;
				$("#btnResendEmail").attr("disabled", true);
				const countdown = setInterval(() => {
					if (seconds >= 0) {
						const minutes = Math.floor(seconds / 60);
						const remainingSeconds = seconds % 60;

						const displayMinutes = minutes < 10 ? '0' + minutes : minutes;
						const displaySeconds = remainingSeconds < 10 ? '0' + remainingSeconds : remainingSeconds;
						$("#count-down-pincode").html(displayMinutes + ':' + displaySeconds)
						seconds--;
					} else {
						$("#btnResendEmail").prop("disabled", false);
						clearInterval(countdown);
					}
				}, 1000); // runs every second (1000 milliseconds)
			});
		});
		$("#verification-code").submit(function (e) {
			e.preventDefault();
			var $otp = $("#otp").find("input[data-verify-num]");
			var pinCode = "";
			$otp.each(function () {
				pinCode += $(this).val()
			});
			var userId = $(this).find("#userId").val();
			_callAjax.auth.ConfirmPinCode(pinCode, userId);
		});
		$("#verification-code-register").submit(function (e) {
			e.preventDefault();
			var $otp = $("#otp").find("input[data-verify-num]");
			var pinCode = "";
			$otp.each(function () {
				pinCode += $(this).val()
			});
			var userId = $(this).find("#userId").val();
			_callAjax.auth.ConfirmRegister(pinCode, userId);
		});
	});
});

function RegexPhonenumber(phoneNumber) {
	const regexPhoneNumber = /(84|0[3|5|7|8|9])+([0-9]{8})\b/g;
	return phoneNumber.match(regexPhoneNumber) ? true : false;
}

function RegexEmail(email) {
	return email.match(
		/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
	);
}
function RegexPassword(password) {
	return password.match(
		"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$"
	);
}

function handeOTPInput() {
	const inputs = document.querySelectorAll('#otp > *[data-verify-num]');
	inputs.forEach((input, index1) => {
		// handle copy paste
		input.addEventListener("paste", (e) => {
			e.preventDefault();
			const data = e.clipboardData.getData("text");
			const value = data.split("");
			if (value.length == inputs.length) {
				inputs.forEach((i, index) => {
					i.value = "";
					i.removeAttribute("disabled");
					i.value = value[index];
					i.focus();
				});
			}
		});
		// handle keyup
		input.addEventListener("keyup", (e) => {
			const currentInput = input;
			const nextInput = input.nextElementSibling;
			const prevInput = input.previousElementSibling;
			if (currentInput.value.length > 1) {
				currentInput.value = "";
				return;
			}
			if (nextInput && currentInput.value !== "") {
				nextInput.removeAttribute("disabled");
				nextInput.focus();
			}
			if (e.key === "Backspace" || e.keyCode === 8) {
				inputs.forEach((input, index2) => {
					if (index1 <= index2 && prevInput) {
						input.setAttribute("disabled", true);
						input.value = "";
						currentInput.value = "";
						prevInput.focus();
					}
				});
			}
		});
	});
}