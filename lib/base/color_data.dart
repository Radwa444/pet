import 'package:flutter/material.dart';

Color primaryColor = "#58B694".toColor();
Color defBgColor = "#FCE8E2".toColor();
// Color purpleColor = "#5E57FF".toColor();
Color backgroundColor = "#0F172A".toColor();
Color fontPrimary = ("#2A190D".toColor()).withOpacity(0.9);

Color accentColor = "#58B694".toColor();
Color lightAccentColor = "#CFF2E5".toColor();
Color black20 = "#DFDFDF".toColor();
Color black40 = "#3C3F3E".toColor();
Color dividerColor = "#F4F4F4".toColor();
Color cardColor = "#FFFBF8".toColor();
Color redColor = "#FB1F1F".toColor();

Color lightRedColor = "#FCF0F0".toColor();

// Color lightAccentColor = "#D9EEF9".toColor();
Color greyFont = "#616161".toColor();
Color greenColor = "#1AA138".toColor();

Color indicatorColor = "#F9F9F9".toColor();
Color itemGreyColor = "#E8E6E5".toColor();
Color orangeColor = "#FF8F27".toColor();
Color appBarColor = "#FEE3E4".toColor();

Color redFontColor = "#F44144".toColor();
Color redBgColor = "#FFE9E9".toColor();
Color yellowBgColor = "#FFF2D3".toColor();
Color unAvailableColor = "#E6E6E6".toColor();
Color slotSelectedColor = "#FFB4B4".toColor();
Color darkGreyColor = "#2D2D2D".toColor();
Color unRatedColor = "#FBEAC0".toColor();
Color ratedColor = "#FFC32B".toColor();

Color shadowColor = Colors.black12;
Color greyIconColor = "#BEC4D3".toColor();

getFontColor(BuildContext context) {
  return getCurrentTheme(context).textTheme.titleMedium!.color;
}

getFontBlackColor(BuildContext context) {
  return getCurrentTheme(context).textTheme.titleLarge!.color;
}

getDividerColor(BuildContext context) {
  return getCurrentTheme(context).dividerColor;
}

getFontGreyColor(BuildContext context) {
  return getCurrentTheme(context).textTheme.titleSmall!.color;
}

getCardColor(BuildContext context) {
  return getCurrentTheme(context).cardColor;
}

getGreyCardColor(BuildContext context) {
  return getCurrentTheme(context).indicatorColor;
}

getScaffoldColor(BuildContext context) {
  return getCurrentTheme(context).scaffoldBackgroundColor;
}

ThemeData getLightThemeData() {
  return ThemeData(
      scaffoldBackgroundColor: "#FAFAFA".toColor(),
      hintColor: "#A5A4AA".toColor(),
      indicatorColor: "#F9F9F9".toColor(),
      dividerColor: "#F1F1F1".toColor(),
      textTheme: TextTheme(
        titleMedium: TextStyle(color: "#000000".toColor()),
        titleSmall: TextStyle(color: "#545454".toColor()),
        titleLarge: TextStyle(color: "#000000".toColor()),
        // caption: TextStyle(color: "#7C7C7C".toColor())
      ),
      backgroundColor: "#E5E5E5".toColor(),
      hoverColor: "#F7F7FF".toColor(),
      cardColor: "#FFFFFF".toColor(),
      selectedRowColor: "#FFFFFF".toColor(),
      dialogBackgroundColor: "#FFFFFF".toColor(),
      unselectedWidgetColor: "#B9C1D3".toColor(),
      // focusColor: "#DEDEDE".toColor(),
      dividerTheme: DividerThemeData(color: "#DFDFDF".toColor()),
      focusColor: Colors.transparent,
      disabledColor: "#525E7B".toColor(),
      canvasColor: "#F7F8FB".toColor(),
      shadowColor: const Color.fromRGBO(131, 157, 216, 0.11999999731779099),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor));
}

ThemeData getDarkThemeData() {
  return ThemeData(
      scaffoldBackgroundColor: "#161E2D".toColor(),
      hintColor: "#A5A4AA".toColor(),
      indicatorColor: "#F9F9F9".toColor(),
      dividerColor: "#F1F1F1".toColor(),
      backgroundColor: "#161E2D".toColor(),
      hoverColor: "#21F6F7FF".toColor(),
      dialogBackgroundColor: "#283048".toColor(),
      selectedRowColor: "#5E57FF".toColor(),
      // focusColor: "#525E7B".toColor(),
      focusColor: Colors.transparent,
      dividerTheme: DividerThemeData(color: "#DFDFDF".toColor()),
      unselectedWidgetColor: "#525E7B".toColor(),
      cardColor: "#2D354F".toColor(),
      canvasColor: "#525E7B".toColor(),
      disabledColor: "#FFFFFF".toColor(),
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.4699999988079071),
      textTheme: TextTheme(
        titleMedium: TextStyle(color: "#FFFFFF".toColor()),
        titleSmall: TextStyle(color: "#A6ADBE".toColor()),
        titleLarge: TextStyle(color: "#FFFFFF".toColor()),
        // caption: TextStyle(color: "#7C7C7C".toColor())
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor));
}

Color getAccentColor(BuildContext context) {
  return getCurrentTheme(context).colorScheme.secondary;
}

// getFontSkip(BuildContext context) {
//   return getCurrentTheme(context).textTheme.titleSmall!.color;
// }

getFontHint(BuildContext context) {
  return getCurrentTheme(context).hintColor;
}

ThemeData getCurrentTheme(BuildContext context) {
  return Theme.of(context);
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
