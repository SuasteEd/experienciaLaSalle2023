import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsService {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('Products');
  
  final CollectionReference _bannerCollection =
      FirebaseFirestore.instance.collection('Banner');

  //Stream of products
  Stream<QuerySnapshot> getProducts() {
    return _productsCollection.snapshots();
  }

  //Stream of banner
  Stream<QuerySnapshot> getBanner() {
    return _bannerCollection.snapshots();
  }

  //Add product
  Future<void> addProduct(Map<String, dynamic> data) async {
    await _productsCollection.add(data);
  }

}