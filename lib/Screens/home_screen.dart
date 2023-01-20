import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isTurnO = true;
  List<String> XorOList = ['','','','','','','','',''];
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreX = 0;
  int scoreO = 0;
  String winnerTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('TicTacToe', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                scoreO = 0;
                scoreX = 0;
              });
              clearGame();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            getScoreBoard(),
            SizedBox(height: 20.0),
            getResultButton(),
            SizedBox(height: 20.0,),
            Expanded(child: getGridView()),
            getTurn(),
            SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        child: Text('$winnerTitle, play again!', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: BorderSide(color: Colors.white, width: 2),
        ),
        onPressed: () {
          setState(() {
            gameHasResult = false;
            clearGame();
          });
        },
      ),
    );
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget getGridView() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 9,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            tapped(index);
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Center(
              child: Text(
                XorOList[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  color: XorOList[index] == 'O' ? Colors.white : Colors.red,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void tapped(int index){

    if(gameHasResult) {
      return;
    }

    setState((){
      if(XorOList[index] != '') {
        return;
      }

      if(isTurnO) {
        XorOList[index] = 'O';
        filledBoxes = filledBoxes + 1;
      } else {
        XorOList[index] = 'X';
        filledBoxes = filledBoxes + 1;
      }

      isTurnO = !isTurnO;

      checkWinner();

    });
  }

  void checkWinner() {
    if(XorOList[0] == XorOList[1] &&
        XorOList[0] == XorOList[2] &&
        XorOList[0] != '') {
      setResult(XorOList[0], 'winner is ' + XorOList[0]);
      return;
    }

    if(XorOList[3] == XorOList[4] &&
        XorOList[3] == XorOList[5] &&
        XorOList[3] != '') {
      setResult(XorOList[3], 'winner is ' + XorOList[3]);
      return;
    }

    if(XorOList[6] == XorOList[7] &&
        XorOList[6] == XorOList[8] &&
        XorOList[6] != '') {
      setResult(XorOList[6], 'winner is ' + XorOList[6]);
      return;
    }

    if(XorOList[0] == XorOList[3] &&
        XorOList[0] == XorOList[6] &&
        XorOList[0] != '') {
      setResult(XorOList[0], 'winner is' + XorOList[0]);
      return;
    }

    if(XorOList[1] == XorOList[4] &&
        XorOList[1] == XorOList[7] &&
        XorOList[1] != '') {
      setResult(XorOList[1], 'winner is ' + XorOList[1]);
      return;
    }

    if(XorOList[2] == XorOList[5] &&
        XorOList[2] == XorOList[8] &&
        XorOList[2] != '') {
      setResult(XorOList[2], 'winner is ' + XorOList[2]);
      return;
    }

    if(XorOList[0] == XorOList[4] &&
        XorOList[0] == XorOList[8] &&
        XorOList[0] != '') {
      setResult(XorOList[0], 'winner is ' + XorOList[0]);
      return;
    }

    if(XorOList[2] == XorOList[4] &&
        XorOList[2] == XorOList[6] &&
        XorOList[2] != '') {
      setResult(XorOList[2], 'winner is ' + XorOList[2]);
      return;
    }

    if(filledBoxes == 9) {
      setResult('', 'Draw');
    }

  }

  Widget getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children:[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Player O', style: TextStyle(fontSize: 25.0, color: Colors.white),),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('$scoreO', style: TextStyle(fontSize: 25.0, color: Colors.white),),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children:[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Player X', style: TextStyle(fontSize: 25.0, color: Colors.white),),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('$scoreX', style: TextStyle(fontSize: 25.0, color: Colors.white),),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;
      if(winner == 'X'){
        scoreX = scoreX + 1;
      } else if(winner == 'O') {
        scoreO = scoreO + 1;
      } else {}

    });
  }

  void clearGame() {
    setState(() {
      for(int i = 0; i < XorOList.length; i++) {
        XorOList[i] = '';
      }
      filledBoxes = 0;
    });
  }

}
