import 'package:flutter/material.dart';
import 'package:Memo/models/flash_cards.dart';
import 'package:Memo/utils/db_helper.dart';

class DeckEditor extends StatefulWidget {
  final FlashCards flashCard;
  final List<FlashCards> flashCards;

  const DeckEditor(this.flashCard, {super.key, required this.flashCards});

  @override
  State<DeckEditor> createState() => _DeckEditorPage();
}

class _DeckEditorPage extends State<DeckEditor> {
  late FlashCards editedFlashCardDeck;

  @override
  void initState() {
    super.initState();
    editedFlashCardDeck = FlashCards.from(widget.flashCard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Edit Card'), centerTitle: true),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                  initialValue: editedFlashCardDeck.title,
                  decoration: const InputDecoration(labelText: 'Deck Name'),
                  onChanged: (value) => {
                        setState(() {
                          editedFlashCardDeck.title = value;
                        })
                      }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('Save'),
                  onPressed: () async {
                    await DBHelper().updateDeck('decks', editedFlashCardDeck);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop(editedFlashCardDeck);
                  },
                ),
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () async {
                    await DBHelper()
                        .deleteDeck('decks', editedFlashCardDeck.deckid!);
                    widget.flashCards.remove(editedFlashCardDeck);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop(editedFlashCardDeck);
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
