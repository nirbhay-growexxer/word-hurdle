import 'package:flutter/material.dart';
import 'package:word_hurdle/wordle.dart';

class WordleView extends StatelessWidget {
  final Wordle wordle;
  const WordleView({super.key, required this.wordle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        // color: wordle.existsInTarget
        //     ? Colors.green
        //     : wordle.doesNotExistsInTarget
        //         ? Colors.grey
        //         : null,
        color: wordle.existsInSamePosition
            ? Colors.green
            : wordle.existsInTarget
                ? Colors.yellow
                : null,
        border: Border.all(
          color: Colors.amber,
          width: 1.5,
        ),
      ),
      child: Text(
        wordle.letter,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
