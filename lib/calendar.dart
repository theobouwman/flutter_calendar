library calendar;

import 'dart:async';

import 'package:calendar/item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

enum DateFormat { English, European }

typedef Widget RenderItem(Item item);

class Calendar extends StatefulWidget {
  final String title;
  final List<Item> items;
  final DateFormat dateFormat;
  final Widget emptyWidget;
  final RenderItem renderItem;

  Calendar(
      this.items, this.renderItem, this.emptyWidget,
      {this.title, this.dateFormat = DateFormat.European})
      : assert(items != null),
        assert(renderItem != null),
        assert(emptyWidget != null);

  @override
  _CalendarState createState() => new _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Item> _getItemsPerDate(DateTime t) {
    List<Item> items = new List();

    widget.items.forEach((i) {
      if (i.startDate.year == t.year &&
          i.startDate.month == t.month &&
          i.startDate.day == t.day) {
        items.add(i);
      }
    });

    return items;
  }

  String _getDateFormat(DateTime d) {
    return widget.dateFormat == DateFormat.European
        ? "${d.day.toString()}/${d.month.toString()}"
        : "${d.month.toString()}/${d.day.toString()}";
  }

  Future<Null> _openInfoDialog(BuildContext context) async {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      child: new AlertDialog(
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(
                "Why are there so few days displayed?",
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
              new Text(
                'We only show the dates with upcoming events/ appointments',
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = new List();

    if (widget.items.length > 0) {
      var startRange = widget.items[0].startDate;
      var endRange = widget.items[widget.items.length - 1].startDate;
      for (var n = startRange;
          n.isBefore(endRange) || n == endRange;
          n = n.add(new Duration(days: 1))) {
        dates.add(n);
      }
    }

    Color backgroundColor = Theme.of(context).primaryColor;
    Color textColor = Colors.white;

    return new DefaultTabController(
      length: dates.length,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: backgroundColor,
          title: new Text(
            widget.title == null ? "Calendar" : widget.title,
            style: new TextStyle(color: textColor),
          ),
          actions: [
            new IconButton(
              icon: new Icon(
                Icons.info,
                color: textColor,
              ),
              onPressed: () {
                _openInfoDialog(context);
              },
            )
          ],
          bottom: new TabBar(
              isScrollable: true,
              tabs: dates.map((d) {
                return new Tab(
                  text: _getDateFormat(d),
                );
              }).toList()),
        ),
        body: new TabBarView(
          children: dates.map((d) {
            List<Item> items = _getItemsPerDate(d);
            return items == null || items.length == 0
                ? widget.emptyWidget
                : new ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return widget.renderItem(items[index]);
                    },
                    itemCount: items.length,
                  );
          }).toList(),
        ),
      ),
    );
  }
}
