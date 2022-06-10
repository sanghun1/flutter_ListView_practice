import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Home(),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _leftTitleText = TextStyle(fontSize: 20, color: Color(0xff4D4D4D), fontWeight: FontWeight.bold);
  final _leftNumText = TextStyle(fontSize: 22, color: Color(0xff01BB84), fontWeight: FontWeight.bold);
  final _leftKcalText = TextStyle(fontSize: 22, color: Color(0xff3E3E3E));
  final _rightTitleText = TextStyle(fontSize: 18, color: Color(0xff5A5A5A), fontWeight: FontWeight.bold);
  final _rightText = TextStyle(fontSize: 17, color: Color(0xff6C6C6C));

  final _border = BorderSide(width: 2, color: Color(0xffDADADA), style: BorderStyle.solid);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Path customPath = Path()
      ..moveTo(size.width - 20, 5)
      ..lineTo(size.width - 20, 838);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: ListView(
        children: [
          DottedBorder(
            customPath: (size) => customPath,
            dashPattern: [8, 4],
            color: Color(0xffDADADA),
            strokeWidth: 2,
            child: table(),
          )
        ],
      ),
    );
  }
// DataTable로 바꾸기
  Table table() {
    return Table(
      border: TableBorder(
        top: _border,
        bottom: _border,
        horizontalInside: _border,
        verticalInside: _border,
      ),
      columnWidths: {
        0: FractionColumnWidth(0.34),
        1: FractionColumnWidth(0.66),
      },
      children: [
        TableRow(
          children: [
            leftColumn(
              "조식",
              rowMealKcal("828"),
            ),
            rightColumn(
              rightTitleRow("율무밥"),
              rightRow("종류", "밥류"),
              rightRow("재료", "흰쌀"),
              rightRow("정량", "210g"),
              rightRow("칼로리", "130kcal"),
            )
          ],
        ),
        TableRow(
          children: [
            leftColumn(
              "조식",
              rowMealKcal("828"),
            ),
            rightColumn(
              rightTitleRow("율무밥"),
              rightRow("종류", "밥류"),
              rightRow("재료", "흰쌀"),
              rightRow("정량", "210g"),
              rightRow("칼로리", "130kcal"),
            )
          ],
        ),
        TableRow(
          children: [
            leftColumn(
              "조식",
              rowMealKcal("828"),
            ),
            rightColumn(
              rightTitleRow("율무밥"),
              rightRow("종류", "밥류"),
              rightRow("재료", "흰쌀"),
              rightRow("정량", "210g"),
              rightRow("칼로리", "130kcal"),
            )
          ],
        ),
      ],
    );
  }

  Widget rightColumn(Widget title, Widget r1, Widget r2, Widget r3, Widget r4) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
      child: Column(
        children: [title, r1, r2, r3, r4],
      ),
    );
  }

  Widget rightRow(String word1, String word2) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            word1,
            style: _rightText,
          ),
          Text(
            word2,
            style: _rightText,
          ),
        ],
      ),
    );
  }

  Widget rightTitleRow(String menu) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            menu,
            style: _rightTitleText,
          ),
          Icon(
            CupertinoIcons.heart,
            color: Color(0xffEF7A8E),
            size: 30,
          ),
        ],
      ),
    );
  }

  Widget leftColumn(String meal, Widget row) {
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meal,
            style: _leftTitleText,
          ),
          row
        ],
      ),
    );
  }

  Widget rowMealKcal(String num) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            num,
            style: _leftNumText,
          ),
          Text(
            " kcal",
            style: _leftKcalText,
          ),
        ],
      ),
    );
  }
}
