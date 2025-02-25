import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/notification_service.dart';

class SettingsTab extends StatefulWidget {
  final User user;
  const SettingsTab({super.key, required this.user});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _notificationsEnabled = true;
  bool _scheduled = false;

  Future<void> _scheduleTestNotification() async {
    try {
      await NotificationService().scheduleNotification(
        message: 'Hello ${widget.user.displayName ?? 'User'}! This is your reminder.',
      );
      setState(() => _scheduled = true);

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notification scheduled for 5 seconds from now'),
          duration: Duration(seconds: 2),
        ), // Added missing closing parenthesis
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error scheduling notification: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 10),
        SwitchListTile(
          title: const Text('Enable Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('Receive important updates and reminders'),
          value: _notificationsEnabled,
          onChanged: (value) => setState(() => _notificationsEnabled = value),
        ),
        const Divider(thickness: 1),
        ListTile(
          title: const Text('Test Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('Schedule a demo notification'),
          trailing: FilledButton.icon(
            icon: const Icon(Icons.notifications_active, size: 20),
            label: Text(_scheduled ? 'Scheduled!' : 'Schedule Test'),
            onPressed: _notificationsEnabled ? _scheduleTestNotification : null,
          ),
        ),
        const Divider(thickness: 1),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Account Email'),
          subtitle: Text(widget.user.email ?? 'No email connected'),
        ),
        ListTile(
          leading: const Icon(Icons.verified_user),
          title: const Text('Email Verified'),
          subtitle: Text(widget.user.emailVerified.toString()),
        ),
        const Divider(thickness: 1),
        ListTile(
          leading: const Icon(Icons.security),
          title: const Text('Privacy Settings'),
          onTap: () {}, // Add navigation here
        ),
      ],
    );
  }
}