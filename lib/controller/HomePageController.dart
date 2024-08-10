import 'dart:convert';

import 'package:get/get.dart';
import 'package:test_acote/model/mock/mock.dart';
import 'package:test_acote/model/user.dart';
import 'package:test_acote/repository/github_repository.dart';

class HomePageController extends GetxController {
  final GithubRepository githubRepository;
  HomePageController({
    required this.githubRepository
  });

  final RxList<User> _userList = <User>[].obs;

  List<User> get getUserList => _userList;

  @override
  void onInit() async {
    super.onInit();
    _userList.value = MockData.MOCK_USER_LIST.map((mockData) => User.fromJson(jsonDecode(jsonEncode(mockData)))).toList(); //todo: 퍼블리싱 작업 후 제거
  }

  //광고 배너표시 index
  int get getAdBannerIndex => 10;

  String getAdBannerUrl() => 'https://via.placeholder.com/500x100?text=ad';
}