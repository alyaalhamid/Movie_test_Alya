import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/Model/GetFavorit.dart';

/// [ApiFavoriteMovie] merupakan kode class untuk menarik data dari link api.
class ApiFavoriteMovie {
  final String apikey = '98c580af951d9cbf543ece8df822519c';

  Future<List<FavoriteMovie>?> getfavorite(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/account/$id/favorite/movies?api_key=$apikey'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OGM1ODBhZjk1MWQ5Y2JmNTQzZWNlOGRmODIyNTE5YyIsIm5iZiI6MTcyMzE3ODYwNy41OTEyMDEsInN1YiI6IjY2YjA5ZmI0NDM5Nzk0YmU2N2Y4MjJhNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7QBAwVKR0jzpxXBjWOA_zCLNHf9rUOUpmVdCXkWXOZU',
          'content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var getFavoritemovie = jsonData['results'] as List;
        var listFavoritemovie =
            getFavoritemovie.map((i) => FavoriteMovie.fromJson(i)).toList();
        return listFavoritemovie;
      } else {
        throw Exception('Failed to load Discover Movie');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
