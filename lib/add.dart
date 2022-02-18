import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operation/constraints.dart/textfield.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //form key
  final _formkey = GlobalKey<FormState>();
  // text for textfield
  String email = '';
  String name = '';
  String password = '';
  // textfield
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //Clearing Text
  _clearText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  //Resigtering Users
  CollectionReference addUser =
      FirebaseFirestore.instance.collection('Students');
  Future<void> _registerUser() {
    return addUser
        .add({'Name': name, 'Email': email, 'Password': password})
        .then((value) => print('User Added'))
        .catchError((_) => print('Something Error In registering User'));
  }

  //Disposing Textfield
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            CustomTextEditField(
              controller: nameController,
              labettxt: 'Name',
            ),
            CustomTextEditField(
              controller: emailController,
              labettxt: 'Email',
              valid: true,
            ),
            CustomTextEditField(
              controller: passwordController,
              labettxt: 'Password',
              visibility: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        name = nameController.text;
                        email = emailController.text;
                        password = passwordController.text;
                        _registerUser();
                        _clearText();
                        Navigator.pop(context);
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: const Text('Register'),
                ),
                ElevatedButton(
                  onPressed: _clearText,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
