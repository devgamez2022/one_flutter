import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  const InputPassword(
    {
      super.key, 
      this.controller, 
      this.hintText, 
      this.labelText, 
      this.textInputType, 
      this.isPasswordField
    }
  );

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? textInputType;
  final bool? isPasswordField;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.35),
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        
      ),
    );
  }
}