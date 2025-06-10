import 'package:afriqueen/features/archive/repository/archive_repository.dart';
import 'package:afriqueen/features/block/repository/block_repository.dart';
import 'package:afriqueen/features/chat/repository/chat_repository.dart';
import 'package:afriqueen/features/create_profile/repository/create_profile_repository.dart';
import 'package:afriqueen/features/email_verification/repository/email_verification_repository.dart';
import 'package:afriqueen/features/favorite/repository/favorite_repository.dart';
import 'package:afriqueen/features/forgot_password/repository/forgot_password_repository.dart';
import 'package:afriqueen/features/home/repository/home_repository.dart';
import 'package:afriqueen/features/like/repository/like_repository.dart';
import 'package:afriqueen/features/login/repository/login_repository.dart';
import 'package:afriqueen/features/profile/repository/profile_repository.dart';
import 'package:afriqueen/features/signup/repository/signup_repository.dart';
import 'package:afriqueen/features/stories/repository/stories_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
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
}
