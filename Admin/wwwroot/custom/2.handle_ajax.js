// Ajax option constructor
class AjaxOption {
	"use strict";
	statusCode = {
		401: function () { window.location.href = "/Auth/Login" },
		//404: function () { window.location.href = "/Home/Error?message=ERROR%20404" },
	}
	constructor(config) {
		this.type = config.type ?? 'GET';
		this.url = config.url;
		this.contentType = config.contentType ?? 'application/json charset=utf-8';
		this.dataType = config.dataType ?? 'json';
		this.data = config.data;
		this.async = config.async ?? true;
		this.cache = config.cache ?? false;
		this.processData = config.processData ?? true;
		this.beforeSend = config.beforeSend ?? function () {
			// TODO: Continue
			AppendLoading();
		};
		this.complete = config.complete ?? function () {
			// TODO: Continue
			RemoveLoading();
		};
		this.success = config.success ?? function () { };
		this.error = config.error ??
			function (XMLHttpRequest, textStatus, errorThrown) {
				if (textStatus == 'parsererror') {
					//window.location.href = "/Home/index"
				}
				console.log(XMLHttpRequest, textStatus, errorThrown);
			};
		this.statusCode = config.statusCode ?? this.statusCode
	}
	run() {
		$.ajax(this);
	}
}