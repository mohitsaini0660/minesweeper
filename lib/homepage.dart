import 'package:flutter/material.dart';
import 'package:minesweeper/bomb.dart';
import 'package:minesweeper/numberbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variables
  int numberOfSquares = 9 * 9;
  int numberInEachRow = 9;
  //number of bombs around, reveealed = true/false
  var squareStatus = [];

  //bomb locations
  final List<int> bombLocation = [
    48,
    40,
    60,
    17,
    9,
    10,
    60,
  ];

  bool bombsRevealed = false;

  @override
  void initState() {
    super.initState();
    // initially, each square zhas 0 bombs around, and is not revealed
    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
    scanBombs();
  }

  void restartGame() {
    setState(() {
      bombsRevealed = false;
      for (int i = 0; i < numberOfSquares; i++) {
        squareStatus[i][1] = false;
      }
    });
  }

  void revealBoxNumbers(int index) {
    // reveal current box if it is a number : 1,2,3 etc
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
      });
    }
    // if current box is 0
    else if (squareStatus[index][0] == 0) {
      // reveal current box, and the 8 surrounding boxes, unless you're on a wall
      setState(() {
        // reveal current box
        squareStatus[index][1] = true;
        // reveael left box (unless we are currently on the left wall)
        if (index % numberInEachRow != 0) {
          // if next box isn't revealed yet and it is a 0, then rescue
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxNumbers(index - 1);
          }

          // revealed left box
          squareStatus[index - 1][1] = true;
        }

        // reveael left box (unless we are currently on the left wall)
        if (index % numberInEachRow != 0 && index >= numberInEachRow) {
          // if next box isn't revealed yet and it is a 0, then recurse
          if (squareStatus[index - 1 - numberInEachRow][0] == 0 &&
              squareStatus[index - 1 - numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 - numberInEachRow);
          }

          // revealed left box
          squareStatus[index - 1 - numberInEachRow][1] = true;
        }

        // reveael top box (unless we are currently on the top row wall)
        if (index >= numberInEachRow) {
          // if next box isn't revealed yet and it is a 0, then recurse
          if (squareStatus[index - numberInEachRow][0] == 0 &&
              squareStatus[index - numberInEachRow][1] == false) {
            revealBoxNumbers(index - numberInEachRow);
          }

          // revealed left box
          squareStatus[index - numberInEachRow][1] = true;
        }

        // reveael right box (unless we are currently on the right wall)
        if (index % numberInEachRow != numberInEachRow - 1) {
          // if next box isn't revealed yet and it is a 0, then recurse
          if (squareStatus[index + 1][0] == 0 &&
              squareStatus[index + 1][1] == false) {
            revealBoxNumbers(index + 1);
          }

          // revealed left box
          squareStatus[index + 1][1] = true;
        }

        // reveael bottom right box (unless we are currently on the bottom row or the right wall)
        if (index < numberOfSquares - numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          // if next box isn't revealed yet and it is a 0, then recurse
          if (squareStatus[index + 1 + numberInEachRow][0] == 0 &&
              squareStatus[index + 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index + 1 + numberInEachRow);
          }

          // revealed left box
          squareStatus[index + 1 + numberInEachRow][1] = true;
        }

        // reveael bottom box (unless we are currently on the bottom wall)
        if (index < numberOfSquares - numberInEachRow) {
          // if next box isn't revealed yet and it is a 0, then recurse
          if (squareStatus[index + numberInEachRow][0] == 0 &&
              squareStatus[index + numberInEachRow][1] == false) {
            revealBoxNumbers(index + numberInEachRow);
          }

          // revealed left box
          squareStatus[index + numberInEachRow][1] = true;
        }

        // reveael bottom left box (unless we are currently on the bottom row or left wall)
        if (index < numberOfSquares - numberInEachRow &&
            index % numberInEachRow != 0) {
          // if next box isn't revealed yet and it is a 0, then recurse
          if (squareStatus[index - 1 + numberInEachRow][0] == 0 &&
              squareStatus[index - 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 + numberInEachRow);
          }

          // revealed left box
          squareStatus[index - 1 + numberInEachRow][1] = true;
        }
      });
    }
  }

  void scanBombs() {
    for (int i = 0; i < numberOfSquares; i++) {
      // there are no bombs around initially
      // ignore: unused_local_variable
      int numberOfBombsAround = 0;

      // check each square to see if it has bombs surrounding It
      // there are 8 surrounding boxes to check

      //check square to the left, unless it is in the first column
      if (bombLocation.contains(i - 1) && i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }

      // check square to the top left, unless it is in the first column or first row
      if (bombLocation.contains(i - 1 - numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i >= numberInEachRow) {
        numberOfBombsAround++;
      }

      // check square  to the top, unless it is in the first row
      if (bombLocation.contains(i - numberInEachRow) && i >= numberInEachRow) {
        numberOfBombsAround++;
      }

      //  check square  to the top right , unless it is in the first row or last column
      if (bombLocation.contains(i + 1 - numberInEachRow) &&
          i >= numberInEachRow &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombsAround++;
      }

      // check square to the bottom right, unless it is in the last column or last row
      if (bombLocation.contains(i + 1 + numberInEachRow) &&
          i % numberInEachRow != numberInEachRow - 1 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      // check square  to the bottom , unless it is in the last  row
      if (bombLocation.contains(i + numberInEachRow) &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      //  check square  to the bottom left, unless it is in the last row and first column
      if (bombLocation.contains(i - 1 + numberInEachRow) &&
          i < numberOfSquares - numberInEachRow &&
          i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }

      // add totoal numberr of bombs around the squarrr status
      setState(() {
        squareStatus[i][0] = numberOfBombsAround;
      });
    }
  }

  void playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: Center(
              child: Text(
                'You Lost!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              MaterialButton(
                color: Colors.grey[100],
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: Icon(Icons.refresh),
              )
            ],
          );
        });
  }

  void playerWon() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            title: const Center(
              child: Text(
                'You Win!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              MaterialButton(
                color: Colors.grey[100],
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.grey[300],
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(Icons.refresh),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void checkWinner() {
    // check how many boxes yet to reveal
    // ignore: unused_local_variable
    int unrevealedBoxes = 0;
    for (int i = 0; i < numberOfSquares; i++) {
      if (squareStatus[i][1] == false) {
        unrevealedBoxes++;
      }
    }

    if (unrevealedBoxes == bombLocation.length) {
      playerWon();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // game starts and menu
          SizedBox(
            height: 150,
            //color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // display number of bombs
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '6',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text('B O M B '),
                  ],
                ),

                // refresh the game
                GestureDetector(
                  onTap: restartGame,
                  child: Card(
                    color: Colors.grey[700],
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                // display time taken
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '0',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text('T I M E'),
                  ],
                ),
              ],
            ),
          ),
          //grid
          Expanded(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInEachRow),
                itemBuilder: (context, index) {
                  if (bombLocation.contains(index)) {
                    return MyBomb(
                      revealed: bombsRevealed,
                      function: () {
                        // player tapped the bomb, so player loses\
                        setState(() {
                          bombsRevealed = true;
                        });
                        playerLost();
                      },
                    );
                  } else {
                    return MyNumberBox(
                      child: squareStatus[index][0],
                      revealed: squareStatus[index][1],
                      function: () {
                        //reveal current box
                        revealBoxNumbers(index);
                        checkWinner();
                      },
                    );
                  }
                }),
          ),

          //branding
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Text('C R E A T E D B Y E Q U A T I O N'),
          )
        ],
      ),
    );
  }
}
