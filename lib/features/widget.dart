import 'package:flutter/material.dart';
import '../constants/Padding.dart';
import '../constants/color.dart';
import '../constants/text.dart';

class PlayerScoreBoard extends StatelessWidget {
  const PlayerScoreBoard({
    super.key,
    required this.space,
    required this.player,
    required this.score,
  });

  final SizedBox space;
  final score;
  final String player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingUtility().scoreBoardOPadding,
      child: Column(
        children: [
          Text(
            player,
            style: customTextStyle(
              fontsize: 22.0,
              color: ColorUtility().white,
              fontWeight: FontWeight.w800,
            ),
          ),
          space,
          Text(
            score.toString(),
            style: customTextStyle(
              color: ColorUtility().white,
              fontsize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
