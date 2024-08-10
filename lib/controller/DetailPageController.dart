import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/model/repository.dart';
import 'package:test_acote/repository/github_repository.dart';

class DetailPageController extends GetxController {
  final GithubRepository githubRepository;

  DetailPageController({
    required this.githubRepository
  });
  final ScrollController scrollController = ScrollController();
  int? _userRepositoryListSincePagingParameter = 1;

  final RxList<Repository> _userRepositoryList = <Repository>[].obs;
  final RxnString _userName = RxnString(null);
  final RxBool _isUserRepositoryListLoading = false.obs;
  final RxBool _isInitialDataLoading = true.obs;

  List<Repository> get getUserRepositoryList => _userRepositoryList;
  String? get getUserName => _userName.value;
  bool get getIsUserRepositoryListLoading => _isUserRepositoryListLoading.value;
  bool get getIsInitialDataLoading => _isInitialDataLoading.value;

  set setUserRepositoryList(List<Repository> value) => _userRepositoryList.value = value;
  set setUserName(String? value) => _userName.value = value;
  set setIsUserRepositoryListLoading(bool value) => _isUserRepositoryListLoading.value = value;
  set setIsInitialDataLoading(bool value) => _isInitialDataLoading.value = value;

  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(() => scrollListener(controller: scrollController));
    final String? userName = Get.arguments?['userName'];
    setUserName = userName;
    if (userName != null) {
      setInitialData(userName: userName);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void setInitialData({
    required String userName
  }) async {
    try {
      await setUserRepositoryListData(
        userName: userName,
        userRepositoryListSincePagingParameter: 1
      );
    } finally {
      setIsInitialDataLoading = false;
    }
  }


  Future<void> setUserRepositoryListData({
    required String userName,
    required int userRepositoryListSincePagingParameter
  }) async {
    if (getIsUserRepositoryListLoading) return;
    try {
      setIsUserRepositoryListLoading = true;
      final List<Repository> userRepositoryListData = await githubRepository.getUserRepositoryList(
        userName: userName,
        pagePagingParameter: userRepositoryListSincePagingParameter
      );
      if (userRepositoryListData.length != 30) {
        _userRepositoryListSincePagingParameter = null;
      } else {
        _userRepositoryListSincePagingParameter = userRepositoryListSincePagingParameter;
      }
      setUserRepositoryList = userRepositoryListSincePagingParameter == 1 ? userRepositoryListData : [...getUserRepositoryList, ... userRepositoryListData];
    } finally {
      setIsUserRepositoryListLoading = false;
    }
  }

  void userRepositoryListPaging({
    required ScrollController controller
  }) {
    if (controller.offset >= controller.position.maxScrollExtent - 50) {
      if (getUserName != null && _userRepositoryListSincePagingParameter != null && !getIsUserRepositoryListLoading) {
        setUserRepositoryListData(
          userName: getUserName!,
          userRepositoryListSincePagingParameter: _userRepositoryListSincePagingParameter! + 1
        );
      }
    }
  }

  void scrollListener({
    required ScrollController controller
  }) => userRepositoryListPaging(controller: controller);
}