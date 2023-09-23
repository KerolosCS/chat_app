import 'package:flutter/material.dart';
// import 'package:lafuu_e_commerce/core/utils/constant.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, required this.onPress, required this.child});
  final void Function()? onPress;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        style: const ButtonStyle(
          // padding: MaterialStatePropertyAll(EdgeInsets.zero),

          backgroundColor: MaterialStatePropertyAll(Colors.white),
        ),
        onPressed: onPress,
        child: child,
      ),
    );
  }
}
