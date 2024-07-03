import 'package:Memo/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Memo/models/flash_card_info.dart';
import 'package:Memo/models/flash_cards.dart';
import 'package:Memo/utils/db_helper.dart';
import 'package:Memo/views/cards_list.dart';
import 'dart:convert';

import 'package:provider/provider.dart';
import 'deck_editor.dart';
import 'new_deck_page.dart';

class DeckList extends StatelessWidget {
  const DeckList({super.key});
  

  //loads the data from json and persists to DB
  Future<List<FlashCards>> _loadData() async {
    final data = await rootBundle.loadString('assets/flashcards.json');
    final flashCardsFromJson = json.decode(data);

    for (var deckData in flashCardsFromJson) {
      final deck = FlashCards(title: deckData['title']);
      final deckID = await DBHelper().insertDeck(deck);

      for (var cardData in deckData['flashcards']) {
        final card = FlashCardInfo(
            question: cardData['question'],
            answer: cardData['answer'],
            deckid: deckID);

        await DBHelper().insertCard(card);
      }
    }

    return await flashCardsData();
  }

  Future<List<FlashCards>> flashCardsData() async {
    final decks = <FlashCards>[];
    final List<Map<String, dynamic>> deckRecords =
        await DBHelper().query('decks');

    for (var deckRecord in deckRecords) {
      final deck = FlashCards(
        deckid: deckRecord['deckid'],
        title: deckRecord['title'],
      );

      final List<Map<String, dynamic>> cardRecords = await DBHelper()
          .query('cards', where: 'deckid=${deck.deckid.toString()}');

      deck.flashcards = cardRecords
          .map((cardRecord) => FlashCardInfo(
              cardid: cardRecord['cardid'],
              question: cardRecord['question'],
              answer: cardRecord['answer'],
              deckid: cardRecord['deckid']))
          .toList();

      decks.add(deck);
    }

    return decks;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureProvider<List<FlashCards>?>(
          create: (_) => _loadData(),
          initialData: const [],
          child: const DeckListViewPage()),
    );
  }
}

class DeckListViewPage extends StatefulWidget {
  const DeckListViewPage({super.key});

  @override
  State<DeckListViewPage> createState() => _DeckListViewPageState();
}

class _DeckListViewPageState extends State<DeckListViewPage> {
  late List<FlashCards> decks;
  @override
  void initState() {
    super.initState();
  }

  Future<List<FlashCards>> _loadData() async {
    final data = await rootBundle.loadString('assets/flashcards.json');
    final flashCardsFromJson = json.decode(data);

    for (var deckData in flashCardsFromJson) {
      final deck = FlashCards(title: deckData['title']);
      final deckID = await DBHelper().insertDeck(deck);

      for (var cardData in deckData['flashcards']) {
        final card = FlashCardInfo(
            question: cardData['question'],
            answer: cardData['answer'],
            deckid: deckID);

        await DBHelper().insertCard(card);
      }
    }
    

    return await flashCardsData();
  }

  Future<List<FlashCards>> flashCardsData() async {
    final decks = <FlashCards>[];
    final List<Map<String, dynamic>> deckRecords =
        await DBHelper().query('decks');

    for (var deckRecord in deckRecords) {
      final deck = FlashCards(
        deckid: deckRecord['deckid'],
        title: deckRecord['title'],
      );

      final List<Map<String, dynamic>> cardRecords = await DBHelper()
          .query('cards', where: 'deckid=${deck.deckid.toString()}');

      deck.flashcards = cardRecords
          .map((cardRecord) => FlashCardInfo(
              cardid: cardRecord['cardid'],
              question: cardRecord['question'],
              answer: cardRecord['answer'],
              deckid: cardRecord['deckid']))
          .toList();

      decks.add(deck);
    }

    return decks;
  }

  @override
  Widget build(BuildContext context) {
    final flashCards = Provider.of<List<FlashCards>?>(context);
    if (flashCards == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Text(
                'Memo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
             ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text('Learn'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeckList()),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.check_box),
              title: Text('To Do'),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar'),
            ),
            const ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Statistics'),
            ),
            const ListTile(
              leading: Icon(Icons.auto_awesome),
              title: Text('Memo Ai'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
        appBar: AppBar(
          title: const Text('Flashcard Decks'),
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: () async {
                List<FlashCards>? newFlashCards = await _loadData();
                List<FlashCards>? fc = List.from(newFlashCards);
                flashCards.clear();
                for (FlashCards f in fc) {
                  flashCards.add(f);
                }
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
              ),
              child: const Icon(Icons.download),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addNewDeck(context, flashCards);
          },
          child: const Icon(Icons.add),
        ),
        body: decksLayout(flashCards),
      );
    }
  }
  // TODO: Here is auto-response code

  //Below method lays out the decks on the screen which is reponsive to screen size changes
  CustomScrollView decksLayout(List<FlashCards> flashCards) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                  color: const Color.fromARGB(255, 250, 213, 226),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardsViewListPage(
                                  flashCards: flashCards[index]),
                            ),
                          ).then((result) {
                            setState(() {});
                          });
                        },
                      ),
                      flashcardDetailsDisplay(flashCards, index),
                      editDeckButton(context, index, flashCards),
                    ],
                  ));
            },
            childCount: flashCards.length,
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
          ),
        ),
      ],
    );
  }

  //Method to display the deck title and the count of cards in the deck
  Center flashcardDetailsDisplay(List<FlashCards> flashCards, int index) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: "${flashCards[index].title}\n",
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
            TextSpan(
              text: flashCards[index].flashcards == null
                  ? '(0 Cards)'
                  : "(${flashCards[index].flashcards!.length} Cards)",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to edit the deck details or delete the deck on press
  Positioned editDeckButton(
      BuildContext context, int index, List<FlashCards> flashCards) {
    return Positioned(
      right: 0,
      child: IconButton(
        icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
        onPressed: () {
          _editDeck(context, index, flashCards);
        },
      ),
    );
  }

  //Below future logic edits the deck or deletes the deck details
  Future<void> _editDeck(
      BuildContext context, int index, List<FlashCards> decks) async {
    int length = decks.length;

    var result = await Navigator.of(context).push(
      MaterialPageRoute<FlashCards>(builder: (context) {
        return DeckEditor(decks[index],
            flashCards:
                decks); //navigates to deck editor page to update or delete deck
      }),
    );

    if (!mounted) return;

    if (result != null && decks.length == length && result != decks[index]) {
      setState(() {
        decks[index] = result;
      });
    }

    if (result != null && decks.length < length) {
      setState(() {
        length = 0;
      });
    }
  }

  //Below future logic adds the new deck to the deck page on press of floating action button
  Future<void> _addNewDeck(BuildContext context, List<FlashCards> decks) async {
    int length = decks.length;
    var result = await Navigator.of(context).push(
      MaterialPageRoute<FlashCards>(builder: (context) {
        return NewDeckPage(
            flashCards: decks); // navigates to page to add new flash card deck
      }),
    );

    if (!mounted) return;

    if (result != null && decks.length > length) {
      setState(() {
        length = 0;
      });
    }
  }
}
