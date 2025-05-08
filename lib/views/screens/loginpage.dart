import 'package:flutter/material.dart';
import 'package:flutter_app/controller/logincontoller.dart';
import 'package:flutter_app/views/widgets/mybutton.dart';
import 'package:flutter_app/views/widgets/mytextfield.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var store = GetStorage();

// Initialize the controller
Logincontoller logincontoller = Logincontoller();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    String userName = store.read("username") ?? "";
    userNameController.text = userName;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 5, 6),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "TULI'S BAKERY",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.maxFinite,
        color: const Color.fromARGB(255, 248, 200, 220),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 5, 40, 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/cake.jpeg',
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: myTextField(
                  hintText: "Enter Username",
                  prefixIcon: Icon(Icons.person),
                  controller: userNameController,
                  obscureText: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: myTextField(
                  hintText: "Enter Password",
                  prefixIcon: Icon(Icons.lock),
                  controller: passwordController,
                  obscureText: true,
                ),
              ),
              Obx(() => Text(Logincontoller().errorMessage.value)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.snackbar("Forgot Password", "Password recovery feature coming soon!");
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 110, 13, 89),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              myButton(() async {
                String username = userNameController.text.trim();
                String password = passwordController.text.trim();

                if (username.isEmpty || password.isEmpty) {
                  Get.snackbar('Error', 'Please fill in all fields', snackPosition: SnackPosition.BOTTOM);
                  return;
                }

                Get.dialog(
                  Center(child: CircularProgressIndicator()),
                  barrierDismissible: false,
                );

                try {
                  var response = await http.post(
                    Uri.parse("http://localhost/gallery/login.php"),
                    headers: {"Content-Type": "application/x-www-form-urlencoded"},
                    body: {
                      'username': username,
                      'password': password,
                    },
                  );
                  print(response.body);
                  if (response.statusCode == 200) {
                    var data = jsonDecode(response.body);

                    if (data['status'] == 'success') {
                      store.write("username", username);
                      store.write("email", data['email']);
                      store.write("user_id", data['user_id']);

                      Get.snackbar('Login Success', data['message'], snackPosition: SnackPosition.BOTTOM);

                      Future.delayed(Duration(seconds: 1), () {
                        Get.offNamed("/homescreen");
                      });
                    } else {
                      Get.snackbar(
                        'Login Failed',
                        data['message'] == "Invalid credentials"
                            ? "Login failed: Invalid username or password"
                            : data['message'],
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.black,
                      );
                    }
                  } else {
                    Get.snackbar(
                      'Server Error',
                      'Failed to connect to the server',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                } catch (e) {
                  Get.snackbar('Error', 'An unexpected error occurred: $e', snackPosition: SnackPosition.BOTTOM);
                } finally {
                  Get.back(); // Close loading
                }
              }, label: "Login"),
              const SizedBox(height: 30),
              myButton(() async {
                Get.toNamed("/signup");
              }, label: "Sign Up"),
            ],
          ),
        ),
      ),
    );
  }
}
