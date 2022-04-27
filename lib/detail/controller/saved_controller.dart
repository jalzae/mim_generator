import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:algostudiotest/saving/saving.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class SavedController extends GetxController {
  ScreenshotController? clipit;
  GlobalKey src = GlobalKey();
  var isFrame = 1.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future saveImage(Uint8List bytes) async {
    var directory = await getApplicationDocumentsDirectory();
    var imagePath = await File('${directory.path}/image.png').create();
    var img = await imagePath.writeAsBytes(bytes);

    Get.off(SavingMain(img));
  }

  void saveIt() async {}

  void changeStatus(val) {
    isFrame.value = val;
  }
}
