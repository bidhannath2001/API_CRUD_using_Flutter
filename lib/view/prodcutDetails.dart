import 'package:api_crud/model/productModel.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Data product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName ?? ""),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            Hero(
              tag: 'product-${product.sId}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  product.img ?? "",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.broken_image, size: 60)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Product Name
            Text(
              product.productName ?? "",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),

            // Price and Quantity
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Price: \$${product.unitPrice}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "Qty: ${product.qty}",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Total Price
            Text(
              "Total Price: \$${product.totalPrice}",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            const SizedBox(height: 10),

            // Product Code
            Text(
              "Product Code: ${product.productCode}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // dummy table
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12)),
              child: Table(
                border:
                    TableBorder.all(color: Colors.deepPurple.withOpacity(0.3)),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                children: const [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Feature",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Specification",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Storage"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("128GB"),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(color: Colors.white),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Bluetooth Range"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("10 meters"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Display Resolution"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("1080 x 2400"),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(color: Colors.white),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Battery"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("4500 mAh"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Processor"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Snapdragon 888"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
