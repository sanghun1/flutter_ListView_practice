import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
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

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _leftTitleText = TextStyle(fontSize: 20, color: Color(0xff4D4D4D), fontWeight: FontWeight.bold);
  final _leftNumText = TextStyle(fontSize: 22, color: Color(0xff01BB84), fontWeight: FontWeight.bold);
  final _leftKcalText = TextStyle(fontSize: 22, color: Color(0xff3E3E3E));
  final _rightTitleText = TextStyle(fontSize: 18, color: Color(0xff5A5A5A), fontWeight: FontWeight.bold);
  final _rightText = TextStyle(fontSize: 17, color: Color(0xff6C6C6C));

  final _barText = TextStyle(color: Colors.white, fontSize: 18);

  final _border = BorderSide(width: 2, color: Color(0xffDADADA), style: BorderStyle.solid);

  final _onDecoration = BoxDecoration(
    border: Border(
      left: BorderSide(color: Color(0xff4CA0F7), width: 3),
      top: BorderSide(color: Color(0xff4CA0F7), width: 3),
      bottom: BorderSide(color: Color(0xff4CA0F7), width: 3),
    ),
    color: Color(0xffF2FCF9),
  );

  final _offDecoration = BoxDecoration();

  var _rightDecoration = [BoxDecoration(), BoxDecoration(), BoxDecoration()];

  var select = [true, true, true];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;

    Path customPath = Path()
      ..moveTo(size.width - 20, 5)
      ..lineTo(size.width - 20, 838);

    Map<String, double> dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };

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
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              "다량영양소",
              style: _leftTitleText,
            ),
          ),
          barNutrient(size, "탄수화물", 24, Color(0xff4C7EFD)),
          barNutrient(size, "단백질", 65, Color(0xff4A96F4)),
          barNutrient(size, "지방", 51, Color(0xff48B2E8)),
          barNutrient(size, "총 식이섬유", 24, Color(0xff45CADE)),
          barNutrient(size, "콜레스테롤", 48, Color(0xff43E1D5)),
          barNutrient(size, "총 포화 지방산", 48, Color(0xff41FACA)),
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            // colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            ringStrokeWidth: 32,
            legendOptions: LegendOptions(
              showLegends: true,
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 2,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          )
        ],
      ),
    );
  }

  Padding barNutrient(size, var nutrient, var percent, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nutrient,
            style: _rightTitleText,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: size.width * .80,
                  height: 25,
                  color: Color(0xffF2F2F2),
                  child: Stack(
                    children: [
                      PositionedTransition(
                        rect: barAnimation(size, percent),
                        child: Container(
                          alignment: Alignment.centerRight,
                          color: color,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(percent.toString(), style: _barText),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "100%",
                    style: _rightTitleText,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Animation<RelativeRect> barAnimation(dynamic size, dynamic bar) {
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, size.width * .80, 0),
      end: RelativeRect.fromLTRB(0, 0, (size.width * .80) * (1 - (bar * 0.01)), 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));
  }

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
            InkWell(
              onTap: () {
                setState(() {
                  onClick(0);
                });
              },
              child: Container(
                decoration: _rightDecoration[0],
                child: rightColumn(
                  rightTitleRow("율무밥"),
                  rightRow("종류", "밥류"),
                  rightRow("재료", "흰쌀"),
                  rightRow("정량", "210g"),
                  rightRow("칼로리", "130kcal"),
                ),
              ),
            )
          ],
        ),
        TableRow(
          children: [
            leftColumn(
              "중식",
              rowMealKcal("781"),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  onClick(1);
                });
              },
              child: Container(
                decoration: _rightDecoration[1],
                child: rightColumn(
                  rightTitleRow("열무보리비빔밥"),
                  rightRow("종류", "밥류"),
                  rightRow("재료", "보리쌀"),
                  rightRow("정량", "210g"),
                  rightRow("칼로리", "130kcal"),
                ),
              ),
            )
          ],
        ),
        TableRow(
          children: [
            leftColumn(
              "석식",
              rowMealKcal("724"),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  onClick(2);
                });
              },
              child: Container(
                decoration: _rightDecoration[2],
                child: rightColumn(
                  rightTitleRow("찹쌀땅콩밥"),
                  rightRow("종류", "밥류"),
                  rightRow("재료", "찹쌀, 땅콩"),
                  rightRow("정량", "210g"),
                  rightRow("칼로리", "130kcal"),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void onClick(index) {
    if (select[index]) {
      for (var i = 0; i < 3; i++) {
        select[i] = true;
        _rightDecoration[i] = _offDecoration;
      }
      select[index] = false;
      _rightDecoration[index] = _onDecoration;
    } else {
      select[index] = true;
      _rightDecoration[index] = _offDecoration;
    }
  }

  BoxDecoration myBoxDecoration(Border border, Color color) {
    return BoxDecoration(
      border: border,
      color: color,
    );
  }

  Widget rightColumn(Widget title, Widget type, Widget ingredient, Widget gram, Widget kcal) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
      child: Column(
        children: [title, type, ingredient, gram, kcal],
      ),
    );
  }

  Widget rightRow(String category, String content) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: _rightText,
          ),
          Text(
            content,
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

  Widget leftColumn(String meal, Widget kcalRow) {
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meal,
            style: _leftTitleText,
          ),
          kcalRow
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
