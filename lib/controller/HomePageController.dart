import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final RxBool _isInitialDataLoading = true.obs;

  List<User> get getUserList => _userList;
  bool get getIsUserListLoading => _isUserListLoading.value;
  bool get getIsInitialDataLoading => _isInitialDataLoading.value;

  set setUserList(List<User> value) => _userList.value = value;
  set setIsUserListLoading(bool value) => _isUserListLoading.value = value;
  set setIsInitialDataLoading(bool value) => _isInitialDataLoading.value = value;

  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(() => scrollListener(controller: scrollController));
    setInitialData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  //광고 배너표시 index
  int get getAdBannerLocationIndex => 10;

  String getAdBannerImageUrl() => 'https://via.placeholder.com/500x100?text=ad';
  String getAdBannerBrowserTargetUrl() => 'https://taxrefundgo.kr';

  void setInitialData() async {
    try {
      await setUserListData();
    } finally {
      setIsInitialDataLoading = false;
    }
  }

  Future<void> setUserListData({
    int? userListSincePagingParameter
  }) async {
    if (getIsUserListLoading) return;
    try {
      setIsUserListLoading = true;
      final List<User> userListData = await githubRepository.getUserList(sincePagingParameter: userListSincePagingParameter);
      _userListSincePagingParameter = userListData.length == 30 ? userListData[userListData.length - 1].id : null;
      if (userListSincePagingParameter != null) {
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
    if (controller.offset >= controller.position.maxScrollExtent - 50) {
      if (_userListSincePagingParameter != null && !getIsUserListLoading) {
        setUserListData(userListSincePagingParameter: _userListSincePagingParameter);
      }
    }
  }

  void scrollListener({
    required ScrollController controller
  }) => userListPaging(controller: controller);


  void onTapUserItem({
    required String userName
  }) => Get.toNamed(
    '/home/detail',
    arguments: {
      'userName': userName
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