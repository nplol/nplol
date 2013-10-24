$(document).ready(function() {

	// jQuery-plugin: add items to stick in array, sticky-items
	// keep track of their respective offsets, and recalculate whenever
	// window is resized. Maybe using underscore might be a good idea.

	var beginFixed = $('#log-in').offset().top
	var fixed = false
	
	$(window).on('scroll', function() {

		if($(window).scrollTop() > beginFixed) {
			fixed = true
			$('#log-in').css('position', 'fixed').css('margin-top', '1%')
		}
		else if($(window).scrollTop() < beginFixed && fixed) {
			fixed = false
			$('#log-in').css('position', 'absolute').css('margin-top', '5%')
		}

	})

	// when window resizes, add a dummy-div to where the new beginOffset
	// should be located. Then caluclate the offset based on this.
	$(window).on('resize', function() {
			$('body').append('<div id="dummy"></div>')
			$('#dummy').css('position', 'absolute').css('margin-top', '5%').css('top', 0)
			beginFixed = $('#dummy').offset().top
			$('#dummy').remove()
	})

})