var fs = require('fs');
var fileActions = require('./fileactions.js');
fs.readFile("./Game_of_Thrones.JSON", 'utf8', fileActions);
