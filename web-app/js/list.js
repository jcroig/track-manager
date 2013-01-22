(function () {
	$('.delete-item').click(function (e) {
    	var form = $('<form method="post" action="' + $(this).data("url") + '"></form>');
		form.append('<input type="hidden" name="id" value="' + $(this).data("id") + '"/>');
		$('body').append(form);
		form.submit();
    });	
})();    