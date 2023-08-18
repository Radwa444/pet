import 'package:get/get.dart';

class ShippingAddressController extends GetxController {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";

  changeCountry(String con) {
    countryValue = con;
    update();
  }

  changeState(String con) {
    stateValue = con;
    update();
  }

  changeCity(String con) {
    cityValue = con;
    update();
  }
}
