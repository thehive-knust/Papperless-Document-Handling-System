import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget timeBadge(DateTime time) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      padding: EdgeInsets.all(4),
      child: Text(DateFormat("d MMMM, y   h:m a")
                                    .format(time),),
    );
