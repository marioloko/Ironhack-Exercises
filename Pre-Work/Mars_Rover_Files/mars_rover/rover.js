var myRover = {
  position: [0,0], 
  direction: 'N',
};

var otherRover = {
	position: [9,9],
	direction: 'S'
};

EMPTY_POSITION = ' ';
OBJECT_POSITION = '#'

// Setting up the grid
var GRID_SIZE = 10; // We fix the size of the GRID, it will be an square grid

var grid = [];

for ( var pos = 0; pos < GRID_SIZE; pos++ ) {
	var grid_row = []
	for ( var innerPos = 0; innerPos < GRID_SIZE; innerPos++ ) {
		grid_row.push(EMPTY_POSITION); // Each position will be an empty string
	}
	grid.push(grid_row); // Each row will be another array filled with 
											 // empty strings.
}

// we fix several position like object positions
grid[4][4] = OBJECT_POSITION; 
grid[2][6] = OBJECT_POSITION;
grid[3][7] = OBJECT_POSITION;
grid[9][1] = OBJECT_POSITION;

function goForward(rover) {
  switch(rover.direction) {
    case 'N':
			moveNorth( rover );
      break;
    case 'E':
			moveEast( rover );
      break;
    case 'S':
			moveSouth( rover );
      break;
    case 'W':
			moveWest( rover );
      break;
  };

  console.log("New Rover Position: [" + rover.position[0] + ", " + rover.position[1] + "]")
}

function changeDirection ( rover, direction ) {
	if ( direction === 'N' || direction === 'E' || direction === 'S' 
				|| direction === 'W' ) {
		rover.direction = direction;
	}
}

function myRoverForward () {
	goForward( myRover );
}

function otherRoverForward () {
	goForward( otherRover );
}

function myRoverDirection ( direction ) {
	changeDirection( myRover, direction );
}

function otherRoverDirection ( direction ) {
	changeDirection( otherRover, direction );
}

function inTopWall ( rover ) {
	if ( rover.position[0] < grid.length ) {
		return false;
	} else {
		return true;
	}
}

function inBottomWall ( rover ) {
	if ( rover.position[0] > 0 ) {
		return false;
	} else {
		return true;
	}
}

function inLeftWall ( rover ) {
	if ( rover.position[1] > 0  ) {
		return false;
	} else {
		return true;
	}
}

function inRightWall ( rover ) {
	if ( rover.position[1] < grid[0].length ) {
		return false;
	} else {
		return true;
	}
}

function northPositionObject ( rover ) {
	var nextNorth = (rover.position[0] + 1) % grid.length;
	var northPosition = grid[ nextNorth ][ rover.position[1] ];
	if ( northPosition === OBJECT_POSITION ) {
		return true;
	} else {
		return false;
	}
}
		
function southPositionObject ( rover ) {
	var nextSouth = (rover.position[0] - 1 > 0) ? rover.position[0] - 1 : 9;
	var southPosition = grid[ nextSouth ][ rover.position[1] ];
	if ( southPosition === OBJECT_POSITION ) {
		return true;
	} else {
		return false;
	}
}
	
function eastPositionObject ( rover ) {
	var nextEast = (rover.position[1] + 1 ) % grid[0].length;
	var eastPosition = grid[ rover.position[0]][ nextEast ];
	if ( eastPosition === OBJECT_POSITION ) {
		return true;
	} else {
		return false;
	}
} 

function westPositionObject ( rover ) {
	var nextWest = (rover.position[1] - 1 > 0 ) ? rover.position[1] - 1 : 9;
	var westPosition = grid[ rover.position[0]][ rover.position[1] -1 ];
	if ( westPosition === OBJECT_POSITION ) {
		return true;
	} else { 
		return false;
	}
}

function getCellEmpty( rover ) { // Get the cell empty before leave the cell
	var x_pos = rover.position[0];
	var y_pos = rover.position[1];
	grid[x_pos][y_pos] = EMPTY_POSITION;
}

function getCellFull( rover ) { // Fill the cell when the rover is over there
	var x_pos = rover.position[0];
	var y_pos = rover.position[1];
	grid[x_pos][y_pos] = OBJECT_POSITION;
}

function moveNorth ( rover ) {
	if ( !northPositionObject ( rover ) ) {
		getCellEmpty(rover);
		rover.position[0] = ( rover.position[0] + 1 ) % grid.length;
		getCellFull(rover);
	} else {
		console.log('Obstacle at North');
	}
}

function moveSouth ( rover ) {
	if ( !southPositionObject ( rover ) ) {
		getCellEmpty(rover);
		var newPosition = rover.position[0] - 1;
		rover.position[0] = (newPosition < 0) ? grid.length - 1 : newPosition;
		getCellFull(rover);
	} else {
		console.log('Obstacle at South');
	}
}

function moveEast ( rover ) {
	if ( !eastPositionObject ( rover ) ) {
		getCellEmpty(rover);
		rover.position[1] = ( rover.position[1] + 1 ) % grid.length;
		getCellFull(rover);
	} else {
		console.log('Obstacle at East');
	}
}

function moveWest ( rover ) {
	if ( !westPositionObject ( rover ) ) {
		getCellEmpty(rover);
		var newPosition = rover.position[1] - 1;
		rover.position[1] = (newPosition < 0) ? grid.length - 1 : newPosition;
		getCellFull(rover);
	} else {
		console.log('Obstacle at West');
	}
}	

function commandToDirection ( rover, command ) {
	switch( command ) {
		case 'f':
			changeDirection( rover, 'N' );	
			break;
		case 'b':
			changeDirection( rover, 'S' );
			break;
		case 'r':
			changeDirection( rover, 'E' );
			break;
		case 'l':
			changeDirection( rover, 'W' );
			break;
	}
}
	
function arrayMovements( rover, array ) {
	var pos;
	for ( pos = 0; pos < array.length; pos++ ) {
		commandToDirection( rover, array[pos] );
		goForward( rover );
	}
}

function myRoverArray( array ) {
	arrayMovements( myRover, array );
}

function otherRoverArray( array ) {
	arrayMovements( otherRoveotherRover, array );
}

