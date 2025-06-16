import 'package:afriqueen/features/archive/bloc/archive_bloc.dart';
import 'package:afriqueen/features/archive/repository/archive_repository.dart';
import 'package:afriqueen/features/block/bloc/block_bloc.dart';
import 'package:afriqueen/features/block/repository/block_repository.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/repository/chat_repository.dart';
import 'package:afriqueen/features/create_profile/bloc/create_profile_bloc.dart';
import 'package:afriqueen/features/create_profile/repository/create_profile_repository.dart';
import 'package:afriqueen/features/email_verification/bloc/email_verification_bloc.dart';
import 'package:afriqueen/features/email_verification/repository/email_verification_repository.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_bloc.dart';
import 'package:afriqueen/features/favorite/repository/favorite_repository.dart';
import 'package:afriqueen/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:afriqueen/features/forgot_password/repository/forgot_password_repository.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/repository/home_repository.dart';
import 'package:afriqueen/features/like/bloc/like_bloc.dart';
import 'package:afriqueen/features/like/repository/like_repository.dart';
import 'package:afriqueen/features/login/bloc/login_bloc.dart';
import 'package:afriqueen/features/login/repository/login_repository.dart';
import 'package:afriqueen/features/preferences/bloc/preferences_bloc.dart';
import 'package:afriqueen/features/profile/bloc/profile_bloc.dart';
import 'package:afriqueen/features/profile/repository/profile_repository.dart';
import 'package:afriqueen/features/report/bloc/report_bloc.dart';
import 'package:afriqueen/features/signup/bloc/signup_bloc.dart';
import 'package:afriqueen/features/signup/repository/signup_repository.dart';
import 'package:afriqueen/features/stories/bloc/stories_bloc.dart';
import 'package:afriqueen/features/stories/repository/stories_repository.dart';
import 'package:afriqueen/features/wellcome/bloc/wellcome_bloc.dart';
import 'package:afriqueen/services/status/bloc/status_bloc.dart';
import 'package:afriqueen/services/status/repository/status_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // //----------Repository---------------------------
  getIt.registerLazySingleton<SignupRepository>(() => SignupRepository());
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepository());
  getIt.registerLazySingleton<ForgotPasswordRepository>(
      () => ForgotPasswordRepository());
  getIt.registerLazySingleton<EmailVerificationRepository>(
      () => EmailVerificationRepository());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepository());
  getIt.registerLazySingleton<BlockRepository>(() => BlockRepository());
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepository());
  getIt.registerLazySingleton<StoriesRepository>(() => StoriesRepository());
  getIt.registerLazySingleton<CreateProfileRepository>(
      () => CreateProfileRepository());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
  getIt.registerLazySingleton<FavoriteRepository>(() => FavoriteRepository());
  getIt.registerLazySingleton<LikeRepository>(() => LikeRepository());
  getIt.registerLazySingleton<ArchiveRepository>(() => ArchiveRepository());
  getIt.registerLazySingleton<StatusRepository>(() => StatusRepository());

  //---------------------Bloc-------------------------------------------------
  getIt.registerLazySingleton<SignupBloc>(
      () => SignupBloc(signupRepository: getIt<SignupRepository>()));
  getIt.registerLazySingleton<LoginBloc>(
      () => LoginBloc(loginrepository: getIt<LoginRepository>()));
  getIt.registerLazySingleton<ForgotPasswordBloc>(
      () => ForgotPasswordBloc(repo: getIt<ForgotPasswordRepository>()));
  getIt.registerLazySingleton<EmailVerificationBloc>(() =>
      EmailVerificationBloc(repository: getIt<EmailVerificationRepository>()));

  getIt.registerLazySingleton<BlockBloc>(
      () => BlockBloc(repository: getIt<BlockRepository>()));
  getIt.registerLazySingleton<ChatBloc>(
      () => ChatBloc(chatRepository: getIt<ChatRepository>()));
  getIt.registerLazySingleton<StoriesBloc>(
      () => StoriesBloc(repo: getIt<StoriesRepository>()));
  getIt.registerLazySingleton<CreateProfileBloc>(
      () => CreateProfileBloc(repository: getIt<CreateProfileRepository>()));
  getIt.registerLazySingleton<ProfileBloc>(
      () => ProfileBloc(repo: getIt<ProfileRepository>()));
  getIt.registerLazySingleton<FavoriteBloc>(
      () => FavoriteBloc(repository: getIt<FavoriteRepository>()));
  getIt.registerLazySingleton<LikeBloc>(
      () => LikeBloc(repository: getIt<LikeRepository>()));
  getIt.registerLazySingleton<ArchiveBloc>(
      () => ArchiveBloc(repository: getIt<ArchiveRepository>()));
  getIt.registerLazySingleton<StatusBloc>(
      () => StatusBloc(statusrepository: getIt<StatusRepository>()));
  getIt.registerLazySingleton<HomeBloc>(
      () => HomeBloc(repo: getIt<HomeRepository>()));
  getIt.registerLazySingleton<ReportBloc>(() => ReportBloc());

  getIt.registerLazySingleton<WellcomeBloc>(() => WellcomeBloc());
  getIt.registerLazySingleton<PreferencesBloc>(() => PreferencesBloc());
}
