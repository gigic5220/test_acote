import 'package:get/get.dart';
import 'package:test_acote/main.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => const MyHomePage(title: 'test_acote')
    ),
  ];
}