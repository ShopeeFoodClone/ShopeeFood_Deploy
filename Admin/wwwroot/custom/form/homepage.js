$(function () {
	//See more deals
	$("#see-more-deals").on('click', function () {
		var data = _callAjax.homePage.MoreDeal($(this), function (res) {
			var $div = $("#deals");
			res.forEach(function (e) {
				var card = `
				<div class="col-6 col-lg-4 col-md-6">
					<a href="/Store/DetailsStore?idStore=${e.id}" class="  text-decoration-none text-dark">
						<div class="card">
							<div class="card-body p-0">
								<img class="img-fluid" src="~/imgs/${e.image}" alt="Alternate Text" />
								<div class="p-2">
									<p class="mb-0 card-title fw-bold">${e.name}</p>
									<p class="mb-0 small card-text text-black">${e.address}</p>
								</div>
							</div>
							<div class="card-footer d-flex align-items-center bg-white p-2">
								<i class="fa-solid fa-tag text-danger"></i>
								<p class="ms-2 small mb-0 text-blue-dark fw-bold">${e.tagDeals}</p>
							</div>
						</div>
					</a>
				</div>
				`
				$div.append(card);
			});
		});
	});
	//See more collections
	$("#see-more-collections").on('click', function () {
		_callAjax.homePage.MoreCollection($(this), function (res) {
			var $div = $("#collections");
			res.forEach(function (e) {
				var card = `
				<div class="col-6 col-lg-4 col-md-6">
					<a href="/Collection/DetailsCollection?idCollection=${e.id}" class="text-decoration-none text-dark">
						<div class="card">
							<div class="card-body p-0">
								<img class="img-fluid" src="~/imgs/${e.image}" alt="Alternate Text" />
								<div class="p-2">
									<p class="mb-0 card-title fw-bold">${e.title}</p>
									<p class="small card-text mb-0 text-blue">${e.stores.length} địa điểm</p>
								</div>
							</div>
						</div>
					</a>
				</div>
				`
				$div.append(card);
			});
		});
	});
	//See more stores
	$('#section-store-common').on('click', '#see-more-stores',
		function () {
			var idDistrict = $('#slc-districts').find("option:selected").val();
			_callAjax.homePage.MoreStoreCommon($(this), idDistrict, function (res) {
				var $div = $("#store-common");
				res.forEach(function (e) {
					var card = `
					<a href="/Store/DetailsBranchStores?idStore=${e.id}" class="col-12 text-dark text-decoration-none">
						<div class="card">
							<div class="card-body p-0 col">
								<div class="row">
									<div class="col-5 col-lg-4">
									<img class="img-fluid " src="~/imgs/${e.image}" alt="Alternate Text" />
									</div>
									<div class="p-2 col-7 col-lg-8">
										<p class="mb-0 card-title fw-bold">${e.name} - ${e.address}</p>
										<p class="small mb-0 text-blue">${e.branchStore.numStoresOfBranch} địa điểm</p>
										<div class="d-flex align-items-center gap-2">
											<div class="d-flex align-items-center">
												<i class="fa-solid fa-tags"></i>
												<p class="ms-2 small mb-0">Tối thiểu 0k</p>
											</div>
											<div class="ms-2 d-flex align-items-center">
												<i class="fa-solid fa-money-bill"></i>
												<p class="ms-2 small mb-0">Giá 28k</p>
											</div>
										</div>
										<div class="d-flex align-items-center">
											<i class="fa-solid fa-tag"></i>
											<p class="ms-2 small mb-0">Giảm món</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</a>
				`
					$div.append(card);
				})
			});
		});
	// select districts change
	$("#slc-districts").on("change", function () {
		var idDistrict = $(this).find("option:selected").val();
		var $sectionStoreCommon = $('#store-common');
		_callAjax.homePage.SelectDistrict(idDistrict, function (res) {
			$sectionStoreCommon.html(res);
			$('#see-more-stores').attr("data-page-index", 2);
		});
	});
	// Search store recommend
	$('#search-text').on('change', function () {
		var $sectionRecommendSearch = $('#block-recommend');
		SearchStore($sectionRecommendSearch, $(this).val());
	});
	$('#search-text').on('input', function () {
		$(this).data('unsaved', true);
		clearTimeout(this.delayer);
		var context = this;
		this.delayer = setTimeout(function () {
			$(context).trigger('change');
		}, 1000);
	});
	$("#formSearchHomePage").submit(function (e) {
		e.preventDefault();
		var searchText = $(this).find("#search-text").val();
		_callAjax.store.Search(searchText);
	})
});

function SearchStore($box, key) {
	var $sectionRecommendSearch = $box;
	_callAjax.homePage.SearchBox(key, function (res) {
		$sectionRecommendSearch.html(res);
	});
}