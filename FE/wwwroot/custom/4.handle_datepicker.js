var _configDatePicker = (function () {
	"use strict";
	// Datepicker options...
	class DatepickerOption {
		constructor(config) {
			// Vietnamese language
			let paramVNLang = 'vi';
			this.changeMonth = config.changeMonth ?? true,
				this.changeYear = config.changeYear ?? true,
				this.dateFormat = config.dateFormat ?? 'mm/dd/yy',
				this.yearRange = config.yearRange ?? '+0Y',
				this.minDate = config.minDate ?? '+0Y',
				this.maxDate = config.maxDate ?? '+0Y',
				this.lang = config.lang ?? paramVNLang
			//this.showOn = "button",
			//this.buttonImage = "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
			//this.buttonImageOnly = true
		}
		getRegional() {
			return $.datepicker.regional[this.lang];
		}
		extend() {
			return $.extend({}, this.getRegional(), this);
		}
		run($element) {
			$element.datepicker(this.extend());
		}
	};
	var _init = function (selector, yearRange, minDate, maxDate, dateFormat, changeMonth, changeYear) {
		var $element = $(selector);
		var dateConfig = {
			changeMonth: changeMonth,
			dateFormat: dateFormat,
			yearRange: yearRange,
			minDate: minDate,
			maxDate: maxDate,
			changeYear: changeYear
		}
		var datepickerOption = new DatepickerOption(dateConfig);
		datepickerOption.run($element);
	};
	var _initDateMinus100 = function ($element) {
		var yearRange = '-100Y:+0Y';
		var minDate = '-100Y';
		var maxDate = '+0Y';
		_init($element, yearRange, minDate, maxDate);
	};
	var _initDateMinus100Plus50 = function ($element) {
		var yearRange = '-100Y:+50Y';
		var minDate = '-100Y';
		var maxDate = '+100Y';
		_init($element, yearRange, minDate, maxDate);
	};

	return {
		init: _init,
		initDateMinus100: _initDateMinus100,
		initDateMinus100Plus50: _initDateMinus100Plus50,
	}
})();