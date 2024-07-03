import 'package:flutter/material.dart';
import 'package:Memo/models/flash_card_info.dart';
import 'package:Memo/models/flash_cards.dart';
import 'package:Memo/views/flash_card_quiz.dart';
import 'package:Memo/views/new_card_page.dart';

import 'cards_view_edit_page.dart';

class CardsViewListPage extends StatefulWidget {
  final FlashCards flashCards;

  const CardsViewListPage({super.key, required this.flashCards});

  @override
  State<CardsViewListPage> createState() => _CardsViewListPageState();
}

class _CardsViewListPageState extends State<CardsViewListPage> {
  late FlashCards data;
  bool isSorted = false;
  List<FlashCardInfo> sortedFlashCards = [];

  @override
  void initState() {
    super.initState();
    data = widget.flashCards;
    for (FlashCardInfo f in data.flashcards!) {
      sortedFlashCards.add(f);
    }
  }

  @override
  Widget build(BuildContext context) {
    //method to sort the cards alphabetically
    void toggleSort() {
      setState(() {
        isSorted = !isSorted;
        if (isSorted) {
          sortedFlashCards.sort((a, b) => a.question.compareTo(b.question));
        } else {
          sortedFlashCards.clear();
        }
      });
    }

    List<FlashCardInfo> displayFlashCard =
        isSorted ? sortedFlashCards : data.flashcards!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("${data.title}   "),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(isSorted ? Icons.schedule : Icons.sort_by_alpha),
              onPressed: toggleSort,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlashCardQuiz(
                          cards: displayFlashCard,
                          deck: widget.flashCards)), //navigates to quiz page
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
              ),
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _newCard(context, displayFlashCard, data);
          },
          child: const Icon(Icons.add),
        ),
        body: cardsLayout(displayFlashCard));
  }

  //Below method lays out the cards on the screen which is reponsive to screen size changes
  CustomScrollView cardsLayout(List<FlashCardInfo> displayFlashCard) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                  color: Colors.blue[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                      alignment: Alignment.center,
                      child: Stack(children: [
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: displayFlashCard[index].question,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 13),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _editFlashCard(context, index, displayFlashCard);
                          },
                        )
                      ])));
            },
            childCount:
                displayFlashCard.length, // Number of cards or items to display
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, // Maximum width for each card
          ),
        ),
      ],
    );
  }

  // Below future logic edits or deletes the flash card details
  Future<void> _editFlashCard(BuildContext context, int index,
      List<FlashCardInfo> displayFlashCard) async {
    int length = displayFlashCard.length;
    var result = await Navigator.of(context).push(
      MaterialPageRoute<FlashCardInfo>(builder: (context) {
        //navigates to edit page to update or delete the card
        return CardsViewEditPage(displayFlashCard[index],
            flashCardsInfo: displayFlashCard);
      }),
    );

    if (!mounted) return;

    if (result != null &&
        displayFlashCard.length == length &&
        result != displayFlashCard[index]) {
      setState(() {
        displayFlashCard[index] = result;
      });
    }

    if (result != null && displayFlashCard.length < length) {
      setState(() {
        length = 0;
      });
    }
  }

  //Below future logic adds a new card to the deck
  Future<void> _newCard(BuildContext context,
      List<FlashCardInfo> displayFlashCard, FlashCards deck) async {
    int length = displayFlashCard.length;
    var result = await Navigator.of(context).push(
      MaterialPageRoute<FlashCardInfo>(builder: (context) {
        return NewCardPage(
          flashCardsInfo: displayFlashCard,
          deck: deck,
        );
      }),
    );

    if (!mounted) return;

    if (result != null && displayFlashCard.length > length) {
      setState(() {
        length = 0;
      });
    }
  }
}
