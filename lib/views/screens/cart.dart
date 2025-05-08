List<Map<String, dynamic>> cart = [];

/// Add item to cart. If already exists, increment qty.
void addToCart(Map<String, dynamic> item) {
  final index = cart.indexWhere((element) => element['title'] == item['title']);
  if (index != -1) {
    cart[index]['qty'] += 1;
  } else {
    cart.add({...item, 'qty': 1});
  }
}

/// Remove entire item from cart
void removeFromCart(String title) {
  cart.removeWhere((item) => item['title'] == title);
}

/// Increase quantity of an item
void incrementQty(String title) {
  final index = cart.indexWhere((item) => item['title'] == title);
  if (index != -1) {
    cart[index]['qty'] += 1;
  }
}

/// Decrease quantity, remove item if qty is 0
void decrementQty(String title) {
  final index = cart.indexWhere((item) => item['title'] == title);
  if (index != -1) {
    if (cart[index]['qty'] > 1) {
      cart[index]['qty'] -= 1;
    } else {
      removeFromCart(title);
    }
  }
}

/// Get total price as double
double getTotalPrice() {
  return cart.fold(0.0, (sum, item) {
    return sum + (double.tryParse(item['price']) ?? 0.0) * item['qty'];
  });
}
