var read = require('read');
var fs = require('fs');

options = {
	prompt: "> \n"
}

var User = function(name, points, currentQuestionId) {
	this.name = name;
	this.points = points;
	this.currentQuestionId = currentQuestionId;
}

var Question = function(question, answer, id, points) {
	this.question = question;
	this.answer = answer;
	this.id = id;
	this.points = points;
}

var Quiz = function(user) {
	this.questions = [];
	this.user = user;
	this.nextId = this.user.currentQuestionId;
	this.bonus = Math.floor( Math.random() * this.questions.length ); //Choose randomly a random question

	this.makeNewQuestion = function() {
		console.log("You have: " + this.user.points + " points.");
		this.isBonus();
		console.log(this.questions[this.nextId].question);
		read(options, this.checkIfSave.bind(this));
	}

	this.checkIfSave = function(error, answer) {
		if (answer.toLowerCase() === 'save') {
		 this.saveQuiz();
		} else {
			this.checkQuestion(error, answer);
		}
	}
	
	this.checkQuestion = function(err, answer) {
		answer = answer.toLowerCase();
		if(this.questions[this.nextId].answer === answer) {
			this.correctAnswer();

		} else {
			this.incorrectAnswer();

		}
		console.log();
		this.makeNewQuestion();
	}

	this.correctAnswer = function() {
			console.log("RIGHT!!!");

			points = this.questions[this.nextId].points;
			if(this.nextId == this.bonus) {
				points *= 2;
			}

			this.user.points += points;
			this.nextId = Math.floor( Math.random() * this.questions.length); //Change to another random question
	}

	this.incorrectAnswer = function() {
			console.log("Wrong");
			this.user.points -= this.questions[this.nextId].points;
	}

	this.isBonus = function() {
		if(this.nextId === this.bonus) {
			console.log("****************** BONUS QUESTION ***********************");
		}
	}

	this.initializeQuiz = function() {
		fs.readFile("Questions.JSON", 'utf8', function(error, file) {
			if (error) {
				throw error;
			}
			var questions = JSON.parse(file);
			this.loadQuestions(questions, this.makeNewQuestion);
		}.bind(this));
	}

	this.loadQuestions = function(questions, callback) {
		function load(index) {
			if (index < questions.length) {
				this.questions.push(questions[index]);
				load.apply(this,[index + 1]);
			}
		}
		load.apply(this,[0]);
		callback.apply(this);
	}

	this.saveQuiz = function() {
		var userIndex;	
		fs.readFile("users.JSON", function(fileError, file) {
			if(fileError) {
				throw fileError;
			}
			var users = JSON.parse(file);
			this.saveUser(users);
		}.bind(this));	
	}

	this.saveUser = function(users) {
		function save(index) {
			if (index === users.length  || this.user.name === users[index].name) {
				users[index] = this.user;
			} else {
				save.apply(this,[index + 1]);
			}
		}
		save.apply(this,[0]);
		fs.writeFile("users.JSON",JSON.stringify(users, null, 4));
	}
}

var Game = function() {
	this.quiz;

	this.run = function() {
		console.log("New User?");
		read(options,this.checkAnswer.bind(this));
	}

	this.checkAnswer = function(error, answer) {
		answer = answer.toLowerCase();
		if (answer === "yes") {
			console.log("Please enter your new username");
			read(options,this.register.bind(this));

	  }	else if (answer === "no") {
			console.log("Please enter your username");
			read(options, function(readingError, name) {;
				fs.readFile("users.JSON", 'utf8', function(fileError, file) {
					var users = JSON.parse(file);
					this.checkUser(users, name);
				}.bind(this));
			}.bind(this));

		} else {
			console.log("I have not understand you");
			this.run();
		}
	}

	this.register = function(error, name) {
		name = name.toLowerCase();
		var user = new User(name, 0, 0);
		this.start(user, this.showCurrentLeader);
	}

	this.loadUser = function(user) {
		var loadedUser = new User(user.name, user.points, user.currentQuestionId);
		this.start(loadedUser, this.showCurrentLeader);
	}

	this.checkUser = function(users, name) {
		name = name.toLowerCase();
		function check(index) {
			if (index >= users.length) {
				console.log("User not found");
				this.run();
			} else if (users[index].name === name) {
				this.loadUser(users[index]);
			} else {
				check.apply(this, [index + 1]);
			}
		}
		check.apply(this,[0]);
	}

	this.start = function(user, callback) {
		this.quiz = new Quiz(user);
		this.quiz.initializeQuiz();
	}
}

var game = new Game();
game.run();
