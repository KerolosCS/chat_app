import 'package:chat_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomSendMessage extends StatelessWidget {
  const CustomSendMessage({
    super.key,
    required this.hintTxt,
    this.preIcon,
    this.control,
    this.validation,
    this.marg,
    this.suffixIcon,
    this.suffixOnPress,
    this.onSubmitted,
  });
  final String hintTxt;
  final IconData? preIcon;
  final IconData? suffixIcon;
  final TextEditingController? control;
  final String? Function(String?)? validation;
  final double? marg;
  final void Function()? suffixOnPress;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(marg ?? 0),
      // height: 48,
      child: TextFormField(
        onFieldSubmitted: onSubmitted,
        style: const TextStyle(color: Colors.black),
        validator: validation,
        controller: control,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            color: kPrimaryColor,
            icon: Icon(suffixIcon),
            onPressed: suffixOnPress,
          ),
          //  prefixIcon: Icon(preIcon),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
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
