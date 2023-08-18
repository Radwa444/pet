import 'package:get/get.dart';

class BottomItemSelectionController extends GetxController {
  var bottomBarSelectedItem = 0.obs;

  changePos(int pos) {
    bottomBarSelectedItem.value = pos;
    update();
  }
}
