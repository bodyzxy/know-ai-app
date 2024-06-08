import 'package:get/get.dart';

class DrawController extends GetxController {
  late RxString url = "http://img.92fa.com/pic/TP878_01.jpg".obs;
  void updateUrl(String newUrl) {
    url.value = newUrl;
    update();
  }
}
