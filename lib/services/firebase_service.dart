import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference db = FirebaseDatabase.instance.ref();

  DatabaseReference getUserRef(String userId) {
    return db.child('users').child(userId);
  }

  DatabaseReference getCollectionRef(String collection, String userId) {
    return db.child(collection).child(userId);
  }
}
