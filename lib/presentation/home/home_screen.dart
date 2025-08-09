// FILE: lib/presentation/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // सुनिश्चित करें कि context अभी भी वैलिड है
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed(AppRoutes.login);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome,',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                user?.displayName ?? user?.email ?? 'User',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: () {
                  // बाद में हम यहाँ AI डाउट सॉल्वर का कोड जोड़ेंगे
                },
                icon: const Icon(Icons.support_agent),
                label: const Text('Ask AI Doubt Solver'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)
                ),
              ),
               const SizedBox(height: 16),
              OutlinedButton.icon(
                 onPressed: () {
                  // बाद में हम यहाँ मॉक टेस्ट का कोड जोड़ेंगे
                },
                icon: const Icon(Icons.quiz),
                label: const Text('Attempt Mock Test'),
                 style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
