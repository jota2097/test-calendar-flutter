import 'package:flutter/material.dart';
import 'package:test_calendar/components/calendar/src/styles/day_bar.dart';
import 'package:test_calendar/components/calendar/src/utils/utils.dart';
import 'package:test_calendar/components/calendar/src/widgets/zoomable_header_widget.dart';

/// A bar which is showing a day.
class DayBar extends StatelessWidget {
  /// The date.
  final DateTime date;

  /// The widget style.
  final DayBarStyle style;

  /// The widget height.
  final double? height;

  /// The width width.
  final double? width;

  /// Triggered when the day bar has been tapped down.
  final DayBarTapCallback? onDayBarTappedDown;

  final OnchangeDateCallback? onChangeDate;

  /// Creates a new day bar instance.
  DayBar(
      {required DateTime date,
      required this.style,
      this.height,
      this.width,
      this.onDayBarTappedDown,
      this.onChangeDate})
      : date = date.yearMonthDay;

  /// Creates a new day bar instance from a headers widget instance.
  DayBar.fromHeadersWidgetState({
    required ZoomableHeadersWidget parent,
    required DateTime date,
    required DayBarStyle style,
    double? width,
  }) : this(
            date: date,
            style: style,
            height: parent.style.headerSize,
            width: width,
            onDayBarTappedDown: parent.onDayBarTappedDown,
            onChangeDate: parent.onChangeDate);

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTapDown: (details) => (onDayBarTappedDown ?? (date) {})(date),
      onTap: () => ((date) {})(date),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => (onChangeDate ??
                () {})(new DateTime(date.year, date.month, date.day - 1)),
          ),
          Container(
            // color: style.decoration == null ? style.color : null,
            decoration: style.decoration,
            alignment: style.textAlignment,
            child: Text(
              style.dateFormatter(date.year, date.month, date.day),
              style: style.textStyle,
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () => (onChangeDate ??
                () {})(new DateTime(date.year, date.month, date.day + 1)),
          ),
        ],
      ));
}
