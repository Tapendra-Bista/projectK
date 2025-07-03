import 'package:get_storage/get_storage.dart';

class AppGetStorage {
  final box = GetStorage();


// --------------------for Location-----------------
  String getCity() {
    return box.read('newCity') ?? '';
  }

  void setCity(String value) {
    box.write('newCity', value);
  }

  String getCountry() {
    return box.read('newCountry')??'';
  }

  void setCountry(String value) {
    box.write('newCountry', value);
  }

  //------------------------- For language------------------
  String getLanguageCode() {
    return box.read('code') ?? 'fr';
  }

  void setLanguageCode(String value) {
    box.write('code', value);
  }

  bool hasOpenedApp() {
    return box.read('hasOpenedApp') ?? false;
  }

  void setHasOpenedApp() async {
    box.write('hasOpenedApp', true);
  }

  //------------------------- for the page number, which helps to retrieve the page the app was on when it was closed------------------
  int getPageNumber() {
    return box.read('pageNumber') ?? 0;
  }

  setPageNumber(int value) {
    box.write('pageNumber', value);
  }
}
