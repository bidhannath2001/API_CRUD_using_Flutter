import 'package:api_crud/model/productModel.dart';
import 'package:flutter/material.dart';
import 'package:api_crud/controller/productController.dart';
import 'package:api_crud/widget/textFieldWidget.dart';

class ShowDialog {
  final BuildContext context;
  final Future Function() refresh;
  ShowDialog({required this.context, required this.refresh});

  ProductDialog(Data data, String id) {
    Productcontroller productController = Productcontroller();
    String mode = "Add";
    TextEditingController productNameController = TextEditingController();
    TextEditingController productPriceController = TextEditingController();
    TextEditingController productQtyController = TextEditingController();
    TextEditingController productImgController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();
    TextEditingController productCodeController = TextEditingController();

    if (data.sId != null) {
      productNameController.text = data.productName.toString();
      productPriceController.text = data.unitPrice.toString();
      productQtyController.text = data.qty.toString();
      productImgController.text = data.img.toString();
      productCodeController.text = data.productCode.toString();
      productTotalPriceController.text = data.totalPrice.toString();
      mode = "Update";
    }
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$mode Product",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                const SizedBox(height: 15),
                Textfieldwidget.textfield(
                    "Product Name", productNameController),
                Textfieldwidget.textfield("Price", productPriceController),
                Textfieldwidget.textfield("Image URL", productImgController),
                Textfieldwidget.textfield("QTY", productQtyController),
                Textfieldwidget.textfield(
                    "Total Price", productTotalPriceController),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                      ),
                      onPressed: () async {
                        if (mode == "Update") {
                          await productController.updateProduct(
                            Data(
                              productName: productNameController.text.trim(),
                              sId: id.toString(),
                              unitPrice:
                                  int.parse(productPriceController.text.trim()),
                              img: productImgController.text.trim(),
                              qty: int.parse(productQtyController.text.trim()),
                              totalPrice: int.parse(
                                  productTotalPriceController.text.trim()),
                              productCode:
                                  int.parse(productCodeController.text.trim()),
                            ),
                          );
                        } else {
                          await productController.addProduct(
                            Data(
                              productName: productNameController.text.trim(),
                              unitPrice:
                                  int.parse(productPriceController.text.trim()),
                              img: productImgController.text.trim(),
                              qty: int.parse(productQtyController.text.trim()),
                              totalPrice: int.parse(
                                  productTotalPriceController.text.trim()),
                            ),
                          );
                        }

                        await refresh();
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("$mode Product Successfully"),
                            backgroundColor: Colors.deepPurple,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text(
                        mode,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
