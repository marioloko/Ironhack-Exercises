function searchOnClick() {
	$('#js-search').on('click', function(event) {
		event.preventDefault();
		var searchTerm = getSearchTerm();
		search(searchTerm);
	});
}

function getSearchTerm () {
	return $("#search").val();
}

function search(searchTerm) {
	setInitialValues();
	var url = 'https://api.spotify.com/v1/search?type=track&query=' + searchTerm;
	$.get(url, function(search) {	
		var firstTrack = search.tracks.items[0];	
		updateSong(firstTrack);
	});
}

function updateSong(newTrack) {
	updateSongName(newTrack.name);
	updateSongAuthorName(newTrack.artists[0]);
	updateSongAlbumCover(newTrack.album.images);
	updateSongAudio(newTrack.preview_url);
}

function updateSongName(newTrackName) {
	$("#song-title").text(newTrackName);
}

function updateSongAuthorName(newTrackAuthor) {
	var authorName = newTrackAuthor.name;
	var authorId = newTrackAuthor.id;
	var authorLink = '<a id="artist-info" name="' + authorId + '">' + authorName + '</a>';
	$("#song-author").html(authorLink );
}

function updateSongAlbumCover(newTrackAlbumCover) {
	if(newTrackAlbumCover.length) {
		$("#album-cover").attr('src', newTrackAlbumCover[0].url);
	}
}

function updateSongAudio(newTrackAudio) {
	$("#song-audio").attr('src', newTrackAudio);
}

function playAfterPressButton() {
	$('#btn-play').on('click', function(event) {
		event.preventDefault();
		var playButton = this;
		updatePlayButton( playButton );      // Update the button image
		updateSongAudioState( playButton );  // After updating the image set the 
																				 // audio to the button image state
	});
}

function updatePlayButton(playButton) {
	$(playButton).toggleClass("playing");
}

function updateSongAudioState( playButton ) {
	if( $(playButton).hasClass("playing") ) {
		$("#song-audio").trigger('play');
	} else {
		$("#song-audio").trigger('pause');
	}
}

function updateBarOnTimeupdate() {
	$("#song-audio").on('timeupdate', updateProgressBar);
}

function updateProgressBar(){
	$('#progress-bar').val( $('#song-audio').prop('currentTime') );
}

function showModalAfterClickName() {
	$(document).on('click', '#artist-info', function() {
		var artistId = $( this ).attr('name');
		searchArtist(artistId);
		$("#artist-modal").modal();
	});
}

function searchArtist(authorId) {
	var url = 'https://api.spotify.com/v1/artists/' + authorId;
	$.get(url, function(artist) {
		updateModalName(artist.name);
		updateModalInfo(artist);
	});
}

function updateModalName(artistName) {
	$("#author-name-modal").text(artistName);
}

function updateModalInfo(artist){
	$("#author-info-modal").empty();
	var html = '<p><b>Genre:</b> ' + artist.genres[0] + '</p>';
	if (artist.images.length) {
		html += '<img class="cover" src="' + artist.images[0].url + '">';
	}
	html += '<p><b>Popularity:</b> ' + artist.popularity + '</p>'
	$("#author-info-modal").append(html);
}

function setInitialValues() {
	$('#progress-bar').val(0);
	$('#btn-play').removeClass('playing');
}

setInitialValues();

searchOnClick();

playAfterPressButton();

updateBarOnTimeupdate();

showModalAfterClickName();
