import 'package:flutter/material.dart';
import 'package:Memo/models/flash_cards.dart';
import 'package:Memo/utils/db_helper.dart';

class NewDeckPage extends StatefulWidget {
  final List<FlashCards> flashCards;

  const NewDeckPage({required this.flashCards, super.key});

  @override
  State<NewDeckPage> createState() => _NewDeckPageStatePage();
}

class _NewDeckPageStatePage extends State<NewDeckPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController deckNameController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('New Deck'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: deckNameController,
                decoration: const InputDecoration(labelText: 'Deck Name'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('Save'),
                    onPressed: () async {
                      String deckName = deckNameController.text;
                      FlashCards newDeck = FlashCards(
                        title: deckName,
                      );
                      final deckID = await DBHelper().insertDeck(newDeck);
                      newDeck.deckid = deckID;
                      newDeck.flashcards = [];
                      widget.flashCards.add(newDeck);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop(newDeck);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
