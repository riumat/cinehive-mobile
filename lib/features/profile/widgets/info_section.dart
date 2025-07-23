import 'package:cinehive_mobile/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class UserInfoSection extends StatelessWidget {
  final UserProfileResponse userProfile;

  const UserInfoSection({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 37,
          backgroundColor: Colors.white,
          child: Text(
            userProfile.profile.username.isNotEmpty
                ? userProfile.profile.username[0].toUpperCase()
                : 'U',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '@${userProfile.profile.username}',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}