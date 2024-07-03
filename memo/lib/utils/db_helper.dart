import 'package:Memo/models/flash_card_info.dart';
import 'package:Memo/models/flash_cards.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const String _databaseName = 'flashcard.db';
  static const int _databaseVersion = 1;

  DBHelper._();
  static final DBHelper _singleton = DBHelper._();
  factory DBHelper() => _singleton;

  Database? _database;

  get db async {
    _database ??= await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    var dbDir = await getApplicationDocumentsDirectory();

    var dbPath = path.join(dbDir.path, _databaseName);
    await deleteDatabase(dbPath); //deletes the database on application start

    var db = await openDatabase(dbPath, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE decks(
            deckid INTEGER PRIMARY KEY,
            title TEXT
          )
        ''');
      await db.execute('''
          CREATE TABLE cards(
            cardid INTEGER PRIMARY KEY,
            question TEXT,
            answer TEXT,
            deckid INTEGER,
            FOREIGN KEY (deckid) REFERENCES decks(deckid)
          )
        ''');
    });

    return db;
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {String? where}) async {
    final db = await this.db;
    return where == null ? db.query(table) : db.query(table, where: where);
  }

  //inserts data to decks table
  Future<int> insertDeck(FlashCards deck) async {
    final db = await this.db;
    int id = await db.insert('decks', deck.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //inserts data to cards table
  Future<int> insertCard(FlashCardInfo card) async {
    final db = await this.db;
    int id = await db.insert('cards', card.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // update a record in cards table
  Future<void> update(String table, FlashCardInfo data) async {
    final db = await this.db;
    await db.update(
      table,
      data.toMap(),
      where: 'cardid = ?',
      whereArgs: [data.cardid],
    );
  }

  // update a record in decks table
  Future<void> updateDeck(String table, FlashCards data) async {
    final db = await this.db;
    await db.update(
      table,
      data.toMap(),
      where: 'deckid = ?',
      whereArgs: [data.deckid],
    );
  }

  // delete a record from cards table
  Future<void> delete(String table, int id) async {
    final db = await this.db;
    await db.delete(
      table,
      where: 'cardid = ?',
      whereArgs: [id],
    );
  }

  // delete a record from decks and the records associated to the deleted deck id from the cards table
  Future<void> deleteDeck(String table, int id) async {
    final db = await this.db;
    await db.delete(
      table,
      where: 'deckid = ?',
      whereArgs: [id],
    );
    await db.delete(
      'cards',
      where: 'deckid = ?',
      whereArgs: [id],
    );
  }
}
