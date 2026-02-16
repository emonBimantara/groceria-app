import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceria/Model/product_model.dart';

class GroceriaService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<String>> getCategories() async {
    final snapshot = await db.collection('categories').get();

    return snapshot.docs.map((doc) {
      return doc['Name'] as String;
    }).toList();
  }

  Stream<List<ProductModel>> getProducts(String selectedCategory) {
    Query query = db.collection('products');

    if (selectedCategory != "All") {
      query = query.where('category', isEqualTo: selectedCategory);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromFireStore(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }
}
