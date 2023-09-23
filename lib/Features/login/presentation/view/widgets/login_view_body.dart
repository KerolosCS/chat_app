// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/Features/home/pressentation/view/home_view.dart';
import 'package:chat_app/Features/login/presentation/view/sign_up_view.dart';
import 'package:chat_app/core/utils/fun.dart';
import 'package:chat_app/core/widgets/custom_btn.dart';
import 'package:chat_app/core/widgets/custom_txt_btn.dart';
import 'package:chat_app/core/widgets/custom_txt_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  var emailController = TextEditingController();

  var passwwordController = TextEditingController();

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // const Spacer(flex: 2),
                  SizedBox(height: MediaQuery.of(context).size.height * .09),
                  Image.asset(
                    'assets/images/chat.png',
                    height: MediaQuery.of(context).size.height * .2,
                  ),
                  Text(
                    'Chat with your Friends',
                    style: GoogleFonts.pacifico(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ), //TextStyle()
                  ),
                  // const Spacer(flex: 2),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Row(
                    children: [
                      Text(
                        'LOGIN',
                        style: GoogleFonts.kadwa(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ), //TextStyle()
                      ),
                    ],
                  ),

                  CustomTextFormField(
                    validation: (p0) =>
                        p0!.isEmpty ? 'Please enter your email ' : null,
                    control: emailController,
                    hintTxt: 'Email',
                  ),
                  const SizedBox(height: 8),

                  CustomTextFormField(
                    validation: (p0) =>
                        p0!.isEmpty ? 'Please enter your password ' : null,
                    control: passwwordController,
                    hintTxt: 'Password',
                  ),
                  const SizedBox(height: 16),
                  CustomBtn(
                    onPress: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          // MyFunctions.showSnackBar(
                          //   context,
                          //   'Login Successfully ! ',
                          // );

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeView(id: emailController.text),
                            ),
                            (route) => false,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            MyFunctions.showSnackBar(
                                context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            MyFunctions.showSnackBar(
                                context, 'Wrong password ,Please try again.');
                          }
                        } catch (e) {
                          MyFunctions.showSnackBar(context, e.toString());
                        }

                        isLoading = false;
                        setState(() {});
                      } else {
                        MyFunctions.showSnackBar(
                            context, 'Please insert all fields');
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Dont\'t have an account ? '),
                      CustomTxtBtn(
                        onPress: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const SignUpView();
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              transitionsBuilder: (_, a, __, c) =>
                                  FadeTransition(opacity: a, child: c),
                            ),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwwordController.text);
  }
}
