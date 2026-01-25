import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteDatabase {
  static final FavoriteDatabase instance = FavoriteDatabase._init();
  static Database? _database;

  FavoriteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        product_id INTEGER NOT NULL,
        synced INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        UNIQUE(user_id, product_id)
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_user_id ON favorites(user_id)
    ''');
  }

  // Add favorite locally
  Future<int> addFavorite(String userId, int productId) async {
    final db = await database;

    return await db.insert('favorites', {
      'user_id': userId,
      'product_id': productId,
      'synced': 0,
      'created_at': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Remove favorite locally
  Future<int> removeFavorite(String userId, int productId) async {
    final db = await database;

    return await db.delete(
      'favorites',
      where: 'user_id = ? AND product_id = ?',
      whereArgs: [userId, productId],
    );
  }

  // Get all favorites for a user
  Future<Set<int>> getFavorites(String userId) async {
    final db = await database;

    final result = await db.query(
      'favorites',
      columns: ['product_id'],
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return result.map((row) => row['product_id'] as int).toSet();
  }

  // Check if product is favorited
  Future<bool> isFavorite(String userId, int productId) async {
    final db = await database;

    final result = await db.query(
      'favorites',
      where: 'user_id = ? AND product_id = ?',
      whereArgs: [userId, productId],
    );

    return result.isNotEmpty;
  }

  // Mark favorites as synced
  Future<void> markAsSynced(String userId, List<int> productIds) async {
    final db = await database;

    await db.update(
      'favorites',
      {'synced': 1},
      where: 'user_id = ? AND product_id IN (${productIds.join(',')})',
      whereArgs: [userId],
    );
  }

  // Get unsynced favorites
  Future<List<int>> getUnsyncedFavorites(String userId) async {
    final db = await database;

    final result = await db.query(
      'favorites',
      columns: ['product_id'],
      where: 'user_id = ? AND synced = 0',
      whereArgs: [userId],
    );

    return result.map((row) => row['product_id'] as int).toList();
  }

  // Sync favorites from server (replace local data)
  Future<void> syncFromServer(String userId, List<int> serverFavorites) async {
    final db = await database;

    // Start transaction
    await db.transaction((txn) async {
      // Clear existing favorites for this user
      await txn.delete('favorites', where: 'user_id = ?', whereArgs: [userId]);

      // Insert server favorites
      for (final productId in serverFavorites) {
        await txn.insert('favorites', {
          'user_id': userId,
          'product_id': productId,
          'synced': 1,
          'created_at': DateTime.now().toIso8601String(),
        });
      }
    });
  }

  // Clear all favorites for a user
  Future<void> clearUserFavorites(String userId) async {
    final db = await database;
    await db.delete('favorites', where: 'user_id = ?', whereArgs: [userId]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
