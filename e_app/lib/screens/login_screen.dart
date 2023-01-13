import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_app/Bloc/auth_bloc/auth_bloc.dart';
import 'package:e_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../reuseable/app_button.dart';
import '../reuseable/app_text_field.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const MaterialScrollBehavior().copyWith(scrollbars: false);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
            child:
                BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthenticatedState) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          }
          if (state is AuthErrorState) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        }, builder: (context, state) {
          if (state is LoadingState) {
            // Showing the loading indicator while the user is signing in
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UnAuthenticatedState) {
            return Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'Login',
                          textStyle: const TextStyle(
                            fontSize: 45.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 300),
                        ),
                      ],
                      totalRepeatCount: 100,
                      pause: const Duration(milliseconds: 300),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
                  SizedBox(
                    height: height / 10,
                  ),
                  AppTextField(
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                      labelText: "Enter the Email",
                      hintText: "Enter the Email"),
                  SizedBox(
                    height: height / 30,
                  ),
                  AppTextField(
                      controller: _passwordController,
                      textInputType: TextInputType.emailAddress,
                      labelText: "Enter the Password",
                      hintText: "Enter the Password"),
                  SizedBox(
                    height: height / 100,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(SignInRequested(
                            email: _emailController.text,
                            password: _passwordController.text));
                      }

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => const HomeScreen()));
                    },
                    child: const AppButton(
                        textButton: 'Login',
                        iconButton: Icons.arrow_forward_rounded,
                        paddingButton: EdgeInsets.only(left: 115)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignupScreen()));
                    },
                    child: const AppButton(
                        textButton: 'Signup',
                        iconButton: Icons.arrow_forward_rounded,
                        paddingButton: EdgeInsets.only(left: 98)),
                  ),
                ],
              ),
            );
          }
          return const Text('Something Went Wrong');
        })));
  }
}
