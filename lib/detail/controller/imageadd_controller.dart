import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageAddController extends GetxController {
  var top = 0.obs;
  var bottom = 0.obs;
  var left = 0.obs;
  var right = 0.obs;
  var width = 50.obs;
  var height = 50.obs;
  ImagePicker picker = ImagePicker();
  var imagepath = "".obs;
  TextEditingController widthcontroller = TextEditingController();
  TextEditingController heightcontroller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void changePosition(x, y) {
    top.value = y.toInt();
    left.value = x.toInt();
    update();
  }

  void getFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    var address = image!.path;
    imagepath.value = address;
  }

  void reset() {
    imagepath.value = "";
  }

  void resize(width2, height2) {
    width.value = int.parse(width2);
    height.value = int.parse(height2);
  }
}
