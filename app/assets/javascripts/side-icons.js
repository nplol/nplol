$(document).ready(function() {
	
	var beginFixed = $('#side-icons').offset().top
	var fixed = false
	
	$(window).on('scroll', function() {

		if($(window).scrollTop() > beginFixed) {
			fixed = true
			$('#side-icons').css('position', 'fixed').css('margin-top', '0')
		}
		else if($(window).scrollTop() < beginFixed && fixed) {
			fixed = false
			$('#side-icons').css('position', 'absolute').css('margin-top', '15%')
		}

	})

	$(window).on('resize', function() {
			$('body').append('<div id="dummy"></div>')
			$('#dummy').css('position', 'absolute').css('margin-top', '15%').css('top', 0)
			beginFixed = $('#dummy').offset().top
			$('#dummy').remove()
	})

})
