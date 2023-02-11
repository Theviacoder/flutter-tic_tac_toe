import 'package:flutter/material.dart';
import 'package:tictactoegame/constants/padding.dart';
import 'package:tictactoegame/constants/color.dart';
import 'package:tictactoegame/constants/text.dart';

import '../features/widget.dart';
import 'alert_diiaolog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final space = const SizedBox(height: 20);
  final title = "Tic Tac Toe";
  int _scoreX = 0;
  int _scoreO = 0;
  bool _turnOfO = true;
  int _filledBoxes = 0;
  final List<String> _xOrOList = <String>[
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility().bgColor,
      appBar: AppBar(
          backgroundColor: ColorUtility().bgColor,
          centerTitle: true,
          elevation: 0,
          actions: [IconButton(onPressed: () => _clearBoard(), icon: Icon(Icons.refresh_rounded))],
          title: Text(title, style: titleTextStyle())),
      body: Column(
        children: [_buildScoreTable(), _buildGameBoard(), _buildTurn()],
      ),
    );
  }

  Expanded _buildGameBoard() {
    return Expanded(
      flex: 3,
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _tapped(index),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: ColorUtility().border)),
              child: Center(
                child: Text(
                  _xOrOList[index],
                  style: TextStyle(
                      color: _xOrOList[index] == 'x' ? ColorUtility().white : ColorUtility().blue, fontSize: 50),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded _buildScoreTable() {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlayerScoreBoard(player: "Player O", space: space, score: _scoreO),
            PlayerScoreBoard(player: "Player X", space: space, score: _scoreX)
          ],
        ),
      ),
    );
  }

  Widget _buildTurn() {
    return Container(
      child: Padding(
        padding: PaddingUtility().turnPlayerPadding,
        child: Center(
          child: Text(
            _turnOfO ? 'Turn of O' : 'Turn of X',
            style: customTextStyle(
              color: ColorUtility().white,
            ),
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (_turnOfO && _xOrOList[index] == '') {
        _xOrOList[index] = 'o';
        _filledBoxes += 1;
      } else if (!_turnOfO && _xOrOList[index] == '') {
        _xOrOList[index] = 'x';
        _filledBoxes += 1;
      }

      _turnOfO = !_turnOfO;
      _checkTheWinner();
    });
  }

  Future<void> _checkTheWinner() async {
    // check first row
    if (_xOrOList[0] == _xOrOList[1] && _xOrOList[0] == _xOrOList[2] && _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check second row
    if (_xOrOList[3] == _xOrOList[4] && _xOrOList[3] == _xOrOList[5] && _xOrOList[3] != '') {
      _showAlertDialog('Winner', _xOrOList[3]);
      return;
    }

    // check third row
    if (_xOrOList[6] == _xOrOList[7] && _xOrOList[6] == _xOrOList[8] && _xOrOList[6] != '') {
      _showAlertDialog('Winner', _xOrOList[6]);
      return;
    }

    // check first column
    if (_xOrOList[0] == _xOrOList[3] && _xOrOList[0] == _xOrOList[6] && _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check second column
    if (_xOrOList[1] == _xOrOList[4] && _xOrOList[1] == _xOrOList[7] && _xOrOList[1] != '') {
      _showAlertDialog('Winner', _xOrOList[1]);
      return;
    }

    // check third column
    if (_xOrOList[2] == _xOrOList[5] && _xOrOList[2] == _xOrOList[8] && _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }

    // check diagonal
    if (_xOrOList[0] == _xOrOList[4] && _xOrOList[0] == _xOrOList[8] && _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check diagonal
    if (_xOrOList[2] == _xOrOList[4] && _xOrOList[2] == _xOrOList[6] && _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }

    if (_filledBoxes == 9) {
      _showAlertDialog('Draw', '');
    }
  }

  void _showAlertDialog(String title, String winner) {
    showAlertDialog(
        context: context,
        title: title,
        content: winner == '' ? 'The match ended in a draw' : 'The winner is ${winner.toUpperCase()}',
        defaultActionText: 'OK',
        onOkPressed: () {
          _clearBoard();
          Navigator.of(context).pop();
        });

    if (winner == 'o') {
      _scoreO += 1;
    } else if (winner == 'x') {
      _scoreX += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        _xOrOList[i] = '';
      }
    });

    _filledBoxes = 0;
  }
}
