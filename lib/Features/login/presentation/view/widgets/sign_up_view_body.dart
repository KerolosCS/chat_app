// ignore_for_file: must_be_immutable

import 'package:chat_app/Features/home/pressentation/view/home_view.dart';
import 'package:chat_app/Features/login/presentation/view/login_view.dart';
import 'package:chat_app/core/utils/fun.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../core/widgets/custom_btn.dart';
import '../../../../../core/widgets/custom_txt_btn.dart';
import '../../../../../core/widgets/custom_txt_form_field.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({
    super.key,
  });

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  var emailController = TextEditingController();

  var passwwordController = TextEditingController();

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
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
                        'Sign Up',
                        style: GoogleFonts.kadwa(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ), //TextStyle()
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    control: emailController,
                    hintTxt: 'Email',
                  ),
                  const SizedBox(height: 8),
                  const CustomTextFormField(
                    hintTxt: 'Phone',
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
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
                          await registerUser(
                              emailController, passwwordController);
                          // ignore: use_build_context_synchronously
                          MyFunctions.showSnackBar(
                              context, 'Account Created Successfully.');
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return HomeView(
                                  id: emailController.text,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              transitionsBuilder: (_, a, __, c) =>
                                  FadeTransition(opacity: a, child: c),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            MyFunctions.showSnackBar(
                                context, 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            MyFunctions.showSnackBar(context,
                                'The account already exists for that email');
                          }
                        } catch (e) {
                          MyFunctions.showSnackBar(context, e.toString());
                        }
                        isLoading = false;
                        setState(() {});
                      } else {
                        MyFunctions.showSnackBar(
                            context, 'Please fill All Fields ');
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account ? '),
                      CustomTxtBtn(
                        onPress: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const LoginView();
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              transitionsBuilder: (_, a, __, c) =>
                                  FadeTransition(opacity: a, child: c),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(TextEditingController emailController,
      TextEditingController passwwordController) async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwwordController.text,
    );
  }
}
