import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailTxView extends GetView<DetailTxView> {
  const DetailTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailTxView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailTxView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
