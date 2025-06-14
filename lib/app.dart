import 'package:afriqueen/common/localization/translations/app_translations.dart';
import 'package:afriqueen/common/theme/app_theme.dart';
import 'package:afriqueen/features/archive/bloc/archive_bloc.dart';
import 'package:afriqueen/features/archive/bloc/archive_event.dart';
import 'package:afriqueen/features/block/bloc/block_bloc.dart';
import 'package:afriqueen/features/block/bloc/block_event.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/bloc/chat_event.dart';
import 'package:afriqueen/features/create_profile/bloc/create_profile_bloc.dart';
import 'package:afriqueen/features/email_verification/bloc/email_verification_bloc.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_bloc.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_event.dart';
import 'package:afriqueen/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_event.dart';
import 'package:afriqueen/features/like/bloc/like_bloc.dart';
import 'package:afriqueen/features/like/bloc/like_event.dart';
import 'package:afriqueen/features/login/bloc/login_bloc.dart';
import 'package:afriqueen/features/login/screen/login_screen.dart';
import 'package:afriqueen/features/profile/bloc/profile_bloc.dart';
import 'package:afriqueen/features/profile/bloc/profile_event.dart';
import 'package:afriqueen/features/report/bloc/report_bloc.dart';
import 'package:afriqueen/features/signup/bloc/signup_bloc.dart';
import 'package:afriqueen/features/stories/bloc/stories_bloc.dart';
import 'package:afriqueen/features/stories/bloc/stories_event.dart';
import 'package:afriqueen/features/wellcome/bloc/wellcome_bloc.dart';
import 'package:afriqueen/features/wellcome/screen/wellcome_screen.dart';
import 'package:afriqueen/routes/app_pages.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:afriqueen/services/status/bloc/status_bloc.dart';
import 'package:afriqueen/services/storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppGetStorage _appGetStorage = AppGetStorage();
  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //---------------------Bloc  Provider -------------------------------------------------
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
        BlocProvider<EmailVerificationBloc>.value(
          value: getIt<EmailVerificationBloc>(),
        ),

        BlocProvider<BlockBloc>.value(
          value: getIt<BlockBloc>()..add(BlockUsersFetched()),
        ),
        BlocProvider<ChatBloc>.value(
          value: getIt<ChatBloc>()..add(ChatRoomsLists(id: _currentUserId)),
        ),

        BlocProvider<StoriesBloc>.value(
            value: getIt<StoriesBloc>()..add(StoriesFetching())),

        BlocProvider<CreateProfileBloc>.value(
          value: getIt<CreateProfileBloc>(),
        ),

        BlocProvider<ProfileBloc>.value(
            value: getIt<ProfileBloc>()..add(ProfileFetch())),

        BlocProvider<FavoriteBloc>.value(
            value: getIt<FavoriteBloc>()..add(FavoriteUsersFetched())),
        BlocProvider<LikeBloc>.value(
            value: getIt<LikeBloc>()..add(LikeUsersFetched())),

        BlocProvider<ArchiveBloc>.value(
            value: getIt<ArchiveBloc>()..add(ArchiveUsersFetched())),

        BlocProvider<StatusBloc>.value(value: getIt<StatusBloc>()),

        BlocProvider<HomeBloc>.value(
            value: getIt<HomeBloc>()
              ..add(HomeUsersFetched())
              ..add(HomeUsersProfileList())),

        BlocProvider<ReportBloc>.value(
          value: getIt<ReportBloc>(),
        )
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
                return const Scaffold(); // or splash screen
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
