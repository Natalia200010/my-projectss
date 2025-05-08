import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final store = GetStorage();

  void incrementQty(int index) {
    setState(() {
      cart[index]['qty'] = (cart[index]['qty'] ?? 1) + 1;
    });
  }

  void decrementQty(int index) {
    setState(() {
      if (cart[index]['qty'] > 1) {
        cart[index]['qty'] -= 1;
      }
    });
  }

  double getTotal() {
    double total = 0;
    for (var item in cart) {
      int qty = item['qty'] ?? 1;
      double price = double.tryParse(item['price'].toString()) ?? 0;
      total += qty * price;
    }
    return total;
  }

  Future<void> placeOrder() async {
    String? username = store.read("username");
    if (username == null || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    for (var item in cart) {
      final imageName = item['image']!.split('/').last;

      final response = await http.post(
        Uri.parse("http://localhost/gallery/menu.php"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          "username": username,
          "title": item["title"],
          "description": "Qty: ${item['qty']}",
          "image": imageName,
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode != 200 || data['status'] != 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to place order: ${item['title']}")),
        );
        return;
      }
    }

    setState(() {
      cart.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order placed successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: cart.isEmpty
          ? const Center(child: Text("No items in cart"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      final qty = item['qty'] ?? 1;

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Image.asset(item['image'], width: 50, height: 50),
                          title: Text(item['title']),
                          subtitle: Text("ksh ${item['price']} \nQty: $qty"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, color: Color.fromARGB(255, 92, 14, 62)),
                                onPressed: () => decrementQty(index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, color: Colors.green),
                                onPressed: () => incrementQty(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text("Total:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text("ksh ${getTotal().toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 92, 14, 62))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: cart.isEmpty ? null : placeOrder,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 156, 62, 94),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text("Place Order", style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
