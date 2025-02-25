import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class ProfileTab extends StatelessWidget {
  final User user;
  const ProfileTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: user.photoURL != null
                ? NetworkImage(user.photoURL!)
                : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => AuthService().signOut(),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}