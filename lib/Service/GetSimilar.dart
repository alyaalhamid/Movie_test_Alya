import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/Model/Similar.dart';

/// [ApiSimilarMovie] merupakan kode class untuk menarik data dari link api.
class ApiSimilarMovie {
  final String apikey = '98c580af951d9cbf543ece8df822519c';

  Future<List<SimilarMovie>?> getSimilar(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/$id/similar?api_key=$apikey'),
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var getsimilarmovie = jsonData['results'] as List;
        var listsimilarmovie =
            getsimilarmovie.map((i) => SimilarMovie.fromJson(i)).toList();
        return listsimilarmovie;
      } else {
        throw Exception('Failed to load Discover Movie');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
