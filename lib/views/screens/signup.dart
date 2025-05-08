import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_app/configs/mycolors.dart';
import 'package:flutter_app/controller/signupcontroller.dart';
import 'package:flutter_app/views/widgets/mybutton.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

TextEditingController userNameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController confirmpasswordController = TextEditingController();
var store = GetStorage();

Signupcontroller signupcontroller = signupcontroller;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    String userName = store.read("username") ?? "";
    userNameController.text = userName;

    return Scaffold(
      // Adding an AppBar at the top
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.black), // Text color
        ),
        backgroundColor: Color.fromARGB(255, 248, 200, 220), // AppBar background
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white), // Optional: set icon color to match
      ),
      body: Container(
        color: Color.fromARGB(255, 248, 200, 220), // Set the background color here (light pink for example)
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 5, 40, 10),
          child: Column(
            children: [
              const SizedBox(height: 100),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white, // White background for the text field
                    filled: true, // Makes the background color apply
                    border: OutlineInputBorder(),
                    label: Text("Username"),
                    hintText: "Enter your username",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                    hintText: "Enter your email",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                    hintText: "Enter your password",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: confirmpasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    label: Text("Confirm Password"),
                    hintText: "Confirm your password",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              myButton(() async {
                String username = userNameController.text.trim();
                String password = passwordController.text.trim();
                String email = emailController.text.trim();
                String confirmpassword = confirmpasswordController.text.trim();

                if (username.isEmpty || password.isEmpty || email.isEmpty || confirmpassword.isEmpty) {
                  Get.snackbar('Error', 'Please fill in all fields', snackPosition: SnackPosition.BOTTOM);
                  return;
                }

                Get.snackbar('Loading', 'Verifying credentials...', snackPosition: SnackPosition.BOTTOM);

                var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
                var request = http.Request('POST', Uri.parse('http://localhost/gallery/signup.php'));
                request.bodyFields = {
                  'username': userNameController.text,
                  'password': passwordController.text,
                  'email': emailController.text,
                  'confirmpassword': confirmpasswordController.text,
                };
                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 200) {
                  String responseBody = await response.stream.bytesToString();
                  var responseData = jsonDecode(responseBody);

                  // Check if signup is successful based on the response
                  if (responseData['status'] == 'success') {
                    Get.snackbar('Success', 'Sign Up Successful', snackPosition: SnackPosition.BOTTOM);
                    // Optionally, navigate to another page after successful sign up
                    // Get.toNamed("/login");
                  } else {
                    Get.snackbar('Error', responseData['message'] ?? 'Signup failed', snackPosition: SnackPosition.BOTTOM);
                  }
                } else {
                  Get.snackbar('Error', 'Failed to sign up', snackPosition: SnackPosition.BOTTOM);
                }
              }, label: "Sign up"),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.toNamed("/login");
                },
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
