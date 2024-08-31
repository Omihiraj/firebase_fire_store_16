import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_management/screens/user_add_page.dart';
import 'package:user_management/services/firebase_services/firebase_service.dart';

import '../models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FireBaseService fireBaseService = FireBaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fireBaseService.getData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<UserModel> users = snap.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      flex: 2,
                      onPressed: (e) {
                        print(users[index].id);
                      },
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (e) {
                        FireBaseService()
                            .deleteUser(documentID: users[index].id!)
                            .then((value) {
                          Fluttertoast.showToast(
                            msg: "${users[index].name} Deleted Successfull",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.redAccent,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          setState(() {});
                        });
                      },
                      flex: 2,
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(users[index].name!),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Age : ${users[index].age}"),
                      Text("Address : ${users[index].address}")
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserAddPage(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
