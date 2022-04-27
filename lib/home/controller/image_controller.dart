import 'package:algostudiotest/home/model/image_model.dart';
import 'package:algostudiotest/service/image_service.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  var isLoading = true.obs;
  var dataList = <Meme>[].obs;
  EasyRefreshController refreshController = EasyRefreshController();

  @override
  void onInit() {
    readimage();
    super.onInit();
  }

  void readimage() async {
    isLoading(true);
    try {
      var todos = await ImageService.read();
      ImageModel respons = imageModelFromJson(todos);
      dataList.value = respons.data.memes;
    } catch (e) {
      Get.snackbar('Message', 'Gagal fetching data');
    } finally {
      isLoading(false);
    }
    update();
  }
}
