import 'dart:io';
import 'dart:ui';

import 'package:algostudiotest/detail/controller/imageadd_controller.dart';
import 'package:algostudiotest/detail/controller/saved_controller.dart';
import 'package:algostudiotest/detail/controller/textadd_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shimmer/shimmer.dart';

SavedController savecontroll = Get.put(SavedController());
TextAddController textcontroll = Get.put(TextAddController());
ImageAddController imagecontroll = Get.put(ImageAddController());

// ignore: must_be_immutable
class DetailImage extends StatelessWidget {
  String pic;
  DetailImage(this.pic, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    textcontroll.resetPosition();
    imagecontroll.reset();
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
        body: RepaintBoundary(
          key: savecontroll.src,
          child: SizedBox(
            width: double.infinity,
            child: ImageMain(context),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: double.infinity,
          height: 80,
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
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
                          label: const Text('Add Logo'),
                          onPressed: () async {
                            imagecontroll.getFromGallery();
                          },
                          icon: const Icon(Icons.image)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ElevatedButton.icon(
                          label: const Text('Add Text'),
                          onPressed: () {
                            showMyDialog(context);
                          },
                          icon: const Icon(Icons.text_fields_sharp)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SizedBox(
                        height: 45,
                        width: 70,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(colors: [
                                Colors.blue.shade300,
                                Colors.blueAccent
                              ])),
                          child: ElevatedButton(
                            onPressed: () async {
                              final boundary = savecontroll.src.currentContext
                                      ?.findRenderObject()
                                  as RenderRepaintBoundary?;
                              final image = await boundary?.toImage();
                              final byteData = await image?.toByteData(
                                  format: ImageByteFormat.png);
                              final imageBytes = byteData?.buffer.asUint8List();

                              savecontroll.saveImage(imageBytes!);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Text('Finish',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget ImageMain(BuildContext context) {
    return Stack(children: [
      CachedNetworkImage(
        imageUrl: pic,
        fit: BoxFit.fill,
        placeholder: (context, url) => Shimmer.fromColors(
            child: const Center(child: Text('Loading')),
            baseColor: Colors.red,
            highlightColor: Colors.yellow),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      Obx(() => Positioned(
            top: textcontroll.top.toDouble(),
            bottom: textcontroll.bottom.toDouble(),
            left: textcontroll.left.toDouble(),
            right: textcontroll.bottom.toDouble(),
            child: GestureDetector(
              onVerticalDragUpdate: (v) {
                textcontroll.changePosition(
                    v.localPosition.dx, v.localPosition.dy);
              },
              onDoubleTap: () {
                textcontroll.removeText();
              },
              child: Text(
                textcontroll.textit.value,
                style: const TextStyle(
                  color: Color.fromARGB(255, 12, 12, 12),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )),
      Obx(() {
        if (imagecontroll.imagepath.value == "") {
          return const Center();
        }
        return Positioned(
          top: imagecontroll.top.toDouble(),
          left: imagecontroll.left.toDouble(),
          child: GestureDetector(
            onVerticalDragUpdate: (v) {
              imagecontroll.changePosition(
                  v.localPosition.dx, v.localPosition.dy);
            },
            onDoubleTap: () {
              imagecontroll.reset();
            },
            onLongPress: () {
              showMyDialogImage(context);
            },
            child: Image.file(
              File(imagecontroll.imagepath.value),
              fit: BoxFit.cover,
              width: imagecontroll.width.toDouble(),
              height: imagecontroll.height.toDouble(),
            ),
          ),
        );
      }),
    ]);
  }
}

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Change Text'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  onSaved: (value) {},
                  validator: (value) {},
                  controller: textcontroll.texting,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Input Text',
                    hintText: '',
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ))
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Update Text'),
            onPressed: () {
              textcontroll.changeText(textcontroll.texting.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showMyDialogImage(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Change Text'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  onSaved: (value) {},
                  validator: (value) {},
                  controller: imagecontroll.widthcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Input Width',
                    hintText: '',
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  )),
              TextFormField(
                  autofocus: false,
                  onSaved: (value) {},
                  validator: (value) {},
                  controller: imagecontroll.heightcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Input Height',
                    hintText: '',
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ))
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Resize It'),
            onPressed: () {
              imagecontroll.resize(imagecontroll.widthcontroller.text,
                  imagecontroll.heightcontroller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
