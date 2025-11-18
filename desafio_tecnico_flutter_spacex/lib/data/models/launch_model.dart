import '../../domain/entities/launch_entity.dart';

class LaunchModel extends LaunchEntity {
  LaunchModel({
    required String id,
    required String name,
    required DateTime dateUtc,
    required String rocketId,
    String? details,
    String? patchUrl,
  }) : super(
         id: id,
         name: name,
         dateUtc: dateUtc,
         rocketId: rocketId,
         details: details,
         patchUrl: patchUrl,
       );

  factory LaunchModel.fromJson(Map<String, dynamic> json) {
    final links = json['links'] ?? {};
    final patch = links['patch'] ?? {};
    final int unixTimestamp = json['date_unix'] as int;

    return LaunchModel(
      id: json['id'],
      name: json['name'],
      dateUtc: DateTime.fromMillisecondsSinceEpoch(
        unixTimestamp * 1000,
        isUtc: true,
      ),

      rocketId: json['rocket'] ?? 'Desconhecido',
      details: json['details'],
      patchUrl: patch['small'],
    );
  }
}
