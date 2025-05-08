import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final store = GetStorage();
    String username = store.read("username") ?? "Guest";
    String email = store.read("email") ?? "example@example.com";

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/picture.png'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30), // Space between profile info and buttons

          // Settings Button (Non-functional)
          ElevatedButton(
            onPressed: () {
              // Do nothing as the settings button is non-functional
            },
            child: const Text('Settings'),
            style: ElevatedButton.styleFrom(
              iconColor: Colors.blue, // Button color
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),

          const SizedBox(height: 15), // Space between buttons

          // Logout Button (Functional)
          ElevatedButton(
            onPressed: () {
              // Clear user data and navigate back to login page
              store.erase(); // Clear stored data
              Get.offAllNamed("/login"); // Navigate to login page
            },
            child: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              iconColor: Colors.red, // Button color
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
