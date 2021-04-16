import 'package:flutter/material.dart';
import 'package:milk_register/models/Milk.dart';

import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'Databasehelper.dart';

class calculator {
  Future<double> get(String month,String year) async {
    print(month);
    print (year);
    DatabaseHelper dbh = DatabaseHelper();
    Database db = await dbh.database;
    print('db done  calctr');
    //List<double> y= List<double>();
    double count = 0.0;
    List<Milk> x = await dbh.getMilkList();
    for (Milk m in x) {
      print('in loop');
      if (((m.month == month) && (m.year == year))) {
        print('true');
        print(m.q);
        count += m.q;
      }
    }
    return count;
  }

  Future<double> getcost(String month,String year,double cost) async
  {  double x= await get(month,year);
    return   (x*cost);

  }
}