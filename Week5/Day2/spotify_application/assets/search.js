String.prototype.capitalize = function() {
	return this.charAt(0).toUpperCase() + this.slice(1);
}

function getArtistName() {
	return $('input[name=artist-name]').val();
}

function getId(artistOrAlbum) {
	return $(artistOrAlbum).attr("name");		
}

function getArtistsJSON(search) {
	var url = 'https://api.spotify.com/v1/search?type=artist&query=' + search;
	$.getJSON( url, function(search) {
		addObjectsToList(search.artists.items, 'artist');	
	}); 
}

function addObjectsToList(objectsItem, type) {
	$("#" + type + "-list").empty();
	objectsItem.forEach( function( object ) {
		$("#" + type + "-list").append( formatObjectListItem(object, type) );
	});
}

function formatObjectListItem(object, type) {
	var html = '<li class="list-unstyled select-' + type;
	html += '" name="' + object.id + '">';
	html +=	'<p>' + type.capitalize() + ': ' + object.name + '</p>';
	if (object.images.length > 0) {
		html += '<img src="' + object.images[0].url + '" width="300">';
	}
	html += '<br>'
	html += '</li>'
	return html;
}

function formatSongListItem( song ) {
	var html = '<a target="_blank" href="' + song.preview_url + '">';
	html += '<li class="list-unstyled select-song';
	html += '" name="' + song.id + '">';
	html +=	'<p>Song: ' + song.name + '</p>';
	html += '</li>'
	return html;
}

function getArtistAlbums(id) {
	$.getJSON('https://api.spotify.com/v1/artists/' + id + '/albums',
		 function(albums){
		addObjectsToList( albums.items, 'album' );
	});
}

function addSongsToList(songItems) {
	$("#song-list").empty();
	songItems.forEach( function( song ) {
		$("#song-list").append( formatSongListItem( song ) );
	});
}

function getAlbumsSongs(id) {
	$.getJSON('https://api.spotify.com/v1/albums/' + id + '/tracks', 
			function(songs){
		addSongsToList( songs.items );
	});
}


$('#js-submit').on('click', function(event) {
	event.preventDefault();
	var search = getArtistName();
	getArtistsJSON(search);
});

$('#artist-list').on('click','.select-artist', function(event) {
	event.preventDefault();
	var artist = this;
	var artistId = getId(artist);
	getArtistAlbums(artistId);
	$('#albumModal').modal('toggle');
});

$('#album-list').on('click','.select-album', function(event) {
	event.preventDefault();
	var album = this;
	var albumId = getId(album);
	getAlbumsSongs(albumId);
	$('#songModal').modal('toggle');
});
