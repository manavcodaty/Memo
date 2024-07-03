import 'package:Memo/models/flash_card_info.dart';

class FlashCards {
  int? deckid;
  String title;
  List<FlashCardInfo>? flashcards;
  FlashCards({this.deckid, required this.title, this.flashcards});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }

  FlashCardInfo operator [](int index) => flashcards![index];

  FlashCards.from(FlashCards other)
      : title = other.title,
        flashcards = other.flashcards,
        deckid = other.deckid;

  @override
  bool operator ==(Object other) {
    return other is FlashCards &&
        other.title == title &&
        other.flashcards == flashcards &&
        other.deckid == deckid;
  }

  @override
  int get hashCode => title.hashCode ^ flashcards.hashCode ^ deckid.hashCode;
}
