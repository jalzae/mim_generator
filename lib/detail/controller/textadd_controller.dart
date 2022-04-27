import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TextAddController extends GetxController {
  var top = 0.obs;
  var bottom = 0.obs;
  var left = 0.obs;
  var right = 0.obs;
  var textit = "".obs;

  TextEditingController texting = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void changePosition(x, y) {
    top.value = y.toInt();
    left.value = x.toInt();
  }

  void resetPosition() {
    top.value = 0;
    left.value = 0;
    textit.value = "";
  }

  void removeText() {
    textit.value = "";
  }

  void changeText(val) {
    textit.value = val;
    texting.text = "";
  }
}
