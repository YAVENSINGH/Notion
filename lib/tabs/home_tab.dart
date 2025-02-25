import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeTab extends StatelessWidget {
  final User user;
  const HomeTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          Text('Welcome ${user.displayName ?? 'User'}!',
              style: const TextStyle(fontSize: 20)),
          Text(user.email ?? '',
              style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}