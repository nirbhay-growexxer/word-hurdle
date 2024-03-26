import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle/helper_functions.dart';
import 'package:word_hurdle/hurdle_provider.dart';
import 'package:word_hurdle/keyboard_view.dart';
import 'package:word_hurdle/wordle_view.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});
  @override
  State<WordHurdlePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WordHurdlePage> {
  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Hurdle'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Consumer<HurdleProvider>(
                  builder: (context, provider, child) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4),
                    itemCount: provider.hurdleBoard.length,
                    itemBuilder: (context, index) {
                      final wordle = provider.hurdleBoard[index];
                      return WordleView(wordle: wordle);
                    },
                  ),
                ),
              ),
            ),
            Consumer<HurdleProvider>(
              builder: (context, provider, child) => KeyboardView(
                excludedLetters: provider.excludedLetters,
                onPressed: (value) {
                  print(value);
                  provider.inputLetter(value);
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<HurdleProvider>(
                  builder: (context, provider, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          provider.removeLetter();
                        },
                        child: const Text('Remove'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (provider.count == 5) {
                            provider.isValidWord
                                ? provider.submitWord()
                                : showMessage(context, 'Invalid word');
                            if (provider.wins) {
                              // show wining dialog
                              showResult(
                                context: context,
                                body:
                                    'You win the game. The word was - ${provider.targetWord}',
                                onPlayAgain: () {
                                  provider.playAgain();
                                },
                                onCancel: () {
                                  provider.cancelGame();
                                },
                              );
                            } else {
                              // start input for next row
                              if (provider.currentRow > 5) {
                                showResult(
                                  context: context,
                                  body:
                                      'You lose the game. The word was - ${provider.targetWord}',
                                  onPlayAgain: () {
                                    provider.playAgain();
                                  },
                                  onCancel: () {
                                    provider.cancelGame();
                                  },
                                );
                              }
                            }
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
