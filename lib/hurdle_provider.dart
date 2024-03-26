import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:english_words/english_words.dart' as words;
import 'package:word_hurdle/wordle.dart';

class HurdleProvider extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> hurdleBoard = [];
  String targetWord = '';
  int index = 0;
  int count = 0;
  final int lettersPerRow = 5;
  bool wins = false;
  int currentRow = 0;

  init() {
    totalWords = words.all.where((element) => element.length == 5).toList();
    generateHurdleBoard();
    generateRandomWord();
  }

  generateHurdleBoard() {
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ''));
  }

  generateRandomWord() {
    targetWord = totalWords[random.nextInt(totalWords.length)].toLowerCase();
    // print('targetWord: $targetWord');
  }

  inputLetter(String letter) {
    if (count < lettersPerRow) {
      count++;
      rowInputs.add(letter);
      hurdleBoard[index] = Wordle(letter: letter);
      index++;
    }
    // print('rowInputs: $rowInputs');
    notifyListeners();
  }

  removeLetter() {
    if (count > 0) {
      count--;
      rowInputs.removeLast();
      index--;
      hurdleBoard[index] = Wordle(letter: '');
      notifyListeners();
    }
  }

  bool get isValidWord => totalWords.contains(rowInputs.join().toLowerCase());

  submitWord() {
    if (count == 5) {
      final word = rowInputs.join();
      if (word.toLowerCase() == targetWord) {
        wins = true;
        // print('Correct');
        _markLetterOnBoard();
      } else {
        // mark the letters on the board
        _markLetterOnBoard();
        // print('Incorrect');
        // print(hurdleBoard[currentRow * 5 + 0]);
        if (currentRow < 6) {
          count = 0;
          rowInputs.clear();
        }
      }
      currentRow++;
      // print('currentRow- $currentRow');
      notifyListeners();
    }
  }

  playAgain() {
    rowInputs.clear();
    excludedLetters.clear();
    hurdleBoard.clear();
    wins = false;
    count = 0;
    index = 0;
    currentRow = 0;
    generateRandomWord();
    generateHurdleBoard();
    notifyListeners();
  }

  cancelGame() {
    rowInputs.clear();
    excludedLetters.clear();
    count = 0;
    index = 0;
    notifyListeners();
  }

  _markLetterOnBoard() {
    for (int i = 0; i < 5; i++) {
      if (targetWord
          .contains(hurdleBoard[currentRow * 5 + i].letter.toLowerCase())) {
        hurdleBoard[currentRow * 5 + i].existsInTarget = true;
        if (targetWord[i] ==
            hurdleBoard[currentRow * 5 + i].letter.toLowerCase()) {
          hurdleBoard[currentRow * 5 + i].existsInSamePosition = true;
        }
      } else {
        hurdleBoard[currentRow * 5 + i].doesNotExistsInTarget = true;
        excludedLetters.add(hurdleBoard[currentRow * 5 + i].letter);
      }
    }
  }
}
