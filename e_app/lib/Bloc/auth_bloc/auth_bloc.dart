import 'package:e_app/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticatedState()) {
    on<SignInRequested>((event, emit) async {
      emit(LoadingState());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthenticatedState());
      }
    });

    // When User Presses the SignUp Button,
    // we will send the SignUpRequest Event to the
    // AuthBloc to handle it and emit the Authenticated
    // State if the user is authenticated
    on<SignUpRequested>((event, emit) async {
      emit(LoadingState());
      try {
        await authRepository.signUp(
            emailU: event.email,
            nameU: event.name,
            mobileNumber: event.mobileNumber,
            address: event.address,
            password: event.password,
            confirmPassword: event.confirmPassword);
        if (event.password == event.confirmPassword) {
          emit(AuthenticatedState());
        } else {
          return emit(UnAuthenticatedState());

          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //         content: Text("Order Confirm")));
        }
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthenticatedState());
      }
    });

    // When User Presses the SignOut Button,
    // we will send the SignOutRequested Event to
    // the AuthBloc to handle it and emit the
    // UnAuthenticated State
    on<SignOutRequested>((event, emit) async {
      emit(LoadingState());
      await authRepository.signOut();
      emit(UnAuthenticatedState());
    });
  }
}
