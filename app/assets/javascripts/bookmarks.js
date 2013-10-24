$(document).ready(function() {

	// bruk jquery waypoints

	var bookmarkLinks = $('.bookmark-link')

	bookmarkLinks.each(function(index, element) {
		createBookmark($(element))
	})

})

createBookmark = function(bookmarkLink) {
	
	var bookmark = $('<div class="bookmark"></div>')

	bookmark.text(bookmarkLink.attr('data-bookmark-text'))
	bookmark.css('top', bookmarkLink.offset().top)
	// set color as well, based on data-attribute
	createWaypoint(bookmarkLink)

	$('#bookmarks').append(bookmark)

}

createWaypoint = function(bookmarkLink) {

}