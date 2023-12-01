var _callAjax = (function () {
	var urlApi = localStorage.getItem("BaseUrlApi");
	var _auth = {
		Login: function ($formLogin) {
			var request = _constructorCommon.auth.Login($formLogin);
			var configAjax = {
				url: '/Auth/Login',
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
		Register: function (fullAddress, $formRegister) {
			var request = _constructorCommon.auth.Register(fullAddress, $formRegister);
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
			var email = $formForgetPassword.find("#Email").val();
			var configAjax = {
				url: '/Auth/ForgetPassword?email=' + email,
				type: 'POST',
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
		ResendPinCode: function (email, callBack) {
			var configAjax = {
				url: '/Auth/ForgetPassword?email=' + email,
				type: 'POST',
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					}
					else {
						callBack();
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
		CheckEmail: function ($email, callBack) {
			if ($email.val() != "") {
				var configAjax = {
					url: urlApi + '/orther/check/email/' + $email.val(),
					type: 'GET',
					beforeSend: function () { },
					complete: function () { },
					success: function (data) {
						callBack(data);
					},
				}
				var callAjax = new AjaxOption(configAjax);
				callAjax.run();
			}
		},
		CheckUsername: function ($username, callBack) {
			if ($username.val() != "") {
				var configAjax = {
					url: urlApi + '/orther/check/username/' + $username.val(),
					type: 'GET',
					beforeSend: function () { },
					complete: function () { },
					success: function (data) {
						callBack(data);
					},
				}
				var callAjax = new AjaxOption(configAjax);
				callAjax.run();
			}
		},
		CheckPhoneNumber: function ($phoneNumber, callBack) {
			if ($phoneNumber.val() != "") {
				var configAjax = {
					url: urlApi + '/orther/check/phone-number/' + $phoneNumber.val(),
					type: 'GET',
					beforeSend: function () { },
					complete: function () { },
					success: function (data) {
						callBack(data)
					},
				}
				var callAjax = new AjaxOption(configAjax);
				callAjax.run();
			}
		},
		DeleteUser: function (userId) {
			var configAjax = {
				url: '/Admin/User/DeleteUser?userId=' + userId,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		ActiveUser: function (userId) {
			var configAjax = {
				url: '/Admin/User/ActiveUser?userId=' + userId,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
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
		},
		SearchProduct: function (searchText, callBack) {
			var configAjax = {
				url: '/Store/SearchProduct?searchText=' + searchText,
				type: 'POST',
				dataType: 'text',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					callBack(data);
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		GetStore: function (id, callBack) {
			var configAjax = {
				url: urlApi + '/store/' + id,
				type: 'GET',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					callBack(data);
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateStore: function ($form) {
			var formData = new FormData();
			var image = $form.find('#uploadImageUpdate').val().replace(/C:\\fakepath\\/i, '')
			var id = $form.find('#id').val();
			var name = $form.find('#name').val();
			var openTime = $form.find('#openTime').val();
			var closeTime = $form.find('#closeTime').val();
			var address = $form.find('#street').val();
			var tagDeals = $form.find('#tagDeals').val();
			var isDeal = true;
			if (tagDeals == '') {
				isDeal = false;
			}
			var idBranchStore = $form.find('.slc-branchStore option:selected').val();
			var idCollection = $form.find('.slc-collection option:selected').val();
			var idConsumpType = $form.find('.slc-consumpType option:selected').val();
			var idWard = $form.find('#slc-wards option:selected').val();

			formData.append('file', $form.find('#uploadImageUpdate')[0].files[0]);
			formData.append('id', id);
			formData.append('name', name);
			formData.append('image', image);
			formData.append('openTime', openTime);
			formData.append('closeTime', closeTime);
			formData.append('address', address);
			formData.append('tagDeals', tagDeals);
			formData.append('isDeal', isDeal);
			formData.append('idBranchStore', idBranchStore);
			formData.append('idCollection', idCollection);
			formData.append('idConsumpType', idConsumpType);
			formData.append('idWard', idWard);
			var configAjax = {
				url: '/Admin/Store/UpdateStore',
				type: 'POST',
				data: formData,
				beforeSend: function () { },
				complete: function () { },
				contentType: false,
				processData: false,
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		CreateStore: function ($form) {
			var formData = new FormData();
			var image = $form.find('#uploadImageCreate').val().replace(/C:\\fakepath\\/i, '')
			var name = $form.find('#name').val();
			var openTime = $form.find('#openTime').val();
			var closeTime = $form.find('#closeTime').val();
			var address = $form.find('#street').val();
			var tagDeals = $form.find('#tagDeals').val();
			var isDeal = true;
			if (tagDeals == '') {
				isDeal = false;
			}
			var idBranchStore = $form.find('.slc-branchStore option:selected').val();
			var idCollection = $form.find('.slc-collection option:selected').val();
			var idConsumpType = $form.find('.slc-consumpType option:selected').val();
			var idWard = $form.find('#slc-wards option:selected').val();

			formData.append('file', $form.find('#uploadImageCreate')[0].files[0]);
			formData.append('name', name);
			formData.append('image', image);
			formData.append('openTime', openTime);
			formData.append('closeTime', closeTime);
			formData.append('address', address);
			formData.append('tagDeals', tagDeals);
			formData.append('isDeal', isDeal);
			formData.append('idBranchStore', idBranchStore);
			formData.append('idCollection', idCollection);
			formData.append('idConsumpType', idConsumpType);
			formData.append('idWard', idWard);
			var configAjax = {
				url: '/Admin/Store/CreateStore',
				type: 'POST',
				data: formData,
				beforeSend: function () { },
				complete: function () { },
				contentType: false,
				processData: false,
				success: function (res) {
					var data = res.data ?? res;
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		DeleteStore: function (id) {
			var configAjax = {
				url: '/Admin/Store/DeleteStore?idStore=' + id,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (res) {
					var data = res.data ?? res;
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		ActiveStore: function (id) {
			var configAjax = {
				url: '/Admin/Store/ActiveStore?idStore=' + id,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (res) {
					var data = res.data ?? res;
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		GetCategoryProduct: function (id, callBack) {
			var configAjax = {
				url: urlApi + '/category-products/' + id,
				type: 'GET',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					if (data.isSuccess) {
						callBack(data.data);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		CreateCategoryProduct: function ($form) {
			var idStore = $form.find("#idStore").val();
			var title = $form.find("#title").val();
			var request = {
				IdStore: idStore,
				Title: title
			};
			var configAjax = {
				url: '/Admin/Store/CreateCategoryProduct',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateCategoryProduct: function ($form) {
			var id = $form.find("#id").val();
			var idStore = $form.find("#idStore").val();
			var title = $form.find("#title").val();
			var request = {
				IdStore: idStore,
				Title: title,
				Id: id
			};
			var configAjax = {
				url: '/Admin/Store/UpdateCategoryProduct',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		DeleteCategoryProduct: function (id) {
			var configAjax = {
				url: '/Admin/Store/DeleteCategoryProduct?idCategoryProduct=' + id,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		GetProduct: function (id, callBack) {
			var configAjax = {
				url: urlApi + '/products/' + id,
				type: 'GET',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					if (data.isSuccess) {
						callBack(data.data);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		CreateProduct: function ($form) {
			var formData = new FormData();
			var image = $form.find('#uploadImageCreateProduct').val().replace(/C:\\fakepath\\/i, '')
			var name = $form.find('#name').val();
			var description = $form.find('#description').val();
			var idCategoryProduct = $form.find('#idCategoryProduct').val();
			var price = $form.find('#price').val();
			formData.append('file', $form.find('#uploadImageCreateProduct')[0].files[0]);
			formData.append('name', name);
			formData.append('image', image);
			formData.append('description', description);
			formData.append('price', price);
			formData.append('idCategoryProduct', idCategoryProduct);
			var configAjax = {
				url: '/Admin/Store/CreateProduct',
				type: 'POST',
				data: formData,
				beforeSend: function () { },
				complete: function () { },
				contentType: false,
				processData: false,
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateProduct: function ($form) {
			var formData = new FormData();
			var image = $form.find('#uploadImageUpdateProduct').val().replace(/C:\\fakepath\\/i, '')
			var name = $form.find('#name').val();
			var description = $form.find('#description').val();
			var idCategoryProduct = $form.find('#idCategoryProduct').val();
			var id = $form.find('#id').val();
			var price = $form.find('#price').val();
			formData.append('file', $form.find('#uploadImageUpdateProduct')[0].files[0]);
			formData.append('name', name);
			formData.append('image', image);
			formData.append('description', description);
			formData.append('price', price);
			formData.append('idCategoryProduct', idCategoryProduct);
			formData.append('id', id);
			var configAjax = {
				url: '/Admin/Store/UpdateProduct',
				type: 'POST',
				data: formData,
				beforeSend: function () { },
				complete: function () { },
				contentType: false,
				processData: false,
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		DeleteProduct: function (id) {
			var configAjax = {
				url: '/Admin/Store/DeleteProduct?idProduct=' + id,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
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
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 2000);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateProfile: function (address, $formUpdate) {
			var request = _constructorCommon.information.UpdateProfile(address, $formUpdate)
			var configAjax = {
				url: '/Account/Information',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						ShowPopupSuccess(data.data);
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
		AddToCart: function (idProduct, callBack) {
			var configAjax = {
				url: '/Cart/AddProductToCart?idProduct=' + idProduct,
				type: 'POST',
				dataType: 'text',
				beforeSend: function () { },
				complete: function () { },
				success: function (res) {
					callBack(res);
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateDetailsCart: function (idProduct, quantity, callBack) {
			var request = {
				IdProduct: idProduct,
				Quantity: quantity
			}
			var configAjax = {
				url: '/Cart/UpdateDetailsCart',
				type: 'POST',
				dataType: 'text',
				beforeSend: function () { },
				complete: function () { },
				data: JSON.stringify(request),
				success: function (res) {
					callBack(res);
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		Order: function (phoneNumber, deliveryAddress, paymentType) {
			var request = {
				PhoneNumber: phoneNumber,
				DeliveryAddress: deliveryAddress,
				PaymentType: paymentType
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
						ShowPopupSuccess(data.data);
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
			var configAjax = {
				url: '/Cart/FilterHistoryOrder',
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
		ClearCart: function () {
			var configAjax = {
				url: '/Cart/ClearCart',
				type: 'POST',
				beforeSend: function () { },
				complete: function () { },
				success: function (res) {
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.message);
					} else {
						ShowPopupSuccess(data.message);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		RemoveDetailsCart: function (idProduct, callBack) {
			var configAjax = {
				url: '/Cart/RemoveProductFromCart?idProduct=' + idProduct,
				type: 'POST',
				dataType: 'text',
				beforeSend: function () { },
				complete: function () { },
				success: function (res) {
					callBack(res);
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		}
	};
	var _common = {
		LoadCities: function (callBack) {
			var configAjax = {
				url: '/Home/PartialCities',
				type: 'GET',
				dataType: 'text',
				success: function (res) {
					callBack(res);
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		LoadDistricts: function (idCity, callBack) {
			var configAjax = {
				url: '/Home/PartialDistricts?idCity=' + idCity,
				type: 'GET',
				dataType: 'text',
				success: function (res) {
					callBack(res);
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		LoadWards: function (idDistrict, callBack) {
			var configAjax = {
				url: '/Home/PartialWards?idDistrict=' + idDistrict,
				type: 'GET',
				dataType: 'text',
				success: function (res) {
					callBack(res);
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		GetWard: function (idWard, callBack) {
			var configAjax = {
				url: urlApi + '/province/ward/' + idWard,
				type: 'GET',
				beforeSend: function () { },
				complete: function () { },
				success: function (res) {
					callBack(res);
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		FullAddress: function (idWard, callBack) {
			var configAjax = {
				url: urlApi + '/province/full-address/' + idWard,
				type: 'GET',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					callBack(data);
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
	};
	var _branchStore = {
		GetBranchStore: function (id, callBack) {
			var configAjax = {
				url: urlApi + '/branch-stores/' + id,
				type: 'GET',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					callBack(data);
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateBranchStore: function ($form) {
			var formData = new FormData();
			var image = $form.find('#uploadImageUpdate').val().replace(/C:\\fakepath\\/i, '')
			var id = $form.find('#id').val();
			var title = $form.find('#title').val();
			formData.append('file', $form.find('#uploadImageUpdate')[0].files[0]);
			formData.append('id', id);
			formData.append('name', title);
			formData.append('image', image);
			var configAjax = {
				url: '/Admin/BranchStore/UpdateBranchStore',
				type: 'POST',
				data: formData,
				beforeSend: function () { },
				complete: function () { },
				contentType: false,
				processData: false,
				success: function (res) {
					var data = res.data ?? res;
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		CreateBranchStore: function ($form) {
			var formData = new FormData();
			var image = $form.find('#uploadImageCreate').val().replace(/C:\\fakepath\\/i, '')
			var title = $form.find('#title').val();
			formData.append('file', $form.find('#uploadImageCreate')[0].files[0]);
			formData.append('name', title);
			formData.append('image', image);
			var configAjax = {
				url: '/Admin/BranchStore/CreateBranchStore',
				type: 'POST',
				data: formData,
				beforeSend: function () { },
				complete: function () { },
				contentType: false,
				processData: false,
				success: function (res) {
					var data = res.data ?? res;
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		DeleteBranchStore: function (id) {
			var configAjax = {
				url: '/Admin/BranchStore/DeleteBranchStore?idBranchStore=' + id,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (res) {
					var data = res.data ?? res;
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		ActiveBranchStore: function (id) {
			var configAjax = {
				url: '/Admin/BranchStore/ActiveBranchStore?idBranchStore=' + id,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (res) {
					var data = res.data ?? res;
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		}
	};
	var _consumpType = {
		GetCategoryConsumpType: function (id, callBack) {
			var configAjax = {
				url: urlApi + '/categories-consumptype/details/' + id,
				type: 'GET',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					callBack(data);
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		CreateCategoryConsumpType: function ($form) {
			var idCity = $form.find("#idCity").val();
			var title = $form.find("#title").val();
			var request = {
				IdCity: idCity,
				Title: title
			};
			var configAjax = {
				url: '/Admin/Category/CreateCategoryConsumptype',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					HideAllModal();
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateCategoryConsumpType: function ($form) {
			var id = $form.find("#id").val();
			var idCity = $form.find("#idCity").val();
			var title = $form.find("#title").val();
			var request = {
				Id: id,
				IdCity: idCity,
				Title: title
			};
			var configAjax = {
				url: '/Admin/Category/UpdateCategoryConsumptype',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					HideAllModal();
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		DeleteCategoryConsumpType: function (id) {
			var configAjax = {
				url: '/Admin/Category/DeleteCategoryConsumptype?idCategoryConsumptype=' + id,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (res) {
					var data = res.data ?? res;
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		GetConsumpType: function (id, callBack) {
			var configAjax = {
				url: urlApi + '/categories-consumptype/consumptypes/' + id,
				type: 'GET',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					callBack(data);
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		GetConsumpTypesByCategory: function (idCategory, callBack) {
			var configAjax = {
				url: '/Admin/Store/PartialConsumpType?idCategoryConsumpType=' + idCategory,
				type: 'GET',
				dataType: 'text',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					callBack(data);
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		CreateConsumpType: function ($form) {
			var idCategoryConsumpType = $form.find("#idCategoryConsumpType").val();
			var title = $form.find("#title").val();
			var request = {
				IdCategoryConsumpType: idCategoryConsumpType,
				Title: title
			};
			var configAjax = {
				url: '/Admin/Category/CreateConsumptype',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					HideAllModal();
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateConsumpType: function ($form) {
			var id = $form.find("#id").val();
			var idCategoryConsumpType = $form.find("#idCategoryConsumpType").val();
			var title = $form.find("#title").val();
			var request = {
				Id: id,
				IdCategoryConsumpType: idCategoryConsumpType,
				Title: title
			};
			var configAjax = {
				url: '/Admin/Category/UpdateConsumptype',
				type: 'POST',
				data: JSON.stringify(request),
				success: function (res) {
					HideAllModal();
					var data = res.data ?? res;
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				}
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		DeleteConsumpType: function (id) {
			var configAjax = {
				url: '/Admin/Category/DeleteConsumptype?idConsumptype=' + id,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
	};
	var _collection = {
		GetCollection: function (id, callBack) {
			var configAjax = {
				url: urlApi + '/collections/' + id,
				type: 'GET',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					callBack(data);
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		GetCollectionByCategory: function (idCategory, callBack) {
			var configAjax = {
				url: '/Admin/Store/PartialCollection?idCategoryConsumpType=' + idCategory,
				type: 'GET',
				dataType: 'text',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					callBack(data);
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		CreateCollection: function ($form) {
			var formData = new FormData();
			var image = $form.find('#uploadImageCreate').val().replace(/C:\\fakepath\\/i, '')
			var idCategoryConsumpType = $form.find('#idCategoryConsumpType').val();
			var title = $form.find('#title').val();
			var description = $form.find('#description').val();
			formData.append('file', $form.find('#uploadImageCreate')[0].files[0]);
			formData.append('title', title);
			formData.append('image', image);
			formData.append('idCategoryConsumpType', idCategoryConsumpType);
			formData.append('description', description);
			var configAjax = {
				url: '/Admin/Collection/CreateCollection',
				type: 'POST',
				data: formData,
				beforeSend: function () { },
				complete: function () { },
				contentType: false,
				processData: false,
				success: function (res) {
					var data = res.data ?? res;
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		UpdateCollection: function ($form) {
			var formData = new FormData();
			var image = $form.find('#uploadImageUpdate').val().replace(/C:\\fakepath\\/i, '')
			var idCategoryConsumpType = $form.find('#idCategoryConsumpType').val();
			var title = $form.find('#title').val();
			var id = $form.find('#id').val();
			var description = $form.find('#description').val();
			formData.append('file', $form.find('#uploadImageUpdate')[0].files[0]);
			formData.append('title', title);
			formData.append('image', image);
			formData.append('id', id);
			formData.append('idCategoryConsumpType', idCategoryConsumpType);
			formData.append('description', description);
			var configAjax = {
				url: '/Admin/Collection/UpdateCollection',
				type: 'POST',
				data: formData,
				beforeSend: function () { },
				complete: function () { },
				contentType: false,
				processData: false,
				success: function (res) {
					var data = res.data ?? res;
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							RedirectToUrl(res);
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		},
		DeleteCollection: function (id) {
			var configAjax = {
				url: '/Admin/Collection/DeleteCollection?idCollection=' + id,
				type: 'Get',
				beforeSend: function () { },
				complete: function () { },
				success: function (data) {
					HideAllModal();
					if (!data.isSuccess) {
						ShowPopupFail(data.data);
					} else {
						ShowPopupSuccess(data.data);
						setTimeout(function () {
							window.location.reload();
						}, 1500);
					}
				},
			}
			var callAjax = new AjaxOption(configAjax);
			callAjax.run();
		}
	};

	return {
		auth: _auth,
		homePage: _homePage,
		deal: _deal,
		store: _store,
		information: _information,
		cart: _cart,
		common: _common,
		branchStore: _branchStore,
		consumpType: _consumpType,
		collection: _collection,
	};
})();