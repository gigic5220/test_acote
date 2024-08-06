import 'package:get/get.dart';
import 'package:test_acote/binding/HomePageBinding.dart';
import 'package:test_acote/view/home_page/home_page.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => const HomePage(),
      bindings: [HomePageBinding()]
    )
  ];
}