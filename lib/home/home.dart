import 'package:algostudiotest/detail/detail.dart';
import 'package:algostudiotest/helper/view/loading.dart';
import 'package:algostudiotest/home/controller/image_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ignore: use_key_in_widget_constructors
ImageController controller = Get.put(ImageController());

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mim Generator'),
      ),
      body: EasyRefresh(
        enableControlFinishRefresh: false,
        enableControlFinishLoad: true,
        controller: controller.refreshController,
        header: ClassicalHeader(),
        onRefresh: () async {
          controller.readimage();
        },
        onLoad: () async {
          print('loaded');
        },
        child: HomeList(),
      ),
    );
  }
}

class HomeList extends StatelessWidget {
  const HomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return LoadingWidget().loadingHelper(context);
      }
      return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: controller.dataList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 300,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  GestureDetector(
                    child: SizedBox(
                      height: 80,
                      child: CachedNetworkImage(
                        imageUrl: controller.dataList[index].url,
                        height: 80,
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) => Shimmer.fromColors(
                            child: const Center(child: Text('Loading')),
                            baseColor: Colors.red,
                            highlightColor: Colors.yellow),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    onTap: () {
                      Get.to(DetailImage(controller.dataList[index].url));
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                ],
              ),
            );
          });
    });
  }
}
