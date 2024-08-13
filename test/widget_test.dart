import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_acote/model/mock/mock.dart';
import 'package:test_acote/model/repository.dart';
import 'package:test_acote/model/user.dart';
import 'package:test_acote/widget/detail_page/user_repository_list_widget.dart';
import 'package:test_acote/widget/home_page/user_list_widget.dart';

void main() {
  List<User> mockUserList = [];
  List<Repository> mockUserRepositoryList = [];

  late int adBannerLocationIndex;

  setUp(() async {
    mockUserList = MockData.MOCK_USER_LIST.map((mockData) => User.fromJson(jsonDecode(jsonEncode(mockData)))).toList();
    mockUserRepositoryList = MockData.MOCK_USER_REPOSITORY_LIST.map((mockData) => Repository.fromJson(jsonDecode(jsonEncode(mockData)))).toList();
    adBannerLocationIndex = 10;
  });

  testWidgets('UserListWidget test - 유저 목록 및 광고 노출 / 유저 탭 / 광고 탭 테스트', (WidgetTester tester) async {

    String tappedUserName = '';
    bool adTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UserListWidget(
            scrollController: ScrollController(),
            userList: mockUserList,
            adBannerLocationIndex: adBannerLocationIndex,
            adBannerImageUrl: 'https://via.placeholder.com/500x100?text=ad',
            onTapUserItem: ({required int index}) {
              tappedUserName = mockUserList[index].login;
            },
            onTapAdBanner: () {
              adTapped = true;
            },
          ),
        ),
      ),
    );

    await tester.pump();

    for (int i = 0; i < mockUserList.length; i++) {

      // 유저 목록 노출 여부 테스트
      final userWidgetFinder = find.text(mockUserList[i].login);
      await tester.ensureVisible(userWidgetFinder);
      expect(userWidgetFinder, findsWidgets);

      // 유저 선택 시 전달 파라미터 테스트
      await tester.tap(userWidgetFinder);
      expect(tappedUserName, mockUserList[i].login);

      // 광고 배너 노출 여부 및 노출 위치 테스트
      if ((i + 1) % adBannerLocationIndex == 0) {
        adTapped = false;

        final adBannerWidgetFinder = find.byKey(Key('test_key_ad_banner_$i'));
        await tester.ensureVisible(adBannerWidgetFinder);
        expect(userWidgetFinder, findsWidgets);

        await tester.tap(adBannerWidgetFinder);
        expect(adTapped, isTrue);
      }
      
      await tester.pump();
    }
  });

  testWidgets('UserRepositoryListWidget test - 유저 리포지토리 목록 노출 테스트', (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UserRepositoryListWidget(
            scrollController: ScrollController(),
            userRepositoryList: mockUserRepositoryList
          ),
        ),
      ),
    );

    await tester.pump();

    for (int i = 0; i < mockUserRepositoryList.length; i++) {

      // 유저 리포지토리 목록 노출 여부 테스트

      // 이름 노출
      final userRepositoryNameWidgetFinder = find.byKey(Key('test_key_text_widget_name_$i'));
      await tester.ensureVisible(userRepositoryNameWidgetFinder);

      // 이름 노출 테스트
      final userRepositoryNameWidget = tester.widget<Text>(userRepositoryNameWidgetFinder);
      expect(userRepositoryNameWidget.data, mockUserRepositoryList[i].name);

      if (mockUserRepositoryList[i].description != null) {
        // 설명 노출
        final userRepositoryDescriptionWidgetFinder = find.byKey(Key('test_key_text_widget_description_$i'));
        await tester.ensureVisible(userRepositoryDescriptionWidgetFinder);
        // 설명 노출 테스트
        final userRepositoryDescriptionWidget = tester.widget<Text>(userRepositoryDescriptionWidgetFinder);
        expect(userRepositoryDescriptionWidget.data, mockUserRepositoryList[i].description);
      }

      // 별 갯수 노출
      final userRepositoryStargazersCountWidgetFinder = find.byKey(Key('test_key_text_widget_stargazers_count_$i'));
      await tester.ensureVisible(userRepositoryStargazersCountWidgetFinder);

      // 별 갯수 노출 테스트
      final userRepositoryStargazersCountWidget = tester.widget<Text>(userRepositoryStargazersCountWidgetFinder);
      expect(userRepositoryStargazersCountWidget.data, mockUserRepositoryList[i].stargazersCount.toString());

      if (mockUserRepositoryList[i].language != null) {
        // 언어 노출
        final userRepositoryLanguageWidgetFinder = find.byKey(Key('test_key_text_widget_language_$i'));
        await tester.ensureVisible(userRepositoryLanguageWidgetFinder);
        // 언어 노출 테스트
        final userRepositoryLanguageWidget = tester.widget<Text>(userRepositoryLanguageWidgetFinder);
        expect(userRepositoryLanguageWidget.data, mockUserRepositoryList[i].language);
      }

      await tester.pump();
    }
  });
}
