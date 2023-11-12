var _callAjax = (function () {
	var urlApi = localStorage.getItem("BaseUrlApi");
	var _auth = {
		Login: function ($formLogin) {
			var request = _constructorCommon.auth.Login($formLogin);
			console.log(request);
			var configAjax = {
				url: '/Auth/Login',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					console.log(data);
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						RedirectToUrl(res);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		Register: function ($formRegister) {
			var request = _constructorCommon.auth.Register($formRegister);
			var configAjax = {
				url: '/Auth/Register',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						RedirectToUrl(res);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		ForgetPassword: function ($formForgetPassword) {
			var email = $formForgetPassword.find("#email").val();
			var configAjax = {
				url: '/Auth/ForgetPassword?email=' + email,
				type: 'POST',
				success: function (res) {
					var data = res.data ?? res;
					console.log(data);
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						ShowPopupSuccess(data.message);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 2000);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		ResendPinCode: function (email) {
			var configAjax = {
				url: '/Auth/ForgetPassword?email=' + email,
				type: 'POST',
				beforeSend: function () { },
				complete: function () { },
				success: function (res) {
					var data = res.data ?? res;
					console.log(data);
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		ConfirmPinCode: function (pincode, userId) {
			var request = {
				Pincode: pincode,
				UserId: userId
			};
			var configAjax = {
				url: '/Auth/ConfirmPincode',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						ShowPopupSuccess(data.message);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 2000);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		ConfirmRegister: function (pincode, userId) {
			var request = {
				Pincode: pincode,
				UserId: userId
			};
			var configAjax = {
				url: '/Auth/ConfirmRegister',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						ShowPopupSuccess(data.message);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 2000);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		LoginGoogle: function (loginGoogleRequest) {
			var configAjax = {
				url: '/Auth/LoginGoogle',
				type: 'POST',
				data: JSON.stringify(loginGoogleRequest),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						ShowPopupSuccess(data.message);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 2000);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		CheckEmail: function ($email, $validate) {
			if ($email.val() != "") {
				var configAjax = {
					url: urlApi + '/orther/check/email/' + $email.val(),
					type: 'GET',
					beforeSend: function () { },
					complete: function () { },
					success: function (data) {
						if (data) {
							$validate.show();
						}
						else {
							$validate.hide();
						}
					},
				}
				var callAjax = new AjaxOption(configAjax);
				callAjax.run();
			}
		},
		CheckUsername: function ($username, $validate) {
			if ($username.val() != "") {
				var configAjax = {
					url: urlApi + '/orther/check/username/' + $username.val(),
					type: 'GET',
					beforeSend: function () { },
					complete: function () { },
					success: function (data) {
						if (data) {
							$validate.show();
						}
						else {
							$validate.hide();
						}
					},
				}
				var callAjax = new AjaxOption(configAjax);
				callAjax.run();
			}
		},
		CheckPhoneNumber: function ($phoneNumber, $validate) {
			if ($phoneNumber.val() != "") {
				var configAjax = {
					url: urlApi + '/orther/check/phone-number/' + $phoneNumber.val(),
					type: 'GET',
					beforeSend: function () { },
					complete: function () { },
					success: function (data) {
						if (data) {
							$validate.show();
						}
						else {
							$validate.hide();
						}
					},
				}
				var callAjax = new AjaxOption(configAjax);
				callAjax.run();
			}
		}
	};
	var _homePage = {
		MoreDeal: function ($btn, callBack) {
			var request = _constructorCommon.homePage.MoreDeals($btn);
			var configAjax = {
				url: '/Deal/MoreDeal',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					console.log(res)
					if (!res.isSuccess) {
					} else {
						$btn.attr("data-page-index", parseInt(request.PageIndex) + 1);
						callBack(res.data.stores)
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		MoreCollection: function ($btn, callBack) {
			var request = _constructorCommon.homePage.MoreCollections($btn);
			var configAjax = {
				url: '/Collection/MoreCollection',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					console.log(res)
					if (!res.isSuccess) {
					} else {
						$btn.attr("data-page-index", parseInt(request.PageIndex) + 1);
						callBack(res.data.collectionResponses)
					}
				},
				error: function (res) {
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		MoreStoreCommon: function ($btn, idDistrict, callBack) {
			var request = _constructorCommon.homePage.MoreStoreCommons($btn, idDistrict);
			var configAjax = {
				url: '/Store/MoreStore',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					console.log(res)
					if (!res.isSuccess) {
					} else {
						$btn.attr("data-page-index", parseInt(request.PageIndex) + 1);
						callBack(res.data.stores)
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		SelectDistrict: function (idDistrict, callBack) {
			var request = _constructorCommon.homePage.SelectDistrict(idDistrict);
			var configAjax = {
				url: '/Store/StoresByDistrictsFromHomePage',
				type: 'POST',
				dataType: 'text',
				data: JSON.stringify(request),
				success: function (res) {
					console.log(res)
					callBack(res)
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		SearchBox: function (searchText, callBack) {
			var request = {
				SearchText: searchText,
			}
			var configAjax = {
				url: '/Store/SearchStoresPartialView',
				type: 'POST',
				dataType: 'text',
				beforeSend: function () { },
				complete: function () { },
				data: JSON.stringify(request),
				success: function (res) {
					callBack(res)
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		}
	};
	var _deal = {
		FilterByDistricts: function ($dropdown) {
			var request = _constructorCommon.deal.FilterByDistricts($dropdown)
			var configAjax = {
				url: '/Deal/FilterStoreByDistricts',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						RedirectToUrl(res);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		}
	};
	var _store = {
		FilterStore: function ($dropdownDistricts, $dropdownConsumpType, searchText) {
			var request = _constructorCommon.store.FilterStore($dropdownDistricts, $dropdownConsumpType, searchText)
			var configAjax = {
				url: '/Store/StoresWithFilter',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						RedirectToUrl(res);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		Search: function (searchText) {
			var request = {
				SearchText: searchText
			}
			var configAjax = {
				url: '/Store/StoresWithFilter',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						RedirectToUrl(res);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		}
	};
	var _information = {
		UploadAvatar: function ($formUpload) {
			var formData = new FormData();
			var image = $formUpload.find('#uploadAvatar')[0].files[0]
			formData.append('image', image);
			var configAjax = {
				url: '/Account/UpdateAvatar',
				type: 'POST',
				data: formData,
				contentType: false,
				processData: false,
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						ShowPopupSuccess(data.message);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 2000);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateProfile: function ($formUpdate) {
			var request = _constructorCommon.information.UpdateProfile($formUpdate)
			var configAjax = {
				url: '/Account/Information',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						ShowPopupSuccess(data.message);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 2000);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		ChangePassword: function ($formChangePassword) {
			var request = _constructorCommon.information.ChangePassword($formChangePassword)
			var configAjax = {
				url: '/Account/ChangePassword',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						HideAllModal();
						ShowPopupFail(data.message);
					} else {
						HideAllModal();
						ShowPopupSuccess(data.message);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		}
	};
	var _cart = {
		AddToCart: function (idProduct) {
			var configAjax = {
				url: '/Cart/AddProductToCart?idProduct=' + idProduct,
				type: 'POST',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
						var $btnOk = $("#modalAPI").find("#btnOk");
						$btnOk.removeAttr("data-bs-dismiss");
						$btnOk.on("click", function () {
							var configAjaxChild = {
								url: '/Cart/ClearCart',
								type: 'POST',
								success: function (data) {
									if (!data.isSuccess) {
										ShowPopupFail(data.message);
									} else {
										ShowPopupSuccess(data.message);
										$btnOk.attr("data-bs-dismiss", "modal");
										$btnOk.unbind("click");
									}
								}
							}
							var callAjaxChild = new AjaxOption(configAjaxChild);
							callAjaxChild.run();
						});
					} else {
						$("#toastAddToCart").find("#toastContent").html(data.message);
						$("#toastAddToCart").toast("show");
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateDetailsCart: function (idProduct, quantity) {
			var request = {
				IdProduct: idProduct,
				Quantity: quantity
			}
			var configAjax = {
				url: '/Cart/UpdateDetailsCart',
				type: 'POST',
				beforeSend: function () { },
				complete: function () { },
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					}
					else {
						RedirectToUrl(res);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		Order: function (phoneNumber, deliveryAddress) {
			var request = {
				PhoneNumber: phoneNumber,
				DeliveryAddress: deliveryAddress
			}
			var configAjax = {
				url: '/Cart/Order',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					}
					else {
						ShowPopupSuccess(data.message);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 2000);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		FilterHistoryOrder: function ($form) {
			var request = _constructorCommon.cart.FilterHistoryOrder($form);
			console.log(request);
			var configAjax = {
				url: '/Cart/FilterHistoryOrder',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					}
					else {
						RedirectToUrl(res);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		}
	}
	return {
		auth: _auth,
		homePage: _homePage,
		deal: _deal,
		store: _store,
		information: _information,
		cart: _cart
	};
})();