import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/restaurant_detail.dart';
import '../services/api_service.dart';
import '../services/favorite_service.dart';

class DetailPage extends StatefulWidget {
  final String restaurantId;

  const DetailPage({
    super.key,
    required this.restaurantId,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ApiService _apiService = ApiService();
  final FavoriteService _favoriteService = FavoriteService();
  bool isLoading = true;
  String? error;
  RestaurantDetail? restaurant;

  @override
  void initState() {
    super.initState();
    _fetchRestaurantDetail();
  }

  bool get isFavorite =>
      restaurant != null && _favoriteService.isFavorite(restaurant!.id);

  void _toggleFavorite() async {
    if (restaurant == null) return;

    if (isFavorite) {
      await _favoriteService.removeFromFavorites(restaurant!.id);
    } else {
      await _favoriteService.addToFavorites(Restaurant(
        id: restaurant!.id,
        name: restaurant!.name,
        description: restaurant!.description,
        pictureId: restaurant!.pictureId,
        city: restaurant!.city,
        rating: restaurant!.rating,
      ));
    }

    setState(() {});

    final snackBar = SnackBar(
      content: Text(
        isFavorite
            ? 'Berhasil menambahkan ke favorite'
            : 'Berhasil menghapus dari favorite',
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: isFavorite ? Colors.green : Colors.red,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _fetchRestaurantDetail() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final restaurantDetail =
          await _apiService.getRestaurantDetail(widget.restaurantId);

      setState(() {
        restaurant = restaurantDetail;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Image.network(
          _apiService.getImageUrl(restaurant!.pictureId),
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Restaurants Detail'),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant!.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            restaurant!.city,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  restaurant!.address,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                restaurant!.rating.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            restaurant!.description,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(error!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchRestaurantDetail,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      _buildRestaurantInfo(),
                    ],
                  ),
                ),
    );
  }
}
