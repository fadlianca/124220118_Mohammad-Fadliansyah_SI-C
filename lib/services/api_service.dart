import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';
import '../models/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<List<Restaurant>> getRestaurants() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/list'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> restaurantList = data['restaurants'];
        return restaurantList.map((json) => Restaurant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<Restaurant> getRestaurantList(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Restaurant.fromJson(data['restaurant']);
      } else {
        throw Exception('Failed to load restaurant detail');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  String getImageUrl(String pictureId) {
    return '$_baseUrl/images/small/$pictureId';
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return RestaurantDetail.fromJson(data['restaurant']);
      } else {
        throw Exception('Failed to load restaurant detail');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
