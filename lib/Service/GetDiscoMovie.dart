import 'dart:convert';
import 'package:test/Model/DiscoverMovie.dart';
import 'package:http/http.dart' as http;

/// [ApiDiscoMovie] merupakan kode class untuk menarik data dari link api.
class ApiDiscoMovie {
  final String apikey = '98c580af951d9cbf543ece8df822519c';
  Future<List<DiscovMovie>?> getNowPlay() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey'),
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var getnowplaymovie = jsonData['results'] as List;
        var listnowplaymovie =
            getnowplaymovie.map((i) => DiscovMovie.fromJson(i)).toList();
        return listnowplaymovie;
      } else {
        throw Exception('Failed to load Discover Movie');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
