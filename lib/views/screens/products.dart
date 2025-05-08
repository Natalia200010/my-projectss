import 'package:flutter/material.dart';
import 'cart.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> categories = ['Cakes', 'Cookies', 'Pastries'];

  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/vanillacake.png",
      "title": "Classic Vanilla Cake",
      "description": "Soft vanilla sponge cake with creamy frosting",
      "price": "2500",
      "category": "Cakes"
    },
    {
      "image": "assets/images/chocolatecake.png",
      "title": "Chocolate Cake",
      "description": "Three-layer chocolate cake with rich frosting",
      "price": "2800",
      "category": "Cakes"
    },
    {
      "image": "assets/images/redvelvetcake.png",
      "title": "Red Velvet Cake",
      "description": "Moist red velvet cake with cream cheese icing",
      "price": "2700",
      "category": "Cakes"
    },
    {
      "image": "assets/images/carrotcakr.png",
      "title": "Carrot Cake",
      "description": "Carrot cake with pineapple, coconut, raisins, and walnuts",
      "price": "2600",
      "category": "Cakes"
    },
     {
      "image": "assets/images/mothersdaycake.png",
      "title": "Mothers Day Special",
      "description": "Carrot cake with pineapple, coconut, raisins, and walnuts",
      "price": "2600",
      "category": "Cakes"
    },
    {
      "image": "assets/images/cookie.png",
      "title": "Chocolate Chip Cookies",
      "description": "Crunchy and chewy cookies with chocolate chips",
      "price": "100",
      "category": "Cookies"
    },
    {
      "image": "assets/images/sugarcookies.png",
      "title": "Sugar Cookies",
      "description": "Sweet butter cookies with frosting",
      "price": "150",
      "category": "Cookies"
    },
    {
      "image": "assets/images/croissant.png",
      "title": "Croissant",
      "description": "Flaky buttery French pastry",
      "price": "300",
      "category": "Pastries"
    },
    {
      "image": "assets/images/danish.png",
      "title": "Danish Pastry",
      "description": " Fruit-filled pastry with icing drizzle",
      "price": "350",
      "category": "Pastries"
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: categories.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            "Our Products",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        TabBar(
          controller: _tabController,
          labelColor: Colors.pink[800],
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.pink,
          tabs: categories.map((cat) => Tab(text: cat)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: categories.map((category) {
              final filtered = products
                  .where((product) => product['category'] == category)
                  .toList();
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final product = filtered[index];
                  return ProductCard(product: product);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              product["image"],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  product["title"],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "Ksh ${product["price"]}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                Text(
                  product["description"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    addToCart({
                      "title": product["title"],
                      "price": product["price"],
                      "image": product["image"],
                      "description": product["description"],
                      "qty": 1,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Item added to cart")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    textStyle: const TextStyle(fontSize: 12),
                    backgroundColor: const Color.fromARGB(255, 156, 62, 94),
                  ),
                  child: const Text("Add to Cart", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
