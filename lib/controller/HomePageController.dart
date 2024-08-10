import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/model/mock/mock.dart';
import 'package:test_acote/model/user.dart';
import 'package:test_acote/repository/github_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageController extends GetxController {
  final GithubRepository githubRepository;
  HomePageController({
    required this.githubRepository
  });

  final ScrollController scrollController = ScrollController();
  int? _userListSincePagingParameter;

  final RxList<User> _userList = <User>[].obs;
  final RxBool _isUserListLoading = false.obs;

  List<User> get getUserList => _userList;
  bool get getIsUserListLoading => _isUserListLoading.value;

  set setUserList(List<User> value) => _userList.value = value;
  set setIsUserListLoading(bool value) => _isUserListLoading.value = value;

  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(() => scrollListener(controller: scrollController));
    setInitialData();
  }

  //광고 배너표시 index
  int get getAdBannerLocationIndex => 10;

  String getAdBannerImageUrl() => 'https://via.placeholder.com/500x100?text=ad';
  String getAdBannerBrowserTargetUrl() => 'https://taxrefundgo.kr';

  void setInitialData() async {
    setUserList = MockData.MOCK_USER_LIST.map((mockData) => User.fromJson(jsonDecode(jsonEncode(mockData)))).toList(); //todo: api 호출 제한으로 기능 개발 완성 시 까지 유지
    //await setUserListData();
  }

  Future<void> setUserListData({
    int? userListSincePagingParameter
  }) async {
    if (getIsUserListLoading) return;
    try {
      setIsUserListLoading = true;
      final List<User> userListData = await githubRepository.getUserList(sincePagingParameter: userListSincePagingParameter);
      if (userListData.isNotEmpty) {
        _userListSincePagingParameter = userListData[userListData.length - 1].id;
      }
      if (_userListSincePagingParameter != null) {
        setUserList = [...getUserList, ... userListData];
      } else {
        setUserList = userListData;
      }
    } finally {
      setIsUserListLoading = false;
    }
  }

  void userListPaging({
    required ScrollController controller
  }) {
    if (controller.offset >= controller.position.maxScrollExtent) {
      if (_userListSincePagingParameter != null) {
        setUserListData(userListSincePagingParameter: _userListSincePagingParameter);
      }
    }
  }

  void scrollListener({
    required ScrollController controller
  }) => userListPaging(controller: scrollController);


  void onTapUserItem({
    required int userId
  }) => Get.toNamed(
    '/detail',
    arguments: {
      'id': userId
    }
  );

  void onTapAdBanner({
    required String targetUrl
  }) => openWebBrowser(url: targetUrl);


  Future<void> openWebBrowser({
    required String url
  }) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}