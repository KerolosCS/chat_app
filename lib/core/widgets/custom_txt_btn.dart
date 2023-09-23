import 'package:flutter/material.dart';

class CustomTxtBtn extends StatelessWidget {
  const CustomTxtBtn({super.key, required this.onPress, required this.child});
  final void Function()? onPress;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      child: child,
    );
  }
}
