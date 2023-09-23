import 'package:chat_app/Features/home/pressentation/view/widgets/home_view_body.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/chat.png',
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text('Chat'),
          ],
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: Colors.white,
      body: HomeViewBody(
        id: id,
      ),
    );
  }
}
