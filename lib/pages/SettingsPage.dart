import 'package:flutter/material.dart';
import 'package:flutter_whatson/constants/Constants.dart';
import 'package:flutter_whatson/events/LogoutEvent.dart';
import '../util/DataUtils.dart';

class SettingsPage extends StatelessWidget {
  static const String TAG_START = "startDivider";
  static const String TAG_END = "endDivider";
  static const String TAG_CENTER = "centerDivider";
  static const String TAG_BLANK = "blankDivider";

  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  final titleTextStyle = new TextStyle(fontSize: 16.0);
  final rightArrowIcon = new Image.asset(
    'images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );

  List listData = [];

  SettingsPage() {
    listData.add(TAG_BLANK);
    listData.add(TAG_START);
    listData.add(new ListItem(title: 'Account Setting', icon: 'images/ic_discover_nearby.png'));
    listData.add(TAG_CENTER);
    listData.add(new ListItem(title: 'payment Setting', icon: 'images/ic_discover_nearby.png'));
    listData.add(TAG_CENTER);
    listData.add(new ListItem(title: 'Application Setting', icon: 'images/ic_discover_nearby.png'));
    listData.add(TAG_END);
  }

  Widget getIconImage(path) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child: new Image.asset(path,
          width: IMAGE_ICON_WIDTH, height: IMAGE_ICON_WIDTH),
    );
  }

  _renderRow(BuildContext ctx, int i) {
    var item = listData[i];
    if (item is String) {
      Widget w = new Divider(
        height: 1.0,
      );
      switch (item) {
        case TAG_START:
          w = new Divider(
            height: 1.0,
          );
          break;
        case TAG_END:
          w = new Divider(
            height: 1.0,
          );
          break;
        case TAG_CENTER:
          w = new Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
            child: new Divider(
              height: 1.0,
            ),
          );
          break;
        case TAG_BLANK:
          w = new Container(
            height: 20.0,
          );
          break;
      }
      return w;
    } else if (item is ListItem) {
      var listItemContent = new Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: new Row(
          children: <Widget>[
            getIconImage(item.icon),
            new Expanded(
                child: new Text(
              item.title,
              style: titleTextStyle,
            )),
            rightArrowIcon
          ],
        ),
      );
      return new InkWell(
        onTap: () {
          String title = item.title;
          if (title == 'Settings') {
            DataUtils.clearLoginInfo().then((arg) {
              Navigator.of(ctx).pop();
              Constants.eventBus.fire(new LogoutEvent());
              print("event fired!");
            });
          } else if (title == 'Settings') {
            Navigator.push(ctx, new MaterialPageRoute(builder: (ctx) {
              return new Container();
            }));
          }
        },
        child: listItemContent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings", style: new TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new ListView.builder(
        itemBuilder: (ctx, i) => _renderRow(ctx, i),
        itemCount: listData.length,
      ),
    );
  }
}

class ListItem {
  String icon;
  String title;
  ListItem({this.icon, this.title});
}
