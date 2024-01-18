import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peminjam/app/data/constant/endpoint.dart';
import 'package:peminjam/app/data/provider/api_provider.dart';
import 'package:peminjam/app/data/provider/storange_provider.dart';


class AddPeminjamanController extends GetxController {
  //TODO: Implement AddPeminjamanController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController pinjamController = TextEditingController();
  final TextEditingController kembaliController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  final loading = false.obs;
  Future<void> post() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        log("message dsa");
        log("message ds ${StorageProvider.read(StorageKey.idUser)}");
        var params = {
          "tanggal_pinjam": pinjamController.text.toString(),
          "tanggal_kembali": kembaliController.text.toString(),
          "user_id": int.parse(StorageProvider.read(StorageKey.idUser)),
          "book_id": int.parse(Get.parameters['id'].toString())
        };
        log("message $params");
        final response = await ApiProvider.instance().post(Endpoint.pinjam, data: params);
        if (response.statusCode == 201) {
          Get.back();
        } else {
          Get.snackbar("Sorry", "Simpan Gagal", backgroundColor: Colors.orange);
        }
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      log("${e.response?.statusMessage}");
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}", backgroundColor: Colors.orange);
        } else {
          Get.snackbar("Sorry", "${e.response?.statusMessage}", backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
      throw Exception('Error: $e');
    }
  }

}