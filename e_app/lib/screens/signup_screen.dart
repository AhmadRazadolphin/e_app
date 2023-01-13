import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_app/Bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../reuseable/app_button.dart';
import '../reuseable/app_text_field.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _moboileNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _moboileNumberController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
            child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              // Navigating to the dashboard screen if the user is authenticated
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()));
            }
            if (state is AuthErrorState) {
              // Displaying the error message if the user is not authenticated
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              // Displaying the loading indicator while the user is signing up
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UnAuthenticatedState) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'Signup',
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
                      labelText: "Enter the Email",
                      hintText: "Enter the Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    AppTextField(
                        controller: _nameController,
                        labelText: "Enter the name.",
                        textInputType: TextInputType.emailAddress,
                        hintText: "Enter the name."),
                    SizedBox(
                      height: height / 30,
                    ),
                    AppTextField(
                        controller: _moboileNumberController,
                        labelText: "Enter the mobile number.",
                        textInputType: TextInputType.emailAddress,
                        hintText: "Enter the mobile number."),
                    SizedBox(
                      height: height / 30,
                    ),
                    AppTextField(
                        controller: _addressController,
                        labelText: "Enter the address.",
                        textInputType: TextInputType.emailAddress,
                        hintText: "Enter the address."),
                    SizedBox(
                      height: height / 30,
                    ),
                    AppTextField(
                        controller: _passwordController,
                        labelText: "Enter the password.",
                        textInputType: TextInputType.emailAddress,
                        hintText: "Enter the password."),
                    SizedBox(
                      height: height / 30,
                    ),
                    AppTextField(
                        controller: _confirmPasswordController,
                        labelText: "Enter the confirm password.",
                        textInputType: TextInputType.emailAddress,
                        hintText: "Enter the confirm password."),
                    SizedBox(
                      height: height / 30,
                    ),
                    InkWell(
                      onTap: () {
                        _createAccountWithEmailAndPassword(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => const LoginScreen()));
                      },
                      child: const AppButton(
                        textButton: 'Signup',
                        iconButton: Icons.arrow_forward_rounded,
                        paddingButton: EdgeInsets.only(left: 115),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text('Something Went Wrong');
          },
        )),
      ),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(SignUpRequested(
          email: _emailController.text,
          name: _nameController.text,
          mobileNumber: _moboileNumberController.text,
          address: _addressController.text,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text));
    }
  }
}
