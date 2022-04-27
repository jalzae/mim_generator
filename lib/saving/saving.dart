import 'dart:io';

import 'package:algostudiotest/share/share.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class SavingMain extends StatelessWidget {
  File pic;
  SavingMain(this.pic, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mim Generator'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black),
        ),
        body: Center(
          child: SizedBox(
            width: double.infinity,
            child: Image.file(File(pic.path)),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
            width: double.infinity,
            height: 80,
            decoration: const BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(color: Colors.grey, width: 0.5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton.icon(
                            label: const Text('Simpan'),
                            onPressed: () async {
                              final directory =
                                  await getExternalStorageDirectory();
                              final myImagePath = '${directory!.path}/MyImages';
                              final myImgDir =
                                  await Directory(myImagePath).create();
                              var image =
                                  await File('$myImagePath/image.jpg').create();
                              Get.snackbar("Message",
                                  "Image stored in folder /MyImages");
                            },
                            icon: const Icon(Icons.save)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton.icon(
                            label: const Text('Share'),
                            onPressed: () async {
                              Get.to(ShareMain(pic));
                            },
                            icon: const Icon(Icons.share)),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
