import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintTxt,
    this.preIcon,
    this.control,
    this.validation,
    this.marg,
  });
  final String hintTxt;
  final IconData? preIcon;
  final TextEditingController? control;
  final String? Function(String?)? validation;
  final double? marg;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(marg ?? 0),
      // height: 48,
      child: TextFormField(
        validator: validation,
        controller: control,
        decoration: InputDecoration(
          //  prefixIcon: Icon(preIcon),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 186, 186, 186),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          hintText: hintTxt,
          hintStyle: const TextStyle(
            color: Color(0xff9098B1),
          ),
        ),
      ),
    );
  }
}
