var phrases = [
	'I like pie.',
	'Add some of your own phrases here.',
	'Make sure to follow all but the last phrase with a comma.'
];

function ramdomPhrase() {
	var index = Math.floor( Math.random() * phrases.length);
	return phrases[index];
}

function updatePhrase() {
	$('#phrase').html( ramdomPhrase(phrases) );
}

function addPhraseToList(phrase) {
	$('#sentences-list').append( '<li>' +	phrase + '</li>' );
}

function addNewPhrase() {
	var newPhrase = $('#new-phrase-box').val();
	phrases.push(newPhrase);
	addPhraseToList(newPhrase);
}

function setUpPhrasesList() {
	$('#sentences-list').empty();
	phrases.forEach( function(phrase) {
		addPhraseToList(phrase);
	});
}	

setUpPhrasesList();

updatePhrase();

$('#js-refresh-button').on('click', function() {
	updatePhrase(phrases);
});

$('#new-phrase-box').on('keydown', function(event) {
	var enterKey = 13;
	if ( event.which === enterKey) {
		event.preventDefault();
		addNewPhrase();
	}
});

$('#show-hide').on('click', function() {
	$('#sentences-list').fadeToggle();	
});
