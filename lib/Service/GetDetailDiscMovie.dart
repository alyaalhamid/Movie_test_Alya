import 'dart:convert';

import 'package:test/Model/DetailMovie.dart';
import 'package:http/http.dart' as http;

class ApiDetailMovie {
  final String apikey = '98c580af951d9cbf543ece8df822519c';
  Future<detaildiscmovie?> getdetailmovie(int id) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=$apikey'),
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return detaildiscmovie.fromJson(jsonData);
      } else {
        throw Exception('Failed to load report details');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
