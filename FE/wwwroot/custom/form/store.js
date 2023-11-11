$(function () {
	$("#dropdown-districts-submit").on("click", function () {
		var $dropdownDistricts = $("#dropdown-districts");
		var $dropdownConsumpTypes = $("#dropdown-consumpTypes");
		var searchText = $("#filter-store-search-text").val() ?? "";
		_callAjax.store.FilterStore($dropdownDistricts, $dropdownConsumpTypes, searchText);
	});
	$("#dropdown-consumpTypes-submit").on("click", function () {
		var $dropdownDistricts = $("#dropdown-districts");
		var $dropdownConsumpTypes = $("#dropdown-consumpTypes");
		var searchText = $("#filter-store-search-text").val() ?? "";
		_callAjax.store.FilterStore($dropdownDistricts, $dropdownConsumpTypes, searchText);
	});
	$(".clear-filter").on("click", function () {
		var type = $(this).attr("data-filter-type");
		var $dropdownDistricts = $("#dropdown-districts");
		var $dropdownConsumpTypes = $("#dropdown-consumpTypes");
		var searchText = $("#filter-store-search-text").val();
		if (type == "search-text") {
			searchText = ""
		}
		else if (type == "district") {
			$dropdownDistricts.find("input[type=checkbox]:checked").each(function () {
				$(this).removeAttr("checked");
			});
		} else if (type == "consump-type") {
			$dropdownConsumpTypes.find("input[type=checkbox]:checked").each(function () {
				$(this).removeAttr("checked");
			});
		}
		_callAjax.store.FilterStore($dropdownDistricts, $dropdownConsumpTypes, searchText);
	});
});