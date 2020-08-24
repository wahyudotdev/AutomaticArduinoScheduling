import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class View {
  MediaQueryData _mediaQueryData;
  static double x;
  static double y;
  static double blockX;
  static double blockY;
  void init(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _mediaQueryData = MediaQuery.of(context);
    x = _mediaQueryData.size.width;
    y = _mediaQueryData.size.height;
    blockX = x / 100;
    blockY = y / 100;
  }
}

class CustomColor {
  final text = Color(0xFFFFFFFF);
  final primary = Color(0xFF172F37);
  final primary80 = Color(0xF0172F37);
  final primaryDark = Color(0xFF08191F);
  final biruNdok = Color(0xFF1B6965);
  final ungu = Color(0xFF5F2D5A);
  final birutua = Color(0xFF212459);
}

class CustomText {
  final buttontext = TextStyle(color: Colors.white, fontSize: View.blockX * 4);
}

class Button extends StatelessWidget {
  final String action;
  final Function function;
  const Button({Key key, this.action, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: CustomColor().primary.withOpacity(0.4)),
      child: FlatButton(
        child: Text(
          action,
          style: CustomText().buttontext,
        ),
        onPressed: function,
      ),
    );
  }
}

class CustomCard extends StatefulWidget {
  final String title, subtitle;
  final Icon icon;
  final Function function;
  final Function longpress;
  final int state;
  const CustomCard(
      {Key key,
      this.title,
      this.icon,
      this.function,
      this.longpress,
      this.subtitle,
      this.state})
      : super(key: key);
  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 7,
            spreadRadius: 3,
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: widget.state == 0 ? Colors.red : CustomColor().biruNdok,
      ),
      margin: EdgeInsets.all(5),
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

class CustomCard2 extends StatefulWidget {
  final String title, subtitle;
  final Icon icon;
  final Function function;
  final Function longpress;
  final Color color;
  const CustomCard2(
      {Key key,
      this.title,
      this.icon,
      this.function,
      this.longpress,
      this.subtitle,
      this.color})
      : super(key: key);
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color,
      ),
      margin: EdgeInsets.all(5),
      child: ListTile(
        leading: widget.icon,
        title: Text(widget.title,
            style: GoogleFonts.poppins(
                fontSize: View.blockX * 2, color: Colors.white)),
        subtitle: Text(widget.subtitle,
            style: GoogleFonts.poppins(
                fontSize: View.blockX * 4, color: Colors.white)),
        onTap: widget.function,
      ),
    );
  }
}
