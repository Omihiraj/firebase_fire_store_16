import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_management/models/user_model.dart';

class FireBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getData() async {
    CollectionReference collectionReference = firestore.collection("users");

    QuerySnapshot documents = await collectionReference.get();

    List<UserModel> users = [];
    for (var user in documents.docs) {
      print(
          "Name : ${user['name']} Age : ${user['age']} Address : ${user['address']}");
      users.add(
        UserModel(
          id: user.id,
          name: user['name'],
          age: user['age'],
          address: user['address'],
        ),
      );
    }
    return users;
  }

  Future<DocumentReference> addUser(
      {required String name, required String address, required int age}) async {
    CollectionReference collectionReference = firestore.collection("users");
    final document = await collectionReference
        .add({'name': name, 'address': address, 'age': age});

    return document;
  }

  Future deleteUser({required String documentID}) async {
    CollectionReference collectionReference = firestore.collection("users");
    final document = await collectionReference.doc(documentID).delete();

    return document;
  }
}
