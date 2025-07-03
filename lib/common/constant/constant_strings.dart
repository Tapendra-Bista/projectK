// ---------------------Contstant Strings----------------

import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:get/get.dart';

class AppStrings {
  //---------------  image  path strings-------------------
  static const String logoImage = 'assets/images/logo.png';
  static const String googleLogo = 'assets/images/google_logo.svg';
  static const String email = 'assets/images/email.json';
  static const String emailVerifed = 'assets/images/email_verifed.json';
  static const String couple = 'assets/images/couple.png';
  static const String us = 'assets/images/country/us.png';
  static const String fr = 'assets/images/country/fr.png';
  static const String uploadImage = 'assets/images/upload_image.json';
  //---------------- fonts  path strings-------------------------

  static const String robotoLight = 'assets/fonts/Roboto-Light.ttf';
  static const String robotosSemiBold = 'assets/fonts/Roboto-SemiBold.ttf';
  static const String robotThin = 'assets/fonts/Roboto-Thin.ttf';

  //-----------------User interests -----------------------------
  static Map<String, List<String>> categorizedUserInterests = {
    "Friendship": [
      EnumLocale.chatting.name.tr,
      EnumLocale.makingNewFriends.name.tr,
      EnumLocale.studyBuddy.name.tr,
      EnumLocale.movieNights.name.tr,
      EnumLocale.coffeeHangouts.name.tr,
    ],
    "Love & Romance": [
      EnumLocale.romanticDates.name.tr,
      EnumLocale.candlelight.name.tr,
      EnumLocale.sweet.name.tr,
      EnumLocale.slowDancing.name.tr,
      EnumLocale.loveLetters.name.tr,
    ],
    "Sports & Outdoors": [
      EnumLocale.football.name.tr,
      EnumLocale.yoga.name.tr,
      EnumLocale.hiking.name.tr,
      EnumLocale.running.name.tr,
      EnumLocale.cycling.name.tr,
    ],
    "Food & Restaurants": [
      EnumLocale.foodie.name.tr,
      EnumLocale.streetFood.name.tr,
      EnumLocale.fineDining.name.tr,
      EnumLocale.coffeeLover.name.tr,
      EnumLocale.baking.name.tr,
    ],
    "Adventure & Travel": [
      EnumLocale.backpacking.name.tr,
      EnumLocale.roadTrips.name.tr,
      EnumLocale.soloTravel.name.tr,
      EnumLocale.camping.name.tr,
      EnumLocale.cityBreaks.name.tr,
    ],
  };

  static List<String> passion = [
    EnumLocale.music.name.tr,
    EnumLocale.creativity.name.tr,
    EnumLocale.fitness.name.tr,
    EnumLocale.travel.name.tr,
    EnumLocale.fashion.name.tr,
  ];

  static const List<String> language = ["English", "Français"];
  static const List<String> flag = [
    'assets/images/country/us.png',
    'assets/images/country/fr.png'
  ];
  static const cloudName = "dwzriczge";
  static const uploadPreset = "afrikhc9o0";

  //-----guideline violation  list-------
  static List<String> guidelineViolationList = [
    EnumLocale.underAge.name.tr,
    EnumLocale.depictionOfViolation.name.tr,
    EnumLocale.incorrectProfileDetails.name.tr,
    EnumLocale.abusiveOrIntrusiveBehavior.name.tr,
    EnumLocale.sexualContent.name.tr,
    EnumLocale.spamOrAdvertising.name.tr,
    EnumLocale.dubiousOffers.name.tr,
    EnumLocale.drugs.name.tr,
    EnumLocale.someoneIsInDanger.name.tr,
  ];

  //------------- illegel content-------------
  static List<String> illegalContentList = [
    EnumLocale.invasionOfPrivacy.name.tr,
    EnumLocale.attemptedFraud.name.tr,
    EnumLocale.threadsOrMalliciousStatements.name.tr,
    EnumLocale.sexualHarassment.name.tr,
    EnumLocale.childrenAreAtRisk.name.tr,
    EnumLocale.drugTrafficking.name.tr,
    EnumLocale.racismOrTerrorism.name.tr,
    EnumLocale.blackmail.name.tr,
    EnumLocale.deprivationOfLiberty.name.tr
  ];

  static List<String> reelsFilterItems = [
    EnumLocale.archive.name.tr,
    EnumLocale.Favorite.name.tr,
    EnumLocale.following.name.tr,
  ];
}
