class Wordle {
  String letter;
  bool existsInTarget;
  bool doesNotExistsInTarget;
  bool existsInSamePosition;

  Wordle({
    required this.letter,
    this.existsInTarget = false,
    this.doesNotExistsInTarget = false,
    this.existsInSamePosition = false,
  });
}
