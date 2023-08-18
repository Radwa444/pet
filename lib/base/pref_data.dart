import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String favouriteList = "productFav";

  Future<List<String>> getFavouriteList() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    List<String>? value = prefs.getStringList(favouriteList);
    return value ?? [];
  }

  setFavouriteList(List<String> sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(favouriteList, sizes);
  }
}
