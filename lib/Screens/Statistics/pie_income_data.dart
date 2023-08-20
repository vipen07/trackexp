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


double total_income(){
  double total_value = 0;
  List<money>moneyList = list_data;

  for (var Money in moneyList) {

    int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
    if (Money.IN == 'Income') {
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


  static List<Data> getIncomeList() {
    List<Data> result = [];
    List<money> moneyList = list_data;
    double total_value_salary = 0;
    double total_value_p_income = 0;


    for (var Money in moneyList) {
      // DateTime? dateTime = Money.dateTime != null ? DateTime.parse(Money.dateTime!) : null;

      String? IN = Money.IN;
      if (IN == 'Income') {
        int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
        if (Money.name == 'Salary') {
          int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
          if (Money.IN == 'Income') {
            total_value_salary += amount!;
          }
        }
        if (Money.name == 'Passive Income') {
          int? amount = Money.amount != null ? int.parse(Money.amount!) : null;
          if (Money.IN == 'Income') {
            total_value_p_income += amount!;
          }
        }


      }
    }
    result.add(
        Data(
          name: 'Salary',
          percent: total_income()==0?0:(total_value_salary!/total_income())*100,
          // dateTime: dateTime,
          IN:'Income',
          color: Color(0xff0293ee),

        ));
    result.add(
        Data(
          name: 'Passive Income',
          percent: total_income()==0?0:(total_value_p_income!/total_income())*100,
          // dateTime: dateTime,
          IN:'Income',
          color: Color(0xfff8b250),

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