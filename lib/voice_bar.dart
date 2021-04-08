import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class VoiceBar extends StatefulWidget implements PreferredSizeWidget {
  VoiceBar({@required this.onCancelSearch, this.initPos});
  final VoidCallback onCancelSearch;
  final Offset initPos;
  @override
  Size get preferredSize => Size.fromHeight(56.0);
  @override
  _VoiceBarState createState() => _VoiceBarState();
}

class _VoiceBarState extends State<VoiceBar> with TickerProviderStateMixin {
  String searchQuery = '';
  AnimationController _animationController;
  bool accepted = false;

  //Mic
  Animation<double> _micTranslateTop;
  Animation<double> _micRotationFirst;
  Animation<double> _micTranslateRight;
  Animation<double> _micTranslateLeft;
  Animation<double> _micRotationSecond;
  Animation<double> _micTranslateDown;
  Animation<double> _micInsideTrashTranslateDown;

  //Trash Can
  Animation<double> _trashWithCoverTranslateTop;
  Animation<double> _trashCoverRotationFirst;
  Animation<double> _trashCoverTranslateLeft;
  Animation<double> _trashCoverRotationSecond;
  Animation<double> _trashCoverTranslateRight;
  Animation<double> _trashWithCoverTranslateDown;

  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );
    //Mic
    _micTranslateTop = Tween(begin: 0.0, end: -150.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.45, curve: Curves.easeOut),
      ),
    );
    _micRotationFirst = Tween(begin: 0.0, end: pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.2),
      ),
    );
    _micTranslateRight = Tween(begin: 0.0, end: 13.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.1),
      ),
    );
    _micTranslateLeft = Tween(begin: 0.0, end: -13.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.2),
      ),
    );
    _micRotationSecond = Tween(begin: 0.0, end: pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.45),
      ),
    );
    _micTranslateDown = Tween(begin: 0.0, end: 150.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.45, 0.79, curve: Curves.easeInOut),
      ),
    );
    _micInsideTrashTranslateDown = Tween(begin: 0.0, end: 55.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.95, 1.0, curve: Curves.easeInOut),
      ),
    );

    //Trash Can
    _trashWithCoverTranslateTop = Tween(begin: 30.0, end: -25.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.45, 0.6),
      ),
    );
    _trashCoverRotationFirst = Tween(begin: 0.0, end: -pi / 3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 0.7),
      ),
    );
    _trashCoverTranslateLeft = Tween(begin: 0.0, end: -18.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 0.7),
      ),
    );
    _trashCoverRotationSecond = Tween(begin: 0.0, end: pi / 3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.8, 0.9),
      ),
    );
    _trashCoverTranslateRight = Tween(begin: 0.0, end: 18.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.8, 0.9),
      ),
    );
    _trashWithCoverTranslateDown = Tween(begin: 0.0, end: 55.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.95, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget get buildMicAnimation => Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..translate(0.0, 10)
                      ..translate(_micTranslateRight.value)
                      ..translate(_micTranslateLeft.value)
                      ..translate(0.0, _micTranslateTop.value)
                      ..translate(0.0, _micTranslateDown.value)
                      ..translate(0.0, _micInsideTrashTranslateDown.value),
                    child: Transform.rotate(
                      angle: _micRotationFirst.value,
                      child: Transform.rotate(
                        angle: _micRotationSecond.value,
                        child: child,
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.mic,
                  color: Color(0xFFef5552),
                  size: 30,
                ),
              ),
              AnimatedBuilder(
                animation: _trashWithCoverTranslateTop,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..translate(0.0, _trashWithCoverTranslateTop.value)
                      ..translate(0.0, _trashWithCoverTranslateDown.value),
                    child: child,
                  );
                },
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _trashCoverRotationFirst,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..translate(_trashCoverTranslateLeft.value)
                            ..translate(_trashCoverTranslateRight.value),
                          child: Transform.rotate(
                            angle: _trashCoverRotationSecond.value,
                            child: Transform.rotate(
                              angle: _trashCoverRotationFirst.value,
                              child: child,
                            ),
                          ),
                        );
                      },
                      child: Image(
                        image: AssetImage('assets/trash_cover.png'),
                        width: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1.5),
                      child: Image(
                        image: AssetImage('assets/trash_container.png'),
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget mic = Padding(
      padding: EdgeInsets.only(right: 22.0),
      child: Icon(Icons.mic, size: 30, color: Colors.blue),
    );

    Widget lock = Container(
      width: 40.0,
      height: 40.0,
      margin: EdgeInsets.only(bottom: 60, left: 330),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(30),
          color: Colors.blueGrey[400]),
      child: Icon(Icons.lock_outline),
    );

    Widget unlock = Container(
      padding: EdgeInsets.only(bottom: 60),
      margin: EdgeInsets.only(right: 20),
      width: 40.0,
      height: 100.0,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(30),
          color: Colors.blueGrey[400]),
      child: Icon(Icons.lock_open, size: 20, color: Colors.white),
    );

    Widget sendDrag = Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Icon(Icons.send, size: 30, color: Colors.blue),
    );

    Widget draggableStatus = Container(
      height: 60,
      width: 60,
      margin: EdgeInsets.only(left: 320, bottom: 50),
      child: accepted == true ? Center(child: lock) : Container(),
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DragTarget(
            builder: (context, data, rejectedData) {
              return draggableStatus;
            },
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) {
              setState(() {
                accepted = true;
              });
            },
          ),
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.blueGrey[800],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    buildMicAnimation,
                    SizedBox(width: 20),
                    Text(
                      "0:00",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      color: Colors.transparent,
                      child: Text('slide to cancel',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      onPressed: () {
                        _animationController.forward();
                      },
                      onLongPress: widget.onCancelSearch,
                    ),
                    // GestureDetector(
                    //   onTap: widget.onCancelSearch,
                    //   child: Text(
                    //     "slide to cancel",
                    //     style: TextStyle(fontSize: 16, color: Colors.grey),
                    //   ),
                    // ),
                    FlatButton(
                      color: Colors.transparent,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        _animationController.forward();
                      },
                      onLongPress: widget.onCancelSearch,
                    ),
                  ],
                ),
                accepted == true
                    ? Container()
                    : Draggable(
                        axis: Axis.vertical,
                        child: mic,
                        feedback: unlock,
                        childWhenDragging: Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(Icons.send, size: 30, color: Colors.blue),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
