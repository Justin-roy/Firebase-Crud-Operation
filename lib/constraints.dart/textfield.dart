import 'package:flutter/material.dart';

class CustomTextEditField extends StatelessWidget {
  const CustomTextEditField({
    Key? key,
    required this.controller,
    required this.labettxt,
    this.visibility = false,
    this.valid = false,
  }) : super(key: key);
  final TextEditingController controller;
  final String labettxt;
  final bool visibility, valid;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 15,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labettxt,
          labelStyle: const TextStyle(fontSize: 18),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 15),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        controller: controller,
        obscureText: visibility,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please Fill $labettxt';
          }
          if (valid && !val.contains('@')) {
            return 'Please Enter Valid Email';
          }
          return null;
        },
      ),
    );
  }
}
