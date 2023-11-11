$(function () {
	$("#dropdown-districts-submit").on("click", function () {
		var $dropdown = $("#dropdown-districts");
		_callAjax.deal.FilterByDistricts($dropdown);
	});

	$(".clear-filter").on("click", function () {
		var type = $(this).attr("data-filter-type");
		var $dropdownDistricts = $("#dropdown-districts");
		if (type == "district") {
			$dropdownDistricts.find("input[type=checkbox]:checked").each(function () {
				$(this).removeAttr("checked");
			});
		}
		_callAjax.deal.FilterByDistricts($dropdownDistricts);
	});
});