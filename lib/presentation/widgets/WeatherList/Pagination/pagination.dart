import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int currenPage;
  final int pageNumber;

  Pagination({this.currenPage, this.pageNumber});

  List<Widget> getPages() {
    List<Widget> pages = [];

    List.filled(pageNumber, 0).asMap().forEach((index, e) => {
          pages.add(
            AnimatedContainer(
              margin: EdgeInsets.symmetric(horizontal: 2),
              duration: Duration(microseconds: 2000),
              curve: Curves.bounceIn,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(index == currenPage ? 7 : 6)),
                  color: Colors.white.withOpacity(0.2)),
              width: index == currenPage ? 14 : 12,
              height: index == currenPage ? 14 : 12,
            ),
          )
        });
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center, children: getPages()),
    );
  }
}
