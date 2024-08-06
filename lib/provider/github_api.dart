import 'package:get/get.dart';

class GithubApi extends GetConnect {
  getUserList() async {
    final Response response = await get('https://api.github.com/users');
    if (response.hasError) {
      return 'error';
    } else {
      return 'result';
    }
  }
}