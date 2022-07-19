import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  final String hint;
  final String valTitle;
  final TextEditingController myController;
  final int? minline;
  final int? maxline;
  const MyTextForm({
    Key? key,
    required this.hint,
    required this.valTitle,
    required this.myController, this.minline, this.maxline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minline,
      maxLines: maxline,
      controller: myController,
      validator: (value) => value!.isEmpty ? valTitle : null,
      decoration: InputDecoration(
        
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1),
        ),
      ),
    );
  }
}
