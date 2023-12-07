function handleUploadImages() {
	var $imgUploads = $('.img-upload');
	$imgUploads.each(function () {
		var $img = $(this).find('img');
		var $input = $(this).find('input');
		$input.change(function () {
			const file = this.files[0];
			let reader = new FileReader();
			reader.onload = function (event) {
				$img.attr('src', event.target.result);
			}
			reader.readAsDataURL(file);
		});
	})
}