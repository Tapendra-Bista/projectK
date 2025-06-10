import 'package:afriqueen/features/archive/bloc/archive_bloc.dart';
import 'package:afriqueen/features/archive/bloc/archive_event.dart';
import 'package:afriqueen/features/archive/repository/archive_repository.dart';
import 'package:afriqueen/features/archive/screen/archive_screen.dart';
import 'package:afriqueen/features/block/bloc/block_bloc.dart';
import 'package:afriqueen/features/block/bloc/block_event.dart';
import 'package:afriqueen/features/block/repository/block_repository.dart';
import 'package:afriqueen/features/block/screen/block_screen.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/repository/chat_repository.dart';
import 'package:afriqueen/features/create_profile/bloc/create_profile_bloc.dart';
import 'package:afriqueen/features/create_profile/repository/create_profile_repository.dart';
import 'package:afriqueen/features/create_profile/screen/address_screen.dart';
import 'package:afriqueen/features/create_profile/screen/age_screen.dart';
import 'package:afriqueen/features/create_profile/screen/description_screen.dart';
import 'package:afriqueen/features/create_profile/screen/gender_screen.dart';
import 'package:afriqueen/features/create_profile/screen/interests_screen.dart';
import 'package:afriqueen/features/create_profile/screen/name_screen.dart';
import 'package:afriqueen/features/create_profile/screen/passion_screen.dart';
import 'package:afriqueen/features/create_profile/screen/upload_image_screen.dart';
import 'package:afriqueen/features/email_verification/bloc/email_verification_bloc.dart';
import 'package:afriqueen/features/email_verification/repository/email_verification_repository.dart';
import 'package:afriqueen/features/email_verification/screen/email_verification_screen.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_bloc.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_event.dart';
import 'package:afriqueen/features/favorite/repository/favorite_repository.dart';
import 'package:afriqueen/features/favorite/screen/favorite_screen.dart';
import 'package:afriqueen/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:afriqueen/features/forgot_password/repository/forgot_password_repository.dart';
import 'package:afriqueen/features/forgot_password/screen/email_sent_screen.dart';
import 'package:afriqueen/features/forgot_password/screen/forgot_password_screen.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_event.dart';
import 'package:afriqueen/features/home/repository/home_repository.dart';
import 'package:afriqueen/features/like/bloc/like_bloc.dart';
import 'package:afriqueen/features/like/bloc/like_event.dart';
import 'package:afriqueen/features/like/repository/like_repository.dart';
import 'package:afriqueen/features/login/bloc/login_bloc.dart';
import 'package:afriqueen/features/login/repository/login_repository.dart';
import 'package:afriqueen/features/login/screen/login_screen.dart';
import 'package:afriqueen/features/main/screen/main_screen.dart';
import 'package:afriqueen/features/profile/bloc/profile_bloc.dart';
import 'package:afriqueen/features/profile/bloc/profile_event.dart';
import 'package:afriqueen/features/profile/repository/profile_repository.dart';
import 'package:afriqueen/features/profile/screen/profile_screen.dart';
import 'package:afriqueen/features/setting/screen/setting_screen.dart';
import 'package:afriqueen/features/signup/bloc/signup_bloc.dart';
import 'package:afriqueen/features/signup/repository/signup_repository.dart';
import 'package:afriqueen/features/signup/screen/signup_screen.dart';
import 'package:afriqueen/features/signup/widgets/condition_of_use.dart';
import 'package:afriqueen/features/signup/widgets/privacy_and_policy.dart';
import 'package:afriqueen/features/stories/bloc/stories_bloc.dart';
import 'package:afriqueen/features/stories/bloc/stories_event.dart';
import 'package:afriqueen/features/stories/repository/stories_repository.dart';
import 'package:afriqueen/features/wellcome/bloc/wellcome_bloc.dart';
import 'package:afriqueen/features/wellcome/screen/wellcome_screen.dart';
import 'package:afriqueen/routes/app_routes.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:afriqueen/services/storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Group all your screen imports here for clarity
final AppGetStorage _appGetStorage = AppGetStorage();
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.signup:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => SignupBloc(
            signupRepository: getIt<SignupRepository>(),
          ),
          child: SignupScreen(),
        ),
      );

    case AppRoutes.privacyAndPolicy:
      return MaterialPageRoute(builder: (_) => PrivacyAndPolicy());

    case AppRoutes.conditionOfUse:
      return MaterialPageRoute(builder: (_) => ConditionOfUse());

    case AppRoutes.login:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => LoginBloc(
            loginrepository: getIt<LoginRepository>(),
          ),
          child: LoginScreen(),
        ),
      );

    case AppRoutes.forgotPassword:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => ForgotPasswordBloc(
            repo: getIt<ForgotPasswordRepository>(),
          ),
          child: ForgotPasswordScreen(),
        ),
      );

    case AppRoutes.emailSent:
      // Keep BlocProvider.value here as it explicitly reuses an existing bloc instance
      return MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<ForgotPasswordBloc>(context),
          child: EmailSentScreen(),
        ),
      );

    case AppRoutes.emailVerification:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => EmailVerificationBloc(
            repository: getIt<EmailVerificationRepository>(),
          ),
          child: EmailVerificationScreen(),
        ),
      );

    case AppRoutes.wellcome:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => WellcomeBloc(),
          child: WellcomeScreen(),
        ),
      );

    case AppRoutes.main:
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BlockBloc(
                repository: getIt<BlockRepository>(),
              )..add(BlockUsersFetched()),
            ),
            BlocProvider(
              create: (context) => ChatBloc(
                chatRepository: getIt<ChatRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => HomeBloc(
                repo: getIt<HomeRepository>(),
              )
                ..add(HomeUsersProfileList())
                ..add(HomeUsersFetched()),
            ),
            BlocProvider(
              create: (context) => StoriesBloc(
                repo: getIt<StoriesRepository>(),
              )..add(StoriesFetching()),
            ),
          ],
          child: MainScreen(),
        ),
      );

    case AppRoutes.name:
    case AppRoutes.gender:
    case AppRoutes.age:
    case AppRoutes.address:
    case AppRoutes.interests:
    case AppRoutes.passion:
    case AppRoutes.upload:
    case AppRoutes.description:
      // Consolidated routes for CreateProfileBloc
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => CreateProfileBloc(
            repository: getIt<CreateProfileRepository>(),
          ),
          child: _getCreateProfileScreen(settings.name!),
        ),
      );

    case AppRoutes.setting:
      return MaterialPageRoute(builder: (_) => SettingScreen());

    case AppRoutes.profile:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => ProfileBloc(
            repo: getIt<ProfileRepository>(),
          )..add(ProfileFetch()),
          child: ProfileScreen(),
        ),
      );

    case AppRoutes.favorite:
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FavoriteBloc(
                repository: getIt<FavoriteRepository>(),
              )..add(FavoriteUsersFetched()),
            ),
            BlocProvider(
              create: (context) => LikeBloc(
                repository: getIt<LikeRepository>(),
              )..add(LikeUsersFetched()),
            ),
          ],
          child: FavoriteScreen(),
        ),
      );

    case AppRoutes.archive:
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ArchiveBloc(
                repository: getIt<ArchiveRepository>(),
              )..add(ArchiveUsersFetched()),
            ),
            BlocProvider(
              create: (context) => LikeBloc(
                repository: getIt<LikeRepository>(),
              )..add(LikeUsersFetched()),
            ),
          ],
          child: ArchiveScreen(),
        ),
      );

    case AppRoutes.block:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => BlockBloc(
            repository: getIt<BlockRepository>(),
          )..add(BlockUsersFetched()),
          child: BlockScreen(),
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => WellcomeBloc(),
          child: WellcomeScreen(),
        ),
      );
  }
}

/// Helper function to return the correct screen for CreateProfile routes.
Widget _getCreateProfileScreen(String routeName) {
  switch (routeName) {
    case AppRoutes.name:
      return NameScreen();
    case AppRoutes.gender:
      return GenderScreen();
    case AppRoutes.age:
      return AgeScreen();
    case AppRoutes.address:
      return AddressScreen();
    case AppRoutes.interests:
      return InterestsScreen();
    case AppRoutes.passion:
      return PassionScreen();
    case AppRoutes.upload:
      return UploadImageScreen();
    case AppRoutes.description:
      return DescriptionScreen();
    default:
      return const Text('Error: Unknown Create Profile Screen');
  }
}

String? routeNameFromPageNumber() {
  switch (_appGetStorage.getPageNumber()) {
    case 1:
      return AppRoutes.emailVerification;
    case 2:
      return AppRoutes.name;
    case 3:
      return AppRoutes.gender;
    case 4:
      return AppRoutes.age;
    case 5:
      return AppRoutes.address;
    case 6:
      return AppRoutes.interests;
    case 7:
      return AppRoutes.passion;
    case 8:
      return AppRoutes.description;
    case 9:
      return AppRoutes.upload;
    default:
      return AppRoutes.main;
  }
}
