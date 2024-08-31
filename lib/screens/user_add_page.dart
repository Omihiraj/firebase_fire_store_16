import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_management/services/firebase_services/firebase_service.dart';
import 'package:user_management/utils/validation_util.dart';

class UserAddPage extends StatefulWidget {
  const UserAddPage({super.key});

  @override
  State<UserAddPage> createState() => _UserAddPageState();
}

class _UserAddPageState extends State<UserAddPage> {
  final nameFieldController = TextEditingController();
  final addressFieldController = TextEditingController();
  final ageFieldController = TextEditingController();

  String? nameFieldErrorText;
  String? addressFieldErrorText;
  String? ageFieldErrorText;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 30,
        ),
        const Center(
          child: Text(
            "Add New User",
            style: TextStyle(
                color: Colors.green, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: nameFieldController,
            decoration: InputDecoration(
              labelText: "Name",
              errorText: nameFieldErrorText,
            ),
            maxLength: 50,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: addressFieldController,
            decoration: InputDecoration(
              labelText: "Address",
              errorText: addressFieldErrorText,
            ),
            maxLength: 100,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: ageFieldController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Age",
              errorText: ageFieldErrorText,
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        GestureDetector(
          onTap: addUserTap,
          child: Container(
            height: 50,
            width: 150,
            //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey,
                      offset: Offset(2, 2),
                      spreadRadius: 4)
                ]),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Center(
                    child: Text(
                      "Add User",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        )
      ],
    ));
  }

  addUserTap() {
    setState(() {
      nameFieldErrorText =
          ValidationUtil.nameFieldValidator(name: nameFieldController.text);

      addressFieldErrorText = ValidationUtil.addressFieldValidator(
          address: addressFieldController.text);

      ageFieldErrorText =
          ValidationUtil.ageFieldValidator(age: ageFieldController.text);
    });

    if (nameFieldErrorText == null &&
        addressFieldErrorText == null &&
        ageFieldErrorText == null) {
      setState(() {
        isLoading = true;
      });
      FireBaseService()
          .addUser(
              name: nameFieldController.text,
              address: addressFieldController.text,
              age: int.parse(ageFieldController.text))
          .then((value) {
        setState(() {
          isLoading = false;
          nameFieldController.text = "";
          ageFieldController.text = "";
          addressFieldController.text = "";
        });
        print("User ADDED");
        Fluttertoast.showToast(
          msg: "User Added Successfull",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    }
  }
}
