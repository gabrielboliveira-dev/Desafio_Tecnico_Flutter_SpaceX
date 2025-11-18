import '../entities/launch_entity.dart';

abstract class SpaceXRepository {
  Future<List<LaunchEntity>> getUpcomingLaunches();
}
