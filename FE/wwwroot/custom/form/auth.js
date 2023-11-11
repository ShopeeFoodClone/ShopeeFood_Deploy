$(function () {
	var $formLogin = $('#formLogin');
	var $formRegister = $('#formRegister');
	var $formForgetPassword = $('#formForgetPassword');
	$formLogin.on('submit', function (e) {
		e.preventDefault();
		_callAjax.auth.Login($(this));
	})

	$formRegister.on('submit', function (e) {
		e.preventDefault();
		_callAjax.auth.Register($(this));
	})
	$formForgetPassword.on('submit', function (e) {
		e.preventDefault();
		_callAjax.auth.ForgetPassword($(this));
	})
	if ($formRegister.length > 0) {
		var $validate_email = $("#validate-email");
		var $validate_username = $("#validate-username");
		var $validate_phone = $("#validate-phone");
		var $email = $formRegister.find("#Email");
		var $phoneNumber = $formRegister.find("#PhoneNumber");
		var $username = $formRegister.find("#Username");

		$email.on("focusout", function () {
			_callAjax.auth.CheckEmail($email, $validate_email);
		})
		$phoneNumber.on("focusout", function () {
			_callAjax.auth.CheckPhoneNumber($phoneNumber, $validate_phone);
		})
		$username.on("focusout", function () {
			_callAjax.auth.CheckUsername($username, $validate_username);
		})
	}
});
// Login google
var googleUser = {};
var startApp = function () {
	gapi.load('auth2', function () {
		// Retrieve the singleton for the GoogleAuth library and set up the client.
		auth2 = gapi.auth2.init({
			client_id: '813757043451-ql8262n6g5dh6qm8n1kum5hbr37knk92',
			scope: "email",
			plugin_name: 'ShopeeFoodClone'
		});
		attachSignin(document.getElementById('sign-in-google'));
	});
};
function attachSignin(element) {
	auth2.attachClickHandler(element, {},
		function (googleUser) {
			var email = googleUser.getBasicProfile().getEmail();
			var accessToken = googleUser.getAuthResponse().id_token;
			var oAuthGoogle = {
				Email: email,
				AccessToken: accessToken
			}
			_callAjax.auth.LoginGoogle(oAuthGoogle);
			signOut();
		}, function (error) {
			console.log(JSON.stringify(error, undefined, 2));
		});
}
function signOut() {
	var auth2 = gapi.auth2.getAuthInstance();
	auth2.signOut().then(function () {
	});
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