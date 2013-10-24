$(document).ready(function() {
	setupFaces($('.comment'))
})

setupFaces = function(comments) {

	comments.each(function(index, comment) {
		$(comment).siblings('.comment-face').css('top', $(comment).offset().top)
		$(comment).hover(function() {
			$(this).siblings().addClass('active')
		}, function() {
			$(this).siblings().removeClass('active')
		})
	})

}