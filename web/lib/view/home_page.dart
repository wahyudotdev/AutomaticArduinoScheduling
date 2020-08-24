import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web/controller/warning_controller.dart';
import 'package:web/view/settings_page.dart';
import 'package:web/services/api_connect.dart';
import 'package:web/controller/sensor_controller.dart';
import 'package:web/services/view.dart';

import '../services/view.dart';

class Home extends StatelessWidget {
  // ignore: unused_field
  final SensorController _sensorController = Get.put(SensorController());
  // ignore: unused_field
  final WarningController _warningController = Get.put(WarningController());
  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 3), (timer) {
      ApiConnect().getSensor();
      ApiConnect().checkSchedule();
    });
    View().init(context);
    return GetBuilder<SensorController>(
      builder: (_) {
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
                        child: GetBuilder<WarningController>(
                          builder: (_) {
                            return CustomCard(
                              icon: Icon(
                                Icons.home,
                                color: Colors.white,
                                size: View.blockX * 5,
                              ),
                              title: 'Status Ruang',
                              subtitle: '${_.remaining}',
                              state: 1,
                            );
                          },
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
                                            value: '${_.temp} ° C',
                                            icon: Icon(
                                              Icons.wb_sunny,
                                              size: View.blockX * 7,
                                              color: Colors.white,
                                            ),
                                          ),
                                          _SensorMonitor(
                                            title: 'Tekanan (Pa)',
                                            color: CustomColor().ungu,
                                            value: '${_.press}',
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
                                          color: CustomColor().biruNdok,
                                          value: '${_.hum} %',
                                          icon: Icon(Icons.cloud,
                                              size: View.blockX * 7,
                                              color: Colors.white),
                                        ),
                                        _SensorMonitor(
                                          title: 'Air Flow',
                                          color: Colors.indigo,
                                          value: '${_.air}',
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
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.settings,
              ),
              backgroundColor: CustomColor().primary,
              onPressed: () => Get.to(SettingPage())),
        );
      },
    );
  }
}

class _SensorMonitor extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Icon icon;
  const _SensorMonitor({Key key, this.title, this.value, this.color, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: CustomCard2(
          title: title,
          subtitle: value,
          icon: icon,
          color: color,
        ),
      ),
    );
  }
}
