import 'package:mysupercatapp/features/favorites/data/local/favorite_model.dart';

import '../../../../shared/data/app_database.dart';

class FavoriteDao {
  Future<List<FavoriteModel>> fetchAllFavorites() async {
    final db = await AppDatabase().openDb();
    List favorites = await db.query(AppDatabase().tableName);
    return favorites.map((map) => FavoriteModel.fromMap(map)).toList();
  }

  Future<void> insertFavorite(FavoriteModel favorite) async {
    final db = await AppDatabase().openDb();
    await db.insert(AppDatabase().tableName, favorite.toMap());
  }

  Future<void> deleteFavorite(String id) async {
    final db = await AppDatabase().openDb();
    await db.delete(AppDatabase().tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(String id) async {
    final db = await AppDatabase().openDb();
    List result = await db
        .query(AppDatabase().tableName, where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}