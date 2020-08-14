import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'services/View.dart';
import 'services/View.dart';
import 'services/View.dart';

class SettingPage extends StatelessWidget {
  // List<String> tanggal = ['14 Aug 2020'];
  List<String> jam = ['17.52', '20.52'];
  @override
  Widget build(BuildContext context) {
    View().init(context);
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
                'Terjadwal',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontSize: View.blockX * 2),
                textAlign: TextAlign.end,
              )),
          Positioned(
            top: View.blockY * 10,
            right: View.blockX * 5,
            width: View.blockX * 40,
            height: View.blockY * 70,
            child: ListView.builder(
              itemCount: jam.length,
              itemBuilder: (context, index) {
                return _CustomCard(
                  title: DateTime.now().toLocal().toString().split(' ')[0],
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.white,
                    size: View.blockX * 5,
                  ),
                  subtitle: '${jam[index]}',
                );
              },
            ),
          ),
          Positioned(
            top: View.blockY * 10,
            left: View.blockX * 5,
            width: View.blockX * 40,
            height: View.blockY * 80,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3/2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: [
                _Button(color: CustomColor().biru_ndok,title: 'RELAY 1',),
                _Button(color: CustomColor().biru_ndok,title: 'RELAY 2',),
                _Button(color: CustomColor().biru_ndok,title: 'RELAY 3',),
                _Button(color: CustomColor().biru_ndok,title: 'RELAY 4',),
              ],
            ),
          ),
          Positioned(
            top: View.blockY * 75,
            left: View.blockX * 5,
            width: View.blockX * 40,
            height: View.blockY * 10,
            child: Container(
              decoration: BoxDecoration(
                color: CustomColor().biru_ndok
              ),
              child: FlatButton(
                onPressed: () => null,
                color: CustomColor().biru_ndok,
                child: Text('ALL POWER OFF',style: GoogleFonts.poppins(color:Colors.white,fontSize: View.blockX*3,),)
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Get.snackbar('title', 'message', colorText: Colors.white),
        label: Text('Tambah Jadwal'),
        icon: Icon(Icons.add),
        backgroundColor: CustomColor().primary,
      ),
    );
  }
}

class _CustomCard extends StatefulWidget {
  final String title, subtitle;
  final Icon icon;
  final Function function;
  final Function longpress;
  final bool state;
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
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<_CustomCard> {
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
        color: widget.state == true
            ? Colors.blue.withOpacity(0.5)
            : CustomColor().primaryDark,
      ),
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: widget.icon,
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
              fontSize: View.blockX * 2, color: Colors.white),
          textAlign: TextAlign.start,
        ),
        subtitle: Text(
          widget.subtitle,
          style: GoogleFonts.poppins(
              fontSize: View.blockX * 3, color: Colors.white),
        ),
        onTap: widget.function,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color color;
  const _Button({Key key, this.title, this.icon, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: FlatButton(
        child: Text(
          title,
          style: GoogleFonts.poppins(color:Colors.white,fontSize:View.blockX*3),
          textAlign: TextAlign.center,
        ),
        onPressed: ()=>null,
      ),
    );
  }
}
