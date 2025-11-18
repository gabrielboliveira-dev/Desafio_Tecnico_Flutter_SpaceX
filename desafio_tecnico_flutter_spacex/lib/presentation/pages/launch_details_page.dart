import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/launch_entity.dart';
import '../providers/launch_provider.dart';

class LaunchDetailsPage extends StatelessWidget {
  final LaunchEntity launch;

  const LaunchDetailsPage({super.key, required this.launch});

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
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: countdown == 'Lançado!'
                      ? Colors.red
                      : Colors.blueAccent[700],
                ),
              ),
            ),

            const Divider(height: 30),

            if (launch.patchUrl != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CachedNetworkImage(
                    imageUrl: launch.patchUrl!,
                    width: 150,
                    height: 150,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                  ),
                ),
              ),

            _buildInfoRow(context, 'Data e Hora', launch.formattedDate),
            _buildInfoRow(context, 'Foguete', launch.rocketName),

            const SizedBox(height: 20),

            const Text(
              'Detalhes da Missão:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              launch.details ?? 'Nenhum detalhe disponível.',
              style: const TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
