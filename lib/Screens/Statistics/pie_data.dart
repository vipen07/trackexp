

import 'package:flutter/material.dart';
import 'package:trackexp/Model/listdata.dart';
import 'package:trackexp/Model/money.dart';
import 'dart:math' as math;
class Data {
  String? name;
  double? percent;
  // DateTime? dateTime;
  double? total_value;
  String? IN;
  Color? color;
  Data({
    required this.name,
    required this.percent,
    // required this.dateTime,
    required this.IN,
    required this.color,
  });
}


double total_expense(){
  double total_value = 0;
  List<money>moneyList = list_data;

  for (var Money in moneyList) {

    int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
    if (Money.IN == 'Expense') {
      total_value += amount!;
    }
  }
  return total_value;
}
// List<Data> getNameAndFeeList() {
//   List<Data> result = [];
//   List<money> moneyList = getter();
//
//   for (var Money in moneyList) {
//     int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
//     DateTime? dateTime = Money.dateTime != null ? DateTime.parse(Money.dateTime!) : null;
//
//     result.add(Data(
//       name: Money.name,
//       percent: (amount!/total_expense())*100,
//       dateTime: dateTime,
//       color: const Color(0xff0293e),
//     ));
//   }
//   return result;
// }

class PieData {


  static List<Data> getNameAndFeeList() {
    List<Data> result = [];
    List<money> moneyList = list_data;
    double total_value_transportation = 0;
    double total_value_education = 0;
    double total_value_food = 0;
    double total_value_transfer = 0;

    for (var Money in moneyList) {
      // DateTime? dateTime = Money.dateTime != null ? DateTime.parse(Money.dateTime!) : null;

      String? IN = Money.IN;
      if (IN == 'Expense') {
        int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
        if (Money.name == 'Transportation') {
          int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
          if (Money.IN == 'Expense') {
            total_value_transportation += amount!;
          }
        }
        if (Money.name == 'Education') {
          int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
          if (Money.IN == 'Expense') {
            total_value_education += amount!;
          }
        }

        if (Money.name == 'Transfer') {
          int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
          if (Money.IN == 'Expense') {
            total_value_transfer += amount!;
          }
        }

        if (Money.name == 'Food') {
          int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
          if (Money.IN == 'Expense') {
            total_value_food += amount!;
          }
        }
      }
    }
      result.add(
          Data(
            name: 'transportation',
            percent: total_expense()==0?0:(total_value_transportation!/total_expense())*100,
            // dateTime: dateTime,
            IN:'Expense',
            color: Color(0xff0293ee),

          ));
      result.add(
          Data(
            name: 'education',
            percent: total_expense()==0?0:(total_value_education!/total_expense())*100,
            // dateTime: dateTime,
            IN:'Expense',
            color: Color(0xfff8b250),

          ));
      result.add(
          Data(
            name: 'transfer',
            percent: total_expense()==0?0:(total_value_transfer!/total_expense())*100,
            // dateTime: dateTime,
            IN:'Expense',
            color: Color(0xff13d38e),

          ));
      result.add(
          Data(
            name: 'food',
            percent: total_expense()==0?0:(total_value_food!/total_expense())*100,
            // dateTime: dateTime,
            IN:'Expense',
            color: Color(0xfff1eb6c),

          ));


    return result;
  }


}





// class Data {
//   final String name;
//
//   final double percent;
//
//   final Color color;
//
//   Data({required this.name, required this.percent, required this.color});
// }
// void main() {
//   PieData pieData = PieData();
//   pieData.updateDataFromMoneyList();
//
//   print(pieData.data);
// }