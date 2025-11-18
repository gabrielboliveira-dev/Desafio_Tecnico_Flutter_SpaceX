import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/launch_entity.dart';
import '../providers/launch_provider.dart';
import '../widgets/launch_card.dart';
import '../pages/launch_details_page.dart';

class LaunchesPage extends StatefulWidget {
  const LaunchesPage({Key? key}) : super(key: key);

  @override
  State<LaunchesPage> createState() => _LaunchesPageState();
}

class _LaunchesPageState extends State<LaunchesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LaunchProvider>().fetchLaunches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Próximos Lançamentos SpaceX')),
      body: Consumer<LaunchProvider>(
        builder: (context, provider, child) {
          if (provider.state == LaunchViewState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.state == LaunchViewState.error) {
            return Center(child: Text(provider.errorMessage));
          }
          if (provider.launches.isEmpty) {
            return const Center(child: Text('Nenhum lançamento futuro.'));
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchLaunches(),
            child: ListView.builder(
              itemCount: provider.launches.length,
              itemBuilder: (context, index) {
                final launch = provider.launches[index];
                return LaunchCard(
                  launch: launch,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LaunchDetailsPage(launch: launch),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class LaunchDetailsPage extends StatelessWidget {
  final LaunchEntity launch;
  const LaunchDetailsPage({Key? key, required this.launch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countdown = context.watch<LaunchProvider>().getCountdown(
      launch.dateUtc,
    );

    return Scaffold(
      appBar: AppBar(title: Text(launch.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                countdown,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const Divider(),

            Text(
              'Data de Lançamento:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(launch.formattedDate),
            const SizedBox(height: 10),

            Text('Foguete:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(launch.rocketName),
            const SizedBox(height: 10),

            Text(
              'Detalhes da Missão:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(launch.details ?? 'Nenhum detalhe disponível.'),
          ],
        ),
      ),
    );
  }
}
