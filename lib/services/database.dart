import 'package:caducee/models/drug.dart';
import 'package:caducee/models/user.dart';
import 'package:caducee/models/category.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DatabaseService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference drugCollection = FirebaseFirestore.instance.collection('drugs');

  Future<void> saveUser(String name, String email) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  AppUserData _userFromSnapshot(DocumentSnapshot snapshot) {
  return AppUserData(
    uid: uid,
    name: (snapshot.data() as Map<String, dynamic>)['name'],
    email: (snapshot.data() as Map<String, dynamic>)['email'],
  );
}


  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserData> _userListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return AppUserData(
      uid: uid,
      name: (doc.data() as Map<String, dynamic>)['name'],
      email: (doc.data() as Map<String, dynamic>)['email'],
    );
  }).toList();
  }

  Stream<List<AppUserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  Stream<List<AppDrugData>> get drugs {
    return drugCollection.snapshots().map(_drugListFromSnapshot);
  }

  List<AppDrugData> _drugListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AppDrugData(
        name: (doc.data() as Map<String, dynamic>)['name'],
        brand: (doc.data() as Map<String, dynamic>)['brand'].cast<String>(),
        shortDesc: (doc.data() as Map<String, dynamic>)['shortDesc'],
        longDesc: (doc.data() as Map<String, dynamic>)['longDesc'],
        dosage: (doc.data() as Map<String, dynamic>)['dosage'].cast<String>(),
        category: (doc.data() as Map<String, dynamic>)['category'],
        recommendation: (doc.data() as Map<String, dynamic>)['recommendation'],
        usage: (doc.data() as Map<String, dynamic>)['usage'],
      );
    }).toList();
  }

  Future<void> saveDrug(String name, List<String> brand, String shortDesc, String longDesc, List<String> dosage, String category, String recommendation, String usage) async {
    return await drugCollection.doc(name).set({
      'name': name,
      'brand': brand,
      'shortDesc': shortDesc,
      'longDesc': longDesc,
      'dosage': dosage,
      'category': category,
      'recommendation': recommendation,
      'usage': usage,
    });
  }

  Stream<List<Category>> get categories {
    return _db.collection('categories').snapshots().map(_categoryListFromSnapshot);
  }

  List<Category> _categoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Category(
        name: (doc.data() as Map<String, dynamic>)['name'],
        description: (doc.data() as Map<String, dynamic>)['description'],
      );
    }).toList();
  }

  Future<void> saveCategory(String name, String description) async {
    return await _db.collection('categories').doc(name).set({
      'name': name,
      'description': description,
    });
  }


}