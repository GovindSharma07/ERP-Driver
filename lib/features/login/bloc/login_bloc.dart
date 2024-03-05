import 'dart:async';

import 'package:bloc/bloc.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SignInLoginEvent>(_signInLoginEvent);
    on<LoginButtonErrorEvent>(_loginButtonErrorEvent);
  }

  FutureOr<void> _signInLoginEvent(
      SignInLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      await event.mAuth.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  FutureOr<void> _loginButtonErrorEvent(
      LoginButtonErrorEvent event, Emitter<LoginState> emit) {
    emit(LoginErrorState(event.error));
  }
}
