import 'package:intl/intl.dart';

class LaunchEntity {
  final String id;
  final String name;
  final DateTime dateUtc;
  final String rocketId;
  final String? details;
  final String? patchUrl;

  LaunchEntity({
    required this.id,
    required this.name,
    required this.dateUtc,
    required this.rocketId,
    this.details,
    this.patchUrl,
  });

  String get formattedDate =>
      DateFormat('dd/MM/yyyy HH:mm').format(dateUtc.toLocal());

  String get rocketName => 'Foguete ID: $rocketId';
}
