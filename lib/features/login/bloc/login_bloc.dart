import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/create_profile/repository/create_profile_repository.dart';
import 'package:afriqueen/features/login/bloc/login_event.dart';
import 'package:afriqueen/features/login/bloc/login_state.dart';
import 'package:afriqueen/features/login/models/login_model.dart';
import 'package:afriqueen/features/login/repository/login_repository.dart';
import 'package:afriqueen/services/storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;
  final CreateProfileRepository _createProfileRepository =
      CreateProfileRepository();
  bool _isPasswordHidden = true;
  final _app = AppGetStorage();
  LoginModel _loginModel = LoginModel(email: '', password: '');

  LoginBloc({required LoginRepository loginrepository})
      : _loginRepository = loginrepository,
        super(LoginInitial()) {
    //---------------------password visibility-----------------------------
    on<LoginPasswordVisibility>((
      LoginPasswordVisibility event,
      Emitter<LoginState> emit,
    ) {
      _isPasswordHidden = !_isPasswordHidden;
      emit(state.copyWith(isLoginPasswordVisible: _isPasswordHidden));
    });
    //------------------------track user input for email--------------------------
    on<LoginEmailChanged>((event, emit) {
      _loginModel = _loginModel.copyWith(email: event.email);
    });
    //------------------------track user input for password--------------------------
    on<LoginPasswordChanged>((event, emit) {
      _loginModel = _loginModel.copyWith(password: event.password);
    });

    //------------------------User pressed LoginButton--------------------------
    on<LoginSubmit>((event, emit) async {
      print("User Location ${event.country} and ${event.city}");
      emit(LoginLoading.fromState(state));

      UserCredential? userCredential = await _loginRepository.loginWithEmail(
        _loginModel,
      );

      if (userCredential != null) {
        await _createProfileRepository.updateLocation(
            event.city, event.country);

        emit(LoginSuccess.fromState(state));
      } else {
        emit(LoginError.fromState(state, error: _loginRepository.error!.tr));
      }
    });
    // -------------------google signing--------------------------------------
    on<GoogleSignInButtonClicked>((event, emit) async {
      emit(LoginLoading.fromState(state));
      UserCredential? userCredential = await _loginRepository.loginWithGoogle();

      if (userCredential != null) {
        bool isUserAvailable = await _loginRepository.isUserAvailable();
        if (isUserAvailable == false) {
      await _createProfileRepository.updateLocation(
            event.city, event.country);
          _app.setPageNumber(2);
          emit(GoogleLoginNewUser.fromState(state));
        } else if (isUserAvailable == true) {
      await _createProfileRepository.updateLocation(
            event.city, event.country);
          emit(GoogleLoginOldUser.fromState(state));
        } else {
          emit(
            GoogleLoginError.fromState(
              state,
              error: EnumLocale.defaultError.name.tr,
            ),
          );
        }
      } else {
        
        emit(
          GoogleLoginError.fromState(state, error: _loginRepository.error!.tr),
        );
      }
    });
  }
}
