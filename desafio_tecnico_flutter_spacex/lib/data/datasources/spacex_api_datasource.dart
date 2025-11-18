import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/launch_model.dart';

class SpaceXApiDataSource {
  final http.Client client;

  SpaceXApiDataSource({required this.client});

  Future<List<LaunchModel>> getUpcomingLaunches() async {
    final uri = Uri.parse('https://api.spacexdata.com/v4/launches/upcoming');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List rawList = json.decode(response.body);

      return rawList.map((e) => LaunchModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar lançamentos: ${response.statusCode}');
    }
  }
}
