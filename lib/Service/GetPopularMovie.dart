import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/Model/Popular.dart';

/// [ApiPopularMovie] merupakan kode class untuk menarik data dari link api.
class ApiPopularMovie {
  final String apikey = '98c580af951d9cbf543ece8df822519c';

  Future<List<PopularMovie>?> getPopular() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apikey'),
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var getpopularmovie = jsonData['results'] as List;
        var listpopularmovie =
            getpopularmovie.map((i) => PopularMovie.fromJson(i)).toList();
        return listpopularmovie;
      } else {
        throw Exception('Failed to load Discover Movie');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
