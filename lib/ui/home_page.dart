import 'package:flutter/material.dart';
import 'package:live_match/logic/locator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Locator.userManagementService.signOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome back!'),
      ),
    );
  }
}
