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
	var htmlPhrase = '<li name="' + phrase + '">' +
											phrase +	
											'<input type="checkbox" class="remove">' +
									 '</li>'
	
	$('#sentences-list').append( htmlPhrase );
}

function addNewPhrase() {
	var newPhrase = $('#new-phrase-box').val();
	addPhraseToList(newPhrase);
	phrases.push(newPhrase);
}

function removePhrase() {
	$('#sentences-list').on('change','li',  function() {
		var phrase = $(this).attr('name');
		removeArrayPhrase(phrase);
		$(this).remove();
	});
}

function removeArrayPhrase(phrase) {
	var index = phrases.indexOf(phrase);
	phrases.splice(index, 1);
}

function setUpPhrasesList() {
	$('#sentences-list').empty();
	phrases.forEach( function(phrase) {
		addPhraseToList(phrase);
	});
}		

function highlightPhrase() {
	$('#sentences-list').on( 'mouseenter mouseleave', 'li',
		function(event) {
			$( this ).toggleClass( "list-highlight" );
		}
	); 
}

function showHidePhrases() {
	$('#show-hide').on('click', function() {
		$('#sentences-list').fadeToggle();	
	});
}

function refreshAfterPressButton() {
	$('#js-refresh-button').on('click', function() {
		updatePhrase(phrases);
	});
}

function addAfterPressEnter() {
	$('#new-phrase-box').on('keydown', function(event) {
		var enterKey = 13;
		if ( event.which === enterKey) {
			event.preventDefault();
			addNewPhrase();
			$("#new-phrase-box").val("");
			$("#provisional").remove();
		}
	});
}

function simultaneousTyping() {
	$("#new-phrase-box").on("input", function() {
		$("#provisional").remove();
		$("#sentences-list").append('<p id="provisional">' +
																					$("#new-phrase-box").val() + '</p>');
	});
}

setUpPhrasesList();

updatePhrase();

refreshAfterPressButton();

addAfterPressEnter();

showHidePhrases();

highlightPhrase();

simultaneousTyping();

removePhrase();
