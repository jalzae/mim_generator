import 'package:flutter/material.dart';

class LoadingWidget {
  Widget loadingHelper(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget noDataHelper(BuildContext context) {
    return const Center(
      child: Text('No Data Here'),
    );
  }
}
