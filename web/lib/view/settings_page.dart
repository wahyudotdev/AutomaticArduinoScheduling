import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/controller/relay_controller.dart';
import 'package:web/controller/schedule_controller.dart';
import 'package:web/services/api_connect.dart';

import '../services/view.dart';

class SettingPage extends StatelessWidget {
  // ignore: unused_field
  final ScheduleController _scheduleController = Get.put(ScheduleController());
  // ignore: unused_field
  final RelayController _relayController = Get.put(RelayController());
  @override
  Widget build(BuildContext context) {
    View().init(context);
    ApiConnect().getSchedule();
    ApiConnect().getRelay();
    return Scaffold(
      backgroundColor: CustomColor().primary,
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: Stack(
        children: [
          Positioned(
              top: View.blockY * 1,
              right: View.blockX * 6,
              width: View.blockX * 40,
              height: View.blockY * 10,
              child: Text(
                'Jadwal',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontSize: View.blockX * 2),
                textAlign: TextAlign.end,
              )),
          Positioned(
              top: View.blockY * 10,
              right: View.blockX * 5,
              width: View.blockX * 40,
              height: View.blockY * 70,
              child: GetBuilder<ScheduleController>(
                builder: (_) {
                  if (_.date.isNullOrBlank || _.date.length == 0)
                    return Text(
                      'Belum ada jadwal',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: View.blockX * 3),
                    );
                  else
                    return ListView.builder(
                      itemCount: _.date.length,
                      itemBuilder: (context, index) {
                        return _CustomCard(
                          title: '${_.date[index]}',
                          icon: Icon(
                            Icons.date_range,
                            color: Colors.white,
                            size: View.blockX * 5,
                          ),
                          subtitle: '${_.time[index]}',
                          state: _.isOn[index],
                          function: () => Get.defaultDialog(
                            title: 'Hapus Jadwal?',
                            content: Text('Anda akan menghapus jadwal'),
                            confirm: FlatButton(
                                onPressed: () {
                                  Get.back();
                                  // Get.snackbar('Peringatan !', 'Data Terhapus');
                                  ApiConnect().deleteSchedule(_.waktu[index]);
                                },
                                child: Text('Hapus')),
                            cancel: FlatButton(
                                onPressed: () => Get.back(),
                                child: Text('Batal')),
                            buttonColor: CustomColor().primary,
                          ),
                        );
                      },
                    );
                },
              )),
          Positioned(
            top: View.blockY * 10,
            left: View.blockX * 5,
            width: View.blockX * 40,
            height: View.blockY * 80,
            child: GetBuilder<RelayController>(
              builder: (_) {
                return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: [
                    _Button(
                      title: 'RELAY 1',
                      state: _.relay1,
                      function: () => ApiConnect().setRelay(1),
                    ),
                    _Button(
                      title: 'RELAY 2',
                      state: _.relay2,
                      function: () => ApiConnect().setRelay(2),
                    ),
                    _Button(
                      title: 'RELAY 3',
                      state: _.relay3,
                      function: () => ApiConnect().setRelay(3),
                    ),
                    _Button(
                      title: 'RELAY 4',
                      state: _.relay4,
                      function: () => ApiConnect().setRelay(4),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: View.blockY * 75,
            left: View.blockX * 5,
            width: View.blockX * 40,
            height: View.blockY * 10,
            child: Container(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: FlatButton(
                  onPressed: () {
                    ApiConnect().allPowerOff();
                    Get.snackbar('Peringatan !!!', 'Semua Alat Telah Dimatikan',
                        colorText: Colors.white, backgroundColor: Colors.red);
                  },
                  color: Colors.red,
                  child: Text(
                    'ALL POWER OFF',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: View.blockX * 3,
                    ),
                  )),
            ),
          )
        ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: CustomColor().biruNdok,
        closeManually: false,
        child: Icon(Icons.add),
        children: [
          SpeedDialChild(
              child: Icon(Icons.check_circle_outline),
              onTap: () => DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime(2021, 12, 31),
                  onConfirm: (time) => ApiConnect().addSchedule(time, '1'),
                  currentTime: DateTime.now()),
              backgroundColor: CustomColor().biruNdok,
              label: 'Tambah Jadwal Nyala'),
          SpeedDialChild(
              child: Icon(Icons.highlight_off),
              onTap: () => DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime(2021, 12, 31),
                  onConfirm: (time) => ApiConnect().addSchedule(time, '0'),
                  currentTime: DateTime.now()),
              backgroundColor: Colors.redAccent,
              label: 'Tambah Jadwal Mati')
        ],
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  final String title, subtitle;
  final Icon icon;
  final Function function;
  final Function longpress;
  final int state;
  const _CustomCard(
      {Key key,
      this.title,
      this.icon,
      this.function,
      this.longpress,
      this.subtitle,
      this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey,
            blurRadius: 7,
            spreadRadius: 3,
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: state == 1 ? CustomColor().biruNdok : Colors.red,
      ),
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: View.blockX * 2, color: Colors.white),
          textAlign: TextAlign.start,
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
              fontSize: View.blockX * 3, color: Colors.white),
        ),
        onTap: function,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function function;
  final int state;
  const _Button({Key key, this.title, this.icon, this.function, this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: state == 1 ? CustomColor().biruNdok : Colors.redAccent,
          borderRadius: BorderRadius.circular(10)),
      child: FlatButton(
        child: Text(
          title,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: View.blockX * 3),
          textAlign: TextAlign.center,
        ),
        onPressed: function,
      ),
    );
  }
}
