import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web/Settings.dart';
import 'package:web/services/Controller.dart';
import 'package:web/services/View.dart';

import 'services/View.dart';
import 'services/View.dart';

class Home extends StatelessWidget {
  final Controller c = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Scaffold(
      backgroundColor: CustomColor().primaryDark,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.flight),
            Text(' Monitor Ruang Kelas Teknik Listrik Bandara')
          ],
        ),
        backgroundColor: CustomColor().primary,
      ),
      body: Stack(
        children: [
          Positioned(
            top: View.blockY * 5,
            right: View.blockX * 20,
            width: View.blockX * 60,
            height: View.blockY * 75,
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomCard(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: View.blockX * 5,
                      ),
                      title: 'Status Ruang',
                      subtitle: 'Ruangan Sedang Digunakan',
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    children: [
                                      _SensorMonitor(
                                        title: 'Suhu',
                                        color: CustomColor().birutua,
                                        icon: Icon(
                                          Icons.wb_sunny,
                                          size: View.blockX * 7,
                                          color: Colors.white,
                                        ),
                                      ),
                                      _SensorMonitor(
                                        title: 'Tekanan',
                                        color: CustomColor().ungu,
                                        icon: Icon(Icons.arrow_downward,
                                            size: View.blockX * 7,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    child: Column(
                                  children: [
                                    _SensorMonitor(
                                      title: 'Kelembaban',
                                      color: CustomColor().biru_ndok,
                                      icon: Icon(Icons.cloud,
                                          size: View.blockX * 7,
                                          color: Colors.white),
                                    ),
                                    _SensorMonitor(
                                      title: 'Air Flow',
                                      color: Colors.indigo,
                                      icon: Icon(Icons.ac_unit,
                                          size: View.blockX * 7,
                                          color: Colors.white),
                                    )
                                  ],
                                )),
                              ),
                            ],
                          )))
                ],
              ),
              // child: Container(
              //   child: FlatButton(
              //     onPressed: () => c.increment(),
              //     child: Obx(() => Text("Clicks: " + c.count.string)),
              //   ),
              // ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings,),
        backgroundColor: CustomColor().primary,
        onPressed: () => Get.to(SettingPage()),
      ),
    );
  }
}

class _SensorMonitor extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Icon icon;
  const _SensorMonitor({Key key,this.title,this.value, this.color, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: CustomCard2(
          title: title,
          subtitle: '00',
          icon: icon,
          color: color,
        ),
      ),
    );
  }
}