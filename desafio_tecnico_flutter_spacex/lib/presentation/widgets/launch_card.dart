import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/launch_entity.dart';
import '../providers/launch_provider.dart';

class LaunchCard extends StatelessWidget {
  final LaunchEntity launch;
  final VoidCallback onTap;

  const LaunchCard({Key? key, required this.launch, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countdown = context.watch<LaunchProvider>().getCountdown(
      launch.dateUtc,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                launch.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(),

              Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: launch.patchUrl != null
                        ? CachedNetworkImage(imageUrl: launch.patchUrl!)
                        : const Icon(Icons.rocket_launch, size: 40),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lançamento: ${launch.formattedDate}',
                          style: const TextStyle(fontSize: 14),
                        ),

                        Text(
                          countdown,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: countdown == 'Lançado!'
                                ? Colors.red
                                : Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
