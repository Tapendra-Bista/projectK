//----------------PlatformAppBar Title-----------------------
import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/constant/constant_strings.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/divider.dart';
import 'package:afriqueen/common/widgets/loading.dart';
import 'package:afriqueen/features/setting/bloc/setting_bloc.dart';
import 'package:afriqueen/routes/app_routes.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:afriqueen/services/storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class FavoritesListTile extends StatelessWidget {
  const FavoritesListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () => Get.toNamed(AppRoutes.favorite),
      trailing: SizedBox(
          width: 50.w,
          child: Icon(
            CupertinoIcons.forward,
          )),
      leading: Icon(HugeIcons.strokeRoundedFavouriteSquare),
      title: SizedBox(
        width: 50.w,
        child: Text(
          EnumLocale.favorites.name.tr,
          style: theme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

//-------------------Archive user-----------------------
class ArchiveListTile extends StatelessWidget {
  const ArchiveListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () => Get.toNamed(AppRoutes.archive),
      trailing: SizedBox(width: 50.w, child: Icon(CupertinoIcons.forward)),
      leading: Icon(HugeIcons.strokeRoundedArchive),
      title: Text(
        EnumLocale.archive.name.tr,
        style: theme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

//-------------------Blocked user-----------------------
class BlockedListTile extends StatelessWidget {
  const BlockedListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () => Get.toNamed(AppRoutes.block),
      trailing: SizedBox(width: 50.w, child: Icon(CupertinoIcons.forward)),
      leading: Icon(HugeIcons.strokeRoundedBlocked),
      title: Text(
        EnumLocale.blocked.name.tr,
        style: theme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

//-----------App Bar--------------------------
class SettingPlatformAppBar extends StatelessWidget {
  const SettingPlatformAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: PlatformIconButton(
        onPressed: () => Get.back(),
        icon: Icon(HugeIcons.strokeRoundedMultiplicationSign),
      ),
      title: SettingTitle(),
      centerTitle: true,
    );
  }
}

//----------------Title Text------------------------
class SettingTitle extends StatelessWidget {
  const SettingTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Text(
      EnumLocale.settings.name.tr,
      style: theme.bodyLarge!.copyWith(fontSize: 18.sp),
      overflow: TextOverflow.ellipsis,
    );
  }
}

//-----------------Change Language--------------------
class LanguageListTile extends StatefulWidget {
  LanguageListTile({super.key});

  @override
  State<LanguageListTile> createState() => _LanguageListTileState();
}

class _LanguageListTileState extends State<LanguageListTile> {
  final app = AppGetStorage();

  bool englishLanBool = false;

  bool franceBool = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () => showPlatformModalSheet(
          material:
              MaterialModalSheetData(backgroundColor: AppColors.transparent),
          context: context,
          builder: (context) => Padding(
                padding: EdgeInsets.all(14.r),
                child: Material(
                  borderRadius: BorderRadius.circular(18.r),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () async {
                          getIt<SettingBloc>().add(SetToEnglish());
                          await Get.updateLocale(Locale('en'));
                          app.setLanguageCode('en');

                          print("Language is set to  english ");

                          Get.back();
                        },
                        leading: Image.asset(
                          AppStrings.flag[0],
                          height: 40.h,
                          width: 40.w,
                        ),
                        title: Text(
                          AppStrings.language[0],
                          style: theme.bodyMedium,
                        ),
                        trailing: BlocSelector<SettingBloc, SettingState, bool>(
                          selector: (state) =>
                              (state is GetEnglish) ? true : false,
                          builder: (context, value) {
                            return value
                                ? SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                : SizedBox.shrink();
                          },
                        ),
                      ),
                      CustomDivider(),
                      ListTile(
                        onTap: () async {
                          getIt<SettingBloc>().add(SetToFrance());
                          await Get.updateLocale(Locale('fr'));

                          print("Language is set to  French");
                          app.setLanguageCode('fr');

                          Get.back();
                        },
                        leading: Image.asset(
                          AppStrings.flag[1],
                          height: 40.h,
                          width: 40.w,
                        ),
                        title: Text(
                          AppStrings.language[1],
                          style: theme.bodyMedium,
                        ),
                        trailing: BlocSelector<SettingBloc, SettingState, bool>(
                          selector: (state) =>
                              (state is GetFrance) ? true : false,
                          builder: (context, value) {
                            return value
                                ? SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                : SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )),
      trailing: SizedBox(width: 50.w, child: Icon(CupertinoIcons.forward)),
      leading: Icon(HugeIcons.strokeRoundedLanguageSquare),
      title: Text(
        EnumLocale.changeLanguage.name.tr,
        style: theme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

//-------------------Help center-----------------------
class HelpListTile extends StatelessWidget {
  const HelpListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () {},
      trailing: SizedBox(width: 50.w, child: Icon(CupertinoIcons.forward)),
      leading: Icon(HugeIcons.strokeRoundedHelpSquare),
      title: Text(
        EnumLocale.helpCenter.name.tr,
        style: theme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

//------------------Privacy Settings------------------------------
class PrivacyListTile extends StatelessWidget {
  const PrivacyListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () {},
      trailing: SizedBox(width: 50.w, child: Icon(CupertinoIcons.forward)),
      leading: Icon(HugeIcons.strokeRoundedLocked),
      title: Text(
        EnumLocale.privacySettings.name.tr,
        style: theme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

//----------------------Notification ----------------------------
class NotificationListTile extends StatelessWidget {
  const NotificationListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () {},
      trailing: SizedBox(width: 50.w, child: Icon(CupertinoIcons.forward)),
      leading: Icon(HugeIcons.strokeRoundedNotification01),
      title: Text(
        EnumLocale.notifications.name.tr,
        style: theme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

//---------------------Logout-------------------------
class LogoutListTile extends StatelessWidget {
  const LogoutListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListTile(
      leading: Icon(HugeIcons.strokeRoundedLogoutSquare02),
      title: Text(
        EnumLocale.logout.name.tr,
        style: theme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () async {
        final BuildContext currentContext = context;
        await FirebaseAuth.instance.signOut();

        if (!currentContext.mounted) return;
        customLoading(context);
        await Future.delayed(Duration(milliseconds: 1500));
        Get.toNamed(AppRoutes.login);
      },
      trailing: SizedBox(width: 50.w, child: Icon(CupertinoIcons.forward)),
    );
  }
}
