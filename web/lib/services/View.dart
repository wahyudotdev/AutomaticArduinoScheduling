import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
  final bool state;
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
        borderRadius: BorderRadius.circular(10),
        color: widget.state == true
            ? Colors.blue.withOpacity(0.5)
            : CustomColor().primaryDark,
      ),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        leading: widget.icon,
        title: Text(widget.title,
            style: TextStyle(fontSize: View.blockX * 6, color: Colors.white)),
        subtitle: Text(
          widget.subtitle,
          style: TextStyle(fontSize: View.blockX * 4, color: Colors.white),
        ),
        onTap: widget.function,
      ),
    );
  }
}
