import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/Model/Watchlist.dart';

class ApiPostwatchlist {
  final String apikey = '98c580af951d9cbf543ece8df822519c';
  Future<int?> postmywatchlist(int accid, PostWatchlist data) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://api.themoviedb.org/3/account/$accid/watchlist?api_key=$apikey'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OGM1ODBhZjk1MWQ5Y2JmNTQzZWNlOGRmODIyNTE5YyIsIm5iZiI6MTcyMzE3ODYwNy41OTEyMDEsInN1YiI6IjY2YjA5ZmI0NDM5Nzk0YmU2N2Y4MjJhNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7QBAwVKR0jzpxXBjWOA_zCLNHf9rUOUpmVdCXkWXOZU',
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: jsonEncode(data.toJson()),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
