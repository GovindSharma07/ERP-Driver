import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<List<String>> getTokens(String uid) async {
    List<String> tokens = <String>[];

    try {
      final snapshot = await _db.collection("User-Driver").doc(uid).collection("tokens").get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final token = doc.data()["token"];
          if (token != null) {
            tokens.add(token);
          } else {
            print("Document missing 'tokenId' field: ${doc.id}");
          }
        }
      } else {
        print("No documents found in collection");
      }
    } on FirebaseException catch (e) {
      print("Error fetching tokens: $e");
    }

    return tokens;
  }
}
