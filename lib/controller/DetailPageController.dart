import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/model/mock/mock.dart';
import 'package:test_acote/model/repository.dart';
import 'package:test_acote/repository/github_repository.dart';

class DetailPageController extends GetxController {
  final GithubRepository githubRepository;

  DetailPageController({
    required this.githubRepository
  });
  final ScrollController scrollController = ScrollController();

  final RxList<Repository> _userRepositoryList = <Repository>[].obs;
  final RxnString _userName = RxnString(null);

  List<Repository> get getUserRepositoryList => _userRepositoryList;
  String? get getUserName => _userName.value;

  set setUserRepositoryList(List<Repository> value) => _userRepositoryList.value = value;
  set setUserName(String? value) => _userName.value = value;
  @override

  void onInit() async {
    super.onInit();
    setUserName = Get.arguments?['userName'];
    setInitialData();
  }

  void setInitialData() async {
    setUserRepositoryList = MockData.MOCK_USER_REPOSITORY_LIST.map((mockData) => Repository.fromJson(jsonDecode(jsonEncode(mockData)))).toList(); //todo: api 호출 제한으로 기능 개발 완성 시 까지 유지
  }
}