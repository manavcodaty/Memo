import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Memo/models/flash_card_info.dart';
import 'package:Memo/models/flash_cards.dart';

class FlashCardQuiz extends StatefulWidget {
  final FlashCards deck;
  final List<FlashCardInfo> cards;
  const FlashCardQuiz({super.key, required this.cards, required this.deck});

  @override
  State<FlashCardQuiz> createState() => _FlashCardQuizState();
}

class _FlashCardQuizState extends State<FlashCardQuiz> {
  PageController pageController = PageController();
  late List<FlashCardInfo> shuffledCards;
  int flippedCardCount = 0;
  int seenCardCount = 1;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {});
    });
    shuffledCards = widget.cards;
    shuffleFlashCards(shuffledCards);
  }

  void toggleAnswer() {
    setState(() {
      final currentPage = pageController.page?.round() ?? 0;
      final card = shuffledCards[currentPage];

      card.showAnswer = !card.showAnswer;
      if (card.showAnswer) {
        flippedCardCount++;
      }
    });
  }

  void shuffleFlashCards(List<FlashCardInfo> cards) {
    final random = Random();
    for (int i = cards.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = cards[i];
      cards[i] = cards[j];
      cards[j] = temp;
    }
  }

  void goToNextCard() {
    if (seenCardCount < shuffledCards.length) seenCardCount++;
    pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void goToPreviousCard() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
          AppBar(title: Text('${widget.deck.title} Quiz'), centerTitle: true),
      body: Column(children: [
        Expanded(
            child: PageView.builder(
          controller: pageController,
          itemCount: shuffledCards.length,
          itemBuilder: (context, index) {
            final card = shuffledCards[index];

            return card.showAnswer
                ? Card(
                    margin: const EdgeInsets.all(25.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.green[100],
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: Text(
                          card.answer,
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : Card(
                    margin: const EdgeInsets.all(25.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.amber[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          card.question,
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
          },
        )),
        Padding(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: goToPreviousCard,
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.flip_to_front),
                  onPressed: toggleAnswer,
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: goToNextCard,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Seen $seenCardCount of ${shuffledCards.length} cards',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Text(
            'Peeked at $flippedCardCount of $seenCardCount answers',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ]),
    );
  }
}
