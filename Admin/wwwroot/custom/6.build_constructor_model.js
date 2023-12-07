var _constructorCommon = (function () {
	var _auth = {
		Login: function ($formLogin) {
			var username = $formLogin.find('#Username').val();
			var password = $formLogin.find('#Password').val();
			return {
				Username: username,
				Password: password
			}
		},
		Register: function (fullAddress, $formRegister) {
			var username = $formRegister.find('#Username').val();
			var fullName = $formRegister.find('#FullName').val();
			var phoneNumber = $formRegister.find('#PhoneNumber').val();
			var email = $formRegister.find('#Email').val();
			var password = $formRegister.find('#Password').val();
			var confirmPassword = $formRegister.find('#ConfirmPassword').val();
			var address = fullAddress;
			return {
				Username: username,
				FullName: fullName,
				Password: password,
				PasswordConfirm: confirmPassword,
				PhoneNumber: phoneNumber,
				Email: email,
				Address: address
			}
		},
	};
	var _homePage = {
		MoreDeals: function ($btn) {
			var pageIndex = $btn.attr("data-page-index");
			var idCategoryConsumpType = $btn.attr("data-id-category-consump");
			return {
				PageIndex: pageIndex,
				PageSize: 9,
				IdCity: localStorage.getItem("data-id-city"),
				IdCategoryConsumpType: idCategoryConsumpType
			}
		},
		MoreCollections: function ($btn) {
			var pageIndex = $btn.attr("data-page-index");
			var idCategoryConsumpType = $btn.attr("data-id-category-consump");
			return {
				PageIndex: pageIndex,
				PageSize: 9,
				IdCategoryConsumpType: idCategoryConsumpType
			}
		},
		MoreStoreCommons: function ($btn, idDistrict) {
			var pageIndex = $btn.attr("data-page-index");
			var districts = idDistrict == 'ALL' ? [] : [idDistrict];
			var idCategoryConsumpType = $btn.attr("data-id-category-consump");
			return {
				PageIndex: pageIndex,
				PageSize: 6,
				Districts: districts,
				IdCategoryConsumpType: idCategoryConsumpType
			}
		},
		SelectDistrict: function (idDistrict) {
			var districts = idDistrict == 'ALL' ? [] : [idDistrict];
			return {
				PageIndex: 1,
				PageSize: 6,
				Districts: districts
			}
		}
	};
	var _deal = {
		FilterByDistricts: function ($dropdown) {
			var $checkboxes = $dropdown.find("input[type=checkbox]:checked");
			var districts = [];
			$checkboxes.each(function () {
				var idDistrict = $(this).attr("data-id-district");
				districts.push(idDistrict);
			});
			return {
				IdDistricts: districts
			}
		}
	};
	var _store = {
		FilterStore: function ($dropdownDistricts, $dropdownConsumpType, searchText) {
			var $checkboxDistricts = $dropdownDistricts.find("input[type=checkbox]:checked");
			var $checkboxConsumpTypes = $dropdownConsumpType.find("input[type=checkbox]:checked");
			var districts = [];
			var consumpTypes = [];
			$checkboxDistricts.each(function () {
				var idDistrict = $(this).attr("data-id-district");
				districts.push(idDistrict);
			});
			$checkboxConsumpTypes.each(function () {
				var idConsumpType = $(this).attr("data-id-consumptype");
				consumpTypes.push(idConsumpType);
			});
			return {
				IdDistricts: districts,
				IdConsumpTypes: consumpTypes,
				SearchText: searchText
			}
		}
	};
	var _information = {
		UpdateProfile: function (fulladdress, $formUpdate) {
			var fullName = $formUpdate.find("#fullName").val();
			var gender = $formUpdate.find("#slc-gender option:selected").val();
			var email = $formUpdate.find("#email").val();
			var phoneNumber = $formUpdate.find("#phoneNumber").val();
			var dob = $formUpdate.find("#dob").val();
			// province
			var address = fulladdress;

			return {
				UserId: "1",
				FullName: fullName,
				Gender: gender,
				Email: email,
				PhoneNumber: phoneNumber,
				Address: address,
				Dob: dob
			}
		},
		ChangePassword: function ($formChangePassword) {
			var userId = $formChangePassword.find("#userId").val();
			var oldPassword = $formChangePassword.find("#oldPassword").val();
			var newPassword = $formChangePassword.find("#newPassword").val();
			return {
				UserId: userId,
				OldPassword: oldPassword,
				NewPassword: newPassword
			}
		}
	};
	var _cart = {
		FilterHistoryOrder: function ($form) {
			var status = $form.find("#slc-status option:selected").val();
			var sort = $form.find("#slc-sort option:selected").val();
			var startDate = $form.find("#startDate").val();
			var endDate = $form.find("#endDate").val();
			return {
				Status: status,
				StartDate: startDate,
				EndDate: endDate,
				Sort: sort
			}
		}
	};
	return {
		auth: _auth,
		homePage: _homePage,
		deal: _deal,
		store: _store,
		information: _information,
		cart: _cart
	};
})();