import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:pet_shop/woocommerce/model/customer.dart';

String keyNightMode = "keyIsNightMode";
String keyIntroAvailable = "keyIsIntroAvailable";
String keyLoggedIn = "keyIsLoggedIn";
String keyIsFirst = "keyIsFirst";
String keyCurrentUser = "keyCurrentUser";
String keySearchHistory = "keyUserSearchHistory";
String keyWishlistProducts = "keyWishlistProducts";

void setData(String key, dynamic value) => GetStorage().write(key, value);

int? getInt(String key) => GetStorage().read(key);

String? getString(String key) => GetStorage().read(key);

bool? getBool(String key) => GetStorage().read(key);

double? getDouble(String key) => GetStorage().read(key);

dynamic getData(String key) => GetStorage().read(key);

void clearData() async => GetStorage().erase();

void clearKey(String key) async => GetStorage().remove(key);

void changeTheme(bool val) => setData(keyNightMode, val);

void changeIntroVal(bool val) => setData(keyIntroAvailable, val);

void setLoggedIn(bool val) => setData(keyLoggedIn, val);

void setIsFirst(bool val) => setData(keyIsFirst, val);

void setCurrentUser(WooCustomer? val) =>
    setData(keyCurrentUser, jsonEncode(val));

bool get isDark => getBool(keyNightMode) ?? false;

bool get isIntroAvailable => getBool(keyIntroAvailable) ?? true;

bool get isLoggedIn => getBool(keyLoggedIn) ?? false;

bool get isFirst => getBool(keyIsFirst) ?? true;

WooCustomer? get getCurrentCustomer {
  dynamic getVal = getString(keyCurrentUser);
  print("gevak000-_$getVal");
  if (getVal != null) {
    return WooCustomer.fromJson(json.decode(getVal));
  }
  return getVal;
}
