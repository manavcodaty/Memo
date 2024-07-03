class FlashCardInfo {
  int? cardid;
  final int deckid;
  String question;
  String answer;
  bool showAnswer;
  FlashCardInfo(
      {this.cardid,
      required this.question,
      required this.answer,
      required this.deckid,
      this.showAnswer = false});

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'deckid': deckid,
    };
  }

  FlashCardInfo.from(FlashCardInfo other)
      : question = other.question,
        answer = other.answer,
        cardid = other.cardid,
        deckid = other.deckid,
        showAnswer = other.showAnswer;

  @override
  bool operator ==(Object other) {
    return other is FlashCardInfo &&
        other.question == question &&
        other.answer == answer &&
        other.cardid == cardid &&
        other.deckid == deckid;
  }

  @override
  int get hashCode =>
      question.hashCode ^ answer.hashCode ^ cardid.hashCode ^ deckid.hashCode;
}
