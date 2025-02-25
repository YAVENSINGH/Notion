import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';

Future<void> initializeAppServices() async {
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Notifications
  final notificationService = NotificationService();
  await notificationService.initialize();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Run the app immediately; actual async work is handled inside the widget tree.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This Future encapsulates all required initializations.
  Future<void> _initialize() async {
    await initializeAppServices();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // Use FutureBuilder to wait for setup completion.
      home: FutureBuilder(
        future: _initialize(),
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for initialization, show a splash screen / loading indicator.
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            // If there was an error during initialization.
            return Scaffold(
              body: Center(
                child: Text(
                  "Initialization Error:\n${snapshot.error}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          } else {
            // Initialization complete; proceed with authentication check.
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, authSnapshot) {
                // When auth stream is ready:
                if (authSnapshot.connectionState == ConnectionState.active) {
                  // If a user is logged in, navigate to HomeScreen.
                  if (authSnapshot.data != null) {
                    return HomeScreen(user: authSnapshot.data!);
                  } else {
                    // No user logged in, show the LoginScreen.
                    return const LoginScreen();
                  }
                }
                // Otherwise, show another loading indicator.
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
