function fileActions(err, file) {
	if (err) {
		throw err;
	}
	var episodes = JSON.parse(file);
	episodes = sortEpisodes(episodes); 
	// episodes = filterEpisodes(episodes); // Uncomment for show the episodes
																			 		// with less than 8.5 rating.
	// episodes = searchFor(episodes);      // Uncomment for show only the Jon
																					// Snow chapters.
	printFormat(episodes);
}

function printFormat(episodes) {
	episodes.forEach(function (episode) {
		console.log('Title: ' + episode.title + ' #: '
				 + episode.episode_number);
		console.log(episode.description);

		rating = episode.rating
		console.log('Rating: ' + rating + ' ' + printStars(rating));
		console.log();
	});
}

function printStars(rating) {
	var allStarRating = "";

	var star;
	rating = Math.floor(rating);
	for (star = 0; star < rating; star++) {
		allStarRating += "*";
	}
	return allStarRating;
}

function sortEpisodes(episodes) {
	var sortedEpisodes = episodes.sort(function(firstEpisode, secondEpisode) {
		return firstEpisode.episode_number - secondEpisode.episode_number;
	});
	return sortedEpisodes;
}

function filterEpisodes(episodes) {
	var filteredEpisodes = episodes.filter( function (episode) {
		return episode.rating >= 8.5;
	});
	return filteredEpisodes;
}

function searchFor(episodes) {
	var isJon = episodes.filter( function (episode) {
		return episode.description.indexOf('Jon') >= 0;	
	});
	return isJon;
}

module.exports = fileActions;
