import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../services/favorite_service.dart';
import '../services/api_service.dart';
import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoriteService _favoriteService = FavoriteService();
  final ApiService _apiService = ApiService();

  Widget _buildFavoriteItem(Restaurant restaurant) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            _apiService.getImageUrl(restaurant.pictureId),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(restaurant.name),
        subtitle: Text('${restaurant.city} • Rating: ${restaurant.rating}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(restaurantId: restaurant.id),
            ),
          ).then((_) {
            // Refresh the list when returning from detail page
            setState(() {});
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favorites = _favoriteService.getFavorites();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Page'),
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return _buildFavoriteItem(favorites[index]);
              },
            ),
    );
  }
}
