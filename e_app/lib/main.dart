import 'package:e_app/Bloc/auth_bloc/auth_bloc.dart';
import 'package:e_app/repositories/checkout_repository.dart';
import 'package:e_app/repositories/user_repository.dart';
import 'package:e_app/screens/home_screen.dart';
import 'package:e_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/checkout_bloc/checkout_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository()),
        RepositoryProvider<CheckOutRepository>(
            create: (context) => CheckOutRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context))),
          BlocProvider(
              create: (context) => OrderBloc(
                  checkOutRepository:
                      RepositoryProvider.of<CheckOutRepository>(context))),
          // BlocProvider(create: (context) => CartBloc()),
          // BlocProvider(create: (context) => CalculateSumCubit()),
          // BlocProvider(create: (context) => ProductBloc(testProductRepository: TestProductRepository()))
        ],
        child: RepositoryProvider(
          create: (context) => AuthRepository(),
          child: BlocProvider(
              create: (context) => AuthBloc(
                    authRepository:
                        RepositoryProvider.of<AuthRepository>(context),
                  ),
              child: MaterialApp(
                // theme: appTheme(),
                debugShowCheckedModeBanner: false,
                home: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const HomeScreen();
                      }
                      return const LoginScreen();
                    }),
              )),
        ),
      ),
    );
  }
}
