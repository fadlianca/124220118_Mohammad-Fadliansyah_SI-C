import 'package:hive_flutter/hive_flutter.dart';
import '../models/restaurant.dart';

class FavoriteService {
  static const String boxName = 'favorites';

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RestaurantAdapter());
    await Hive.openBox<Restaurant>(boxName);
  }

  Box<Restaurant> _getFavoriteBox() {
    return Hive.box<Restaurant>(boxName);
  }

  Future<void> addToFavorites(Restaurant restaurant) async {
    final box = _getFavoriteBox();
    await box.put(restaurant.id, restaurant);
  }

  Future<void> removeFromFavorites(String restaurantId) async {
    final box = _getFavoriteBox();
    await box.delete(restaurantId);
  }

  List<Restaurant> getFavorites() {
    final box = _getFavoriteBox();
    return box.values.toList();
  }

  bool isFavorite(String restaurantId) {
    final box = _getFavoriteBox();
    return box.containsKey(restaurantId);
  }
}
