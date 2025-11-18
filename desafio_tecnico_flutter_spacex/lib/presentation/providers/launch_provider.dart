import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/entities/launch_entity.dart';
import '../../domain/repositories/spacex_repository.dart';

enum LaunchViewState { initial, loading, success, error }

class LaunchProvider extends ChangeNotifier {
  final SpaceXRepository repository;

  LaunchProvider({required this.repository});

  LaunchViewState _state = LaunchViewState.initial;
  List<LaunchEntity> _launches = [];
  String _errorMessage = '';
  Timer? _timer;

  LaunchViewState get state => _state;
  List<LaunchEntity> get launches => _launches;
  String get errorMessage => _errorMessage;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchLaunches() async {
    _state = LaunchViewState.loading;
    notifyListeners();

    try {
      _launches = await repository.getUpcomingLaunches();
      _state = LaunchViewState.success;
      _startCountdown();
    } catch (e) {
      _state = LaunchViewState.error;
      _errorMessage = 'Erro: $e';
    }
    notifyListeners();
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      notifyListeners();
      if (_launches.isEmpty ||
          _launches.every((l) => l.dateUtc.isBefore(DateTime.now()))) {
        _timer?.cancel();
      }
    });
  }

  String getCountdown(DateTime launchTime) {
    final now = DateTime.now().toUtc();
    final duration = launchTime.toUtc().difference(now);
    if (duration.isNegative) {
      return 'Lançado!';
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String days = duration.inDays.toString();
    String hours = twoDigits(duration.inHours.remainder(24));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    return '${days}d ${hours}h ${minutes}m ${seconds}s';
  }
}
