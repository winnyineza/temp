import 'package:flutter/material.dart';

void main() {
  runApp(const ProductNavigationApp());
}

class ProductNavigationApp extends StatelessWidget {
  const ProductNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductListScreen(),
    );
  }
}

class Product {
  final String name;
  final String description;
  final int price;
  final Color color;
  final int rating;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.color,
    required this.rating,
  });
}

class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Pixel 1',
      description: 'Pixel is the most featureful phone ever',
      price: 800,
      color: Colors.blue,
      rating: 2,
    ),
    Product(
      name: 'Laptop',
      description: 'Laptop is the most productive development tool',
      price: 2000,
      color: Colors.green,
      rating: 4,
    ),
    Product(
      name: 'Tablet',
      description: 'Tablet is the most useful device ever for meeting',
      price: 1500,
      color: Colors.amber,
      rating: 3,
    ),
    Product(
      name: 'Pen Drive',
      description: 'iPhone is the stylist phone ever',
      price: 100,
      color: Colors.brown,
      rating: 1,
    ),
    Product(
      name: 'Floppy Drive',
      description: 'iPhone is the stylist phone ever',
      price: 100,
      color: Colors.teal,
      rating: 5,
    ),
  ];

  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set the navigation bar color
        automaticallyImplyLeading: false, // Hide the default back button
        flexibleSpace: SafeArea(
          child: Container(
            color: Colors.blue, // Set the header color
            padding: const EdgeInsets.all(16.0),
            child: const Center(
              child: Text(
                'Product Navigation',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: products[index].color,
                  child: Center(
                    child: Text(
                      products[index].name,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      products[index].name,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(products[index].description),
                        Text('Price: ${products[index].price}'),
                        Row(
                          children: List.generate(
                            5,
                            (starIndex) => Icon(
                              starIndex < products[index].rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: products[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.blue, // Set the navigation bar color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: product.color,
              child: Center(
                child: Text(
                  product.name,
                  style: const TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 8),
            Text('Price: ${product.price}'),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < product.rating ? Icons.star : Icons.star_border,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
