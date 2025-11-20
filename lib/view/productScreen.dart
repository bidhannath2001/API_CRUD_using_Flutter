import 'package:api_crud/controller/productController.dart';
import 'package:api_crud/model/productModel.dart';
import 'package:api_crud/utils/dialog.dart';
import 'package:api_crud/view/prodcutDetails.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Productscreen extends StatefulWidget {
  const Productscreen({super.key});

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  Productcontroller productController = Productcontroller();
  List products = [];
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future fetchData() async {
    setState(() {
      productController.isLoading = true;
    });
    await productController.fetchProdcuts();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(productController.isLoading);
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Screen",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: productController.isLoading
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Colors.deepPurple, size: 100))
            : GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: productController.products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    crossAxisCount:
                        orientation == Orientation.portrait ? 2 : 4),
                itemBuilder: (context, index) {
                  final item = productController.products[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                                  product: item,
                                ))),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      shadowColor: Colors.deepPurple.withOpacity(0.3),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 'product-${item.sId}', // unique tag
                            child: Container(
                              height: 130,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepPurple.shade50.withOpacity(0.2),
                                    Colors.deepPurple.shade100.withOpacity(0.2)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Image.network(
                                item.img.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                        child:
                                            Icon(Icons.broken_image, size: 40)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              item.productName.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.pink, Colors.orange],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "\$${item.totalPrice}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Qty: ${item.qty}",
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    ShowDialog(
                                            context: context,
                                            refresh: fetchData)
                                        .ProductDialog(
                                            item, item.sId.toString());
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(Icons.edit,
                                        color: Colors.orange, size: 26),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Text(
                                          "Are you sure you want to delete ${item.productName}?",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Cancel")),
                                          TextButton(
                                            onPressed: () async {
                                              await productController
                                                  .deleteProduct(
                                                      item.sId.toString())
                                                  .then(
                                                (value) async {
                                                  if (value) {
                                                    await fetchData();
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Product has been deleted"),
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Something went wrong"),
                                                      ),
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                            child: const Text(
                                              "Delete",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(Icons.delete,
                                        color: Colors.red, size: 26),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {
            ShowDialog(context: context, refresh: fetchData)
                .ProductDialog(Data(), "");
          },
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
