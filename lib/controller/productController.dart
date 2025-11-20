import 'dart:convert';
import 'package:api_crud/model/productModel.dart';
import 'package:api_crud/utils/urls.dart';
import 'package:http/http.dart' as http;

class Productcontroller {
  List<Data> products = [];
  bool isLoading = false;

  Future fetchProdcuts() async {
    isLoading = true;
    // debug
    // print(Urls.readProduct);
    // print("Method is called");
    final response = await http.get(Uri.parse(Urls.readProduct));
    if (response.statusCode == 200) {
      // print(response.body);
      final data = jsonDecode(response.body);
      Productmodel model = Productmodel.fromJson(data);
      products = model.data ?? [];
      // print(products);
    }
    isLoading = false;
  }

  Future<bool> deleteProduct(String ProductId) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(ProductId)));
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  Future<bool> addProduct(Data data) async {
    final response = await http.post(
      Uri.parse(Urls.addProduct),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "ProductName": data.productName,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": data.img,
        "Qty": data.qty,
        "UnitPrice": data.unitPrice,
        "TotalPrice": data.totalPrice
      }),
    );
    //debug
    // print(response.body);
    return response.statusCode == 200;
  }

  Future<bool> updateProduct(Data data) async {
    final response = await http.post(
      Uri.parse(Urls.updateProduct(data.sId.toString())),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "ProductName": data.productName,
        "ProductCode": data.productCode,
        "Img": data.img,
        "Qty": data.qty,
        "UnitPrice": data.unitPrice,
        "TotalPrice": data.totalPrice
      }),
    );
    //debug
    // print(response.body);
    return response.statusCode == 200;
  }
}
