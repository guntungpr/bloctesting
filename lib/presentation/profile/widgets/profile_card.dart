import 'package:bloctesting/infrastructure/profile/models/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.detail});
  final ProfileDetail detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(detail.picture),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 20),
            Text('${detail.firstName} ${detail.lastName}'),
            Text(
              detail.id,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
