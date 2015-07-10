var myRover = {
  position: [0,0], 
  direction: 'N',
};

// Setting up the grid
var GRID_SIZE = 10; // We fix the size of the GRID, it will be an square grid

var grid = [];

for ( var pos = 0; pos < GRID_SIZE; pos++ ) {
	var grid_row = []
	for ( var innerPos = 0; innerPos < GRID_SIZE; innerPos++ ) {
		grid_row.push(" "); // Each position will be an empty string
	}
	grid.push(grid_row); // Each row will be another array filled with 
											 // empty strings.
}

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

function myRoverDirection ( direction ) {
	changeDirection( myRover, direction );
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

function moveNorth ( rover ) {
	if ( !inTopWall ( rover ) ) {
		rover.position[0]++;
	}
}

function moveSouth ( rover ) {
	if ( !inBottomWall ( rover ) ) {
		rover.position[0]--;
	}
}

function moveEast ( rover ) {
	if ( !inRightWall ( rover ) ) {
		rover.position[1]++;
	}
}

function moveWest ( rover ) {
	if ( !inLeftWall ( rover ) ) {
		rover.position[1]--;
	}
}	
