import 'package:get/get.dart';
import 'package:test_acote/binding/DetailPageBinding.dart';
import 'package:test_acote/binding/HomePageBinding.dart';
import 'package:test_acote/view/detail_page/detail_page.dart';
import 'package:test_acote/view/home_page/home_page.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      bindings: [HomePageBinding()]
    ),
    GetPage(
      name: '/home/detail',
      page: () => const DetailPage(),
      bindings: [DetailPageBinding()]
    ),
  ];
}