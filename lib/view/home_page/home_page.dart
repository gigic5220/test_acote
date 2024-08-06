import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return _userListItem();
        },
        separatorBuilder: (context, index) {
          return Container();
        },
        itemCount: 30
      )
    );
  }

  Widget _userListItem() {
    return Container(
      child: Column(

      ),
    );
  }
}