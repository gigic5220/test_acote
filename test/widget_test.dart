import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_acote/model/mock/mock.dart';
import 'package:test_acote/model/user.dart';
import 'package:test_acote/widget/home_page/user_list_widget.dart';

void main() {
  List<User> mockUserList = [];
  late int adBannerLocationIndex;

  setUp(() async {
    mockUserList = MockData.MOCK_USER_LIST.map((mockData) => User.fromJson(jsonDecode(jsonEncode(mockData)))).toList();
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

}
