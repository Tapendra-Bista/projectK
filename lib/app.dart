import 'package:afriqueen/common/localization/translations/app_translations.dart';
import 'package:afriqueen/common/theme/app_theme.dart';
import 'package:afriqueen/features/add/bloc/add_bloc.dart';
import 'package:afriqueen/features/archive/bloc/archive_bloc.dart';
import 'package:afriqueen/features/block/bloc/block_bloc.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/create_profile/bloc/create_profile_bloc.dart';
import 'package:afriqueen/features/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_bloc.dart';
import 'package:afriqueen/features/follow/bloc/follow_bloc.dart';
import 'package:afriqueen/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/like/bloc/like_bloc.dart';
import 'package:afriqueen/features/login/bloc/login_bloc.dart';
import 'package:afriqueen/features/login/screen/login_screen.dart';
import 'package:afriqueen/features/messages_requests/bloc/request_receiver_bloc.dart';
import 'package:afriqueen/features/messages_requests/bloc/request_sender_bloc.dart';
import 'package:afriqueen/features/preferences/bloc/preferences_bloc.dart';
import 'package:afriqueen/features/profile/bloc/profile_bloc.dart';
import 'package:afriqueen/features/reel_like/bloc/reel_like_bloc.dart';
import 'package:afriqueen/features/reels/bloc/reel_bloc.dart';
import 'package:afriqueen/features/report/bloc/report_bloc.dart';
import 'package:afriqueen/features/setting/bloc/setting_bloc.dart';
import 'package:afriqueen/features/signup/bloc/signup_bloc.dart';
import 'package:afriqueen/features/stories/bloc/stories_bloc.dart';
import 'package:afriqueen/features/wellcome/bloc/wellcome_bloc.dart';
import 'package:afriqueen/features/wellcome/screen/wellcome_screen.dart';
import 'package:afriqueen/routes/app_pages.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:afriqueen/services/status/bloc/status_bloc.dart';
import 'package:afriqueen/services/storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppGetStorage _appGetStorage = AppGetStorage();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //---------------------Bloc  Provider ----------------------------
        BlocProvider<WellcomeBloc>.value(
          value: getIt<WellcomeBloc>(),
        ),
        BlocProvider<SignupBloc>.value(
          value: getIt<SignupBloc>(),
        ),

        BlocProvider<LoginBloc>.value(
          value: getIt<LoginBloc>(),
        ),
        BlocProvider<ForgotPasswordBloc>.value(
          value: getIt<ForgotPasswordBloc>(),
        ),

        BlocProvider<BlockBloc>.value(
          value: getIt<BlockBloc>(),
        ),
        BlocProvider<ChatBloc>.value(
          value: getIt<ChatBloc>(),
        ),

        BlocProvider<StoriesBloc>.value(value: getIt<StoriesBloc>()),
        BlocProvider<CreateProfileBloc>.value(
          value: getIt<CreateProfileBloc>(),
        ),
        BlocProvider<ProfileBloc>.value(value: getIt<ProfileBloc>()),
        BlocProvider<FavoriteBloc>.value(value: getIt<FavoriteBloc>()),
        BlocProvider<LikeBloc>.value(value: getIt<LikeBloc>()),
        BlocProvider<FollowBloc>.value(value: getIt<FollowBloc>()),
        BlocProvider<ArchiveBloc>.value(value: getIt<ArchiveBloc>()),
        BlocProvider<StatusBloc>.value(value: getIt<StatusBloc>()),
        BlocProvider<HomeBloc>.value(value: getIt<HomeBloc>()),
        BlocProvider<ReportBloc>.value(
          value: getIt<ReportBloc>(),
        ),
        BlocProvider<PreferencesBloc>.value(value: getIt<PreferencesBloc>()),
        BlocProvider<ReelLikeBloc>.value(value: getIt<ReelLikeBloc>()),
        BlocProvider<ReelBloc>.value(value: getIt<ReelBloc>()),
        BlocProvider<AddBloc>.value(
          value: getIt<AddBloc>(),
        ),

        BlocProvider<RequestSenderBloc>.value(
          value: getIt<RequestSenderBloc>(),
        ),
        BlocProvider<RequestReceiverBloc>.value(
          value: getIt<RequestReceiverBloc>(),
        ),
        BlocProvider<EditProfileBloc>.value(
          value: getIt<EditProfileBloc>(),
        ),
        BlocProvider<SettingBloc>.value(
          value: getIt<SettingBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => GetMaterialApp(
          title: 'Afriqueen',
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          locale: Locale(_appGetStorage.getLanguageCode()),
          theme: lightTheme,
          defaultTransition: Transition.fade,
          onGenerateRoute: onGenerateRoute,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const PlatformScaffold(); // or splash screen
              } else if (snapshot.hasData) {
                return routeNameFromPageNumber();
              }
              return _appGetStorage.hasOpenedApp()
                  ? LoginScreen()
                  : WellcomeScreen();
            },
          ),
        ),
      ),
    );
  }
}
