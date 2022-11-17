import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/covid_today_province.dart';
import '../model/covid_today_total.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Covid19ThTotal> _totalCovid;
  late List<Covid19ThProvince> _provinceCovid;
  String? mainValue;
  int mainIndex = -1;
  int newCase = 0;
  int totalCase = 0;
  int newDeath = 0;
  int totalDeath = 0;
  @override
  void initState() {
    super.initState();
    getCovid();
  }

  void disonse() {
    super.dispose();
  }

  Future<List<Covid19ThTotal>> getCovid() async {
    var url1 =
        Uri.https('covid19.ddc.moph.go.th', '/api/Cases/today-cases-all');
    var url2 = Uri.https(
        'covid19.ddc.moph.go.th', '/api/Cases/today-cases-by-provinces');
    // res1 == covid total
    var res1 = await http.get(url1);
    // res2 == covid province
    var res2 = await http.get(url2);
    _totalCovid = covid19ThTotalFromJson(res1.body);
    _provinceCovid = covid19ThProvinceFromJson(res2.body);
    return _totalCovid;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: getCovid(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 14, left: 14),
                    child: Text(
                      'Covid in Thailand',
                      style: TextStyle(
                        fontFamily: 'Mitr',
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: size.height * 0.675,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: size.height * 0.35,
                        margin: const EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                SizedBox(width: 7),
                                Text(
                                  'ผู้ติดเชื้อใหม่',
                                  style: TextStyle(
                                    fontFamily: 'Mitr',
                                    color: Colors.white,
                                    fontSize: 24,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '+${NumberFormat("#,###").format(_totalCovid[0].newCase)}',
                              style: const TextStyle(
                                fontFamily: 'Mitr',
                                color: Colors.white,
                                fontSize: 50,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Container(
                            height: size.height * 0.13,
                            width: double.infinity,
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(children: <Widget>[
                              const Align(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12, top: 8),
                                  child: Text(
                                    'ผู้ติดเชื้อสะสม',
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 22,
                                      color: Colors.red,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              Align(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 12,
                                    top: 10,
                                  ),
                                  child: Text(
                                    '+${NumberFormat("#,###").format(_totalCovid[0].totalRecovered)}',
                                    style: const TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Colors.black87,
                                      fontSize: 26,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.bottomRight,
                              ),
                            ]),
                          ),
                        ])),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: size.height * 0.27,
                              margin:
                                  const EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff27AE60),
                              ),
                              child: Center(
                                  child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      SizedBox(width: 7),
                                      Text(
                                        'รักษาหายใหม่',
                                        style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Colors.white,
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '+${NumberFormat("#,###").format(_totalCovid[0].newRecovered)}',
                                    style: const TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Colors.white,
                                      fontSize: 28,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Container(
                                  height: size.height * 0.11,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'รักษาหายสะสม',
                                            style: TextStyle(
                                              fontFamily: 'Mitr',
                                              color: Color(0xff27AE60),
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '+${NumberFormat("#,###").format(_totalCovid[0].totalRecovered)}',
                                            style: const TextStyle(
                                              fontFamily: 'Mitr',
                                              color: Colors.black87,
                                              fontSize: 18,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ])),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: size.height * 0.27,
                              margin:
                                  const EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                              child: Center(
                                  child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      SizedBox(width: 7),
                                      Text(
                                        'เสียชีวิตใหม่',
                                        style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Colors.white,
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '+${NumberFormat("#,###").format(_totalCovid[0].newDeath)}',
                                    style: const TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Colors.white,
                                      fontSize: 28,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Container(
                                  height: size.height * 0.11,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'เสียชีวิตสะสม',
                                            style: TextStyle(
                                              fontFamily: 'Mitr',
                                              color: Colors.grey,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '+${NumberFormat("#,###").format(_totalCovid[0].totalDeath)}',
                                            style: const TextStyle(
                                              fontFamily: 'Mitr',
                                              color: Colors.black87,
                                              fontSize: 18,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ])),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Icon(Icons.access_time),
                        const SizedBox(width: 5),
                        Text(DateFormat('d/M/y - hh:mm ')
                            .format(_totalCovid[0].updateDate)),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Container(
                          // Province
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                value: mainValue,
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  fontFamily: 'Mitr',
                                  fontSize: 16,
                                  color: Colors.black,
                                  // fontWeight: FontWeight.w300,
                                ),
                                iconSize: 32,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                isExpanded: true,
                                items: getProvince(_provinceCovid)
                                    .map(buildItem)
                                    .toList(),
                                hint: const Text(
                                  "เลือกจังหวัด",
                                  style: TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 18,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    mainValue = value!;
                                    newCase = _provinceCovid[
                                            getIndex(value, _provinceCovid)]
                                        .newCase;
                                    totalCase = _provinceCovid[
                                            getIndex(value, _provinceCovid)]
                                        .totalCase;
                                    newDeath = _provinceCovid[
                                            getIndex(value, _provinceCovid)]
                                        .newDeath;
                                    totalDeath = _provinceCovid[
                                            getIndex(value, _provinceCovid)]
                                        .totalDeath;
                                  });
                                }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: size.height * 0.27,
                              margin:
                                  const EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.redAccent),
                              child: Center(
                                  child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      SizedBox(width: 7),
                                      Text(
                                        'ผู้ติดเชื้อใหม่',
                                        style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Colors.white,
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '+${NumberFormat("#,###").format(newCase)}',
                                    style: const TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Colors.white,
                                      fontSize: 28,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Container(
                                  height: size.height * 0.11,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'ผู้ติดเชื้อสะสม',
                                            style: TextStyle(
                                              fontFamily: 'Mitr',
                                              color: Colors.redAccent,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '+${NumberFormat("#,###").format(totalCase)}',
                                            style: const TextStyle(
                                              fontFamily: 'Mitr',
                                              color: Colors.black87,
                                              fontSize: 18,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ])),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: size.height * 0.27,
                              margin:
                                  const EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                              child: Center(
                                  child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      SizedBox(width: 7),
                                      Text(
                                        'เสียชีวิตใหม่',
                                        style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Colors.white,
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '+${NumberFormat("#,###").format(newDeath)}',
                                    style: const TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Colors.white,
                                      fontSize: 28,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Container(
                                  height: size.height * 0.11,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'เสียชีวิตสะสม',
                                            style: TextStyle(
                                              fontFamily: 'Mitr',
                                              color: Colors.grey,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '+${NumberFormat("#,###").format(totalDeath)}',
                                            style: const TextStyle(
                                              fontFamily: 'Mitr',
                                              color: Colors.black87,
                                              fontSize: 18,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ])),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const Icon(Icons.access_time),
                            const SizedBox(width: 5),
                            Text(DateFormat('d/M/y - hh:mm ')
                                .format(_provinceCovid[0].updateDate)),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.redAccent,
            ),
          );
        },
      )),
    );
  }
}

DropdownMenuItem<String> buildItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
      ),
    );

List<String> getProvince(List<Covid19ThProvince> data) {
  List<String> myList = [];
  for (var item in data) {
    myList.add(item.province);
  }
  return myList;
}

String getTitle(String? title) {
  if (title == null) {
    return 'เลือกจังหวัด';
  }
  return title;
}

int getIndex(String text, List<Covid19ThProvince> data) {
  var list = getProvince(data);
  var index = list.indexOf(text);
  return index;
}
