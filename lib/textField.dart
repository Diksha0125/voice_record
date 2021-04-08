import 'package:flutter/material.dart';
import 'package:text_voice_record/painter.dart';
import 'package:text_voice_record/voice_bar.dart';

class CustomTxtField extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  _CustomTxtFieldState createState() => _CustomTxtFieldState();
}

class _CustomTxtFieldState extends State<CustomTxtField>
    with SingleTickerProviderStateMixin {
  double rippleStartX, rippleStartY;
  bool isOpened = false;
  AnimationController _controller;
  Animation _animation;
  bool isInVoiceRecordMode = false;

  @override
  initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener(animationStatusListener);
  }

  animationStatusListener(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      setState(() {
        isInVoiceRecordMode = true;
      });
    }
  }

  void onSearchTapUp(TapUpDetails details) {
    setState(() {
      rippleStartX = details.globalPosition.dx;
      rippleStartY = details.globalPosition.dy;
    });

    print("pointer location $rippleStartX, $rippleStartY");
    _controller.forward();
  }

  cancelSearch() {
    setState(() {
      isInVoiceRecordMode = false;
    });
    _controller.forward();
    _controller.reset();
  }

  onPress() {}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(children: [
      Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
          height: 60,
          width: double.infinity,
          color: Colors.blueGrey[800],
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Container(
                  child: Icon(Icons.add, color: Colors.white, size: 34),
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.file_present),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15),
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                      onLongPress: () {
                        setState(() {
                          //  _showBottom = true;
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      child: IconButton(
                        icon: Icon(
                          Icons.keyboard_voice_outlined,
                          color: Colors.white,
                        ),
                      ),
                      onTapUp: onSearchTapUp,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: MyPainter(
              containerHeight: widget.preferredSize.height,
              center: Offset(rippleStartX ?? 0, rippleStartY ?? 0),
              radius: _animation.value * screenWidth,
              context: context,
            ),
          );
        },
      ),
      isInVoiceRecordMode
          ? (VoiceBar(
              onCancelSearch: cancelSearch,
            ))
          : (Container())
    ]);
  }
}
