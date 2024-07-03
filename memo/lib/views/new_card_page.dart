import 'package:flutter/material.dart';
import 'package:Memo/models/flash_card_info.dart';
import 'package:Memo/models/flash_cards.dart';
import 'package:Memo/utils/db_helper.dart';

class NewCardPage extends StatefulWidget {
  final FlashCards deck;
  final List<FlashCardInfo> flashCardsInfo;

  const NewCardPage({
    super.key,
    required this.flashCardsInfo,
    required this.deck,
  });

  @override
  State<NewCardPage> createState() => _NewCardPageState();
}

class _NewCardPageState extends State<NewCardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController cardQuestionController =
        TextEditingController();
    final TextEditingController cardAnswerController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Edit Card'), centerTitle: true),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: cardQuestionController,
                decoration: const InputDecoration(labelText: 'Question'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: cardAnswerController,
                decoration: const InputDecoration(labelText: 'Answer'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('Save'),
                  onPressed: () async {
                    String cardQuestion = cardQuestionController.text;
                    String cardAnswer = cardAnswerController.text;
                    FlashCardInfo newCard = FlashCardInfo(
                        question: cardQuestion,
                        answer: cardAnswer,
                        deckid: widget.deck.deckid!);
                    final cardID = await DBHelper().insertCard(newCard);
                    newCard.cardid = cardID;
                    widget.flashCardsInfo.add(newCard);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop(newCard);
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
