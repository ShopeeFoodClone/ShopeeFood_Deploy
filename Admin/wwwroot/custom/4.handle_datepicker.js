var _configDatePicker = (function () {
	"use strict";
	// Datepicker options...
	class DatepickerOption {
		constructor(config) {
			// Vietnamese language
			let paramVNLang = 'vi-VN';
			this.changeMonth = config.changeMonth ?? true,
				this.changeYear = config.changeYear ?? true,
				this.dateFormat = config.dateFormat ?? 'dd/mm/yy',
				this.yearRange = config.yearRange ?? '+0Y',
				this.minDate = config.minDate ?? '+0Y',
				this.maxDate = config.maxDate ?? '+0Y',
				this.lang = config.lang ?? paramVNLang
		}
		getRegional() {
			return $.datepicker.regional[this.lang] = {
				closeText: "Đóng",
				prevText: "Trước",
				nextText: "Sau",
				currentText: "Hôm nay",
				monthNames: ["Tháng một", "Tháng hai", "Tháng ba", "Tháng tư", "Tháng năm", "Tháng sáu", "Tháng bảy", "Tháng tám", "Tháng chín", "Tháng mười", "Tháng mười một", "Tháng mười hai"],
				monthNamesShort: ["Một", "Hai", "Ba", "Bốn", "Năm", "Sáu", "Bảy", "Tám", "Chín", "Mười", "Mười một", "Mười hai"],
				dayNames: ["Chủ nhật", "Thứ hai", "Thứ ba", "Thứ tư", "Thứ năm", "Thứ sáu", "Thứ bảy"],
				dayNamesShort: ["CN", "Hai", "Ba", "Tư", "Năm", "Sáu", "Bảy"],
				dayNamesMin: ["CN", "T2", "T3", "T4", "T5", "T6", "T7"],
				weekHeader: "Tuần",
				dateFormat: "dd/mm/yy",
				firstDay: 1,
				isRTL: false,
				showMonthAfterYear: false,
				yearSuffix: ""
			};
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