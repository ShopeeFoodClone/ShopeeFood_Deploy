// Ajax option constructor
class AjaxOption {
	"use strict";
	statusCode = {
		401: function () { window.location.href = '/home/index' },
		404: function () { alert("404"); },
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
				console.log(XMLHttpRequest, textStatus, errorThrown);
			};
		this.statusCode = config.statusCode ?? this.statusCode
	}
	run() {
		$.ajax(this);
	}
}