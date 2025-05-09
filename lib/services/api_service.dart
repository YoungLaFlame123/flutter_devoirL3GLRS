import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/etudiant.dart';

class ApiService {
  static Future<List<Etudiant>> fetchEtudiants() async {
    final String apiUrl = 'http://localhost:3000/api/inscription';
    final uri = Uri.parse(apiUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Etudiant.fromJson(e)).toList();
    } else {
      throw Exception('Erreur lors du chargement des étudiants');
    }
  }
}
