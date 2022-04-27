import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

FlutterShareMe flutterShareMe = FlutterShareMe();

class ShareMain extends StatelessWidget {
  File pic;
  ShareMain(this.pic, {Key? key}) : super(key: key);

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
            height: 130,
            decoration: const BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(color: Colors.grey, width: 0.5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton.icon(
                            label: const Text('Share To Fb'),
                            onPressed: () async {
                              var response = await flutterShareMe
                                  .shareToFacebook(url: "url", msg: "msg");
                            },
                            icon: const Icon(Icons.save)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton.icon(
                            label: const Text('Share To Twitter'),
                            onPressed: () async {
                              var response = await flutterShareMe
                                  .shareToTwitter(url: "url", msg: "msg");
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
