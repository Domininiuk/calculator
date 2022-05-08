/*
This model object represents a combination of all operands and operators
 */
import 'package:calculator/models/action.dart';
import 'package:calculator/models/operand.dart';
import 'package:flutter/foundation.dart';

class CalculationsModel extends ChangeNotifier {
  //
  int sum = 0;
  final List<String> actions = [];
  String currentNumber = "";
  String actionsString = "";


  // Numbers can only have one comma
  // i.e. 5.5.5 - NOT ALLOWED
  // 5.5 - ALLOWED
  // CANNOT ADD OPERATOR IF THE PREVIOUS ACTION WAS A DOT



  void addOperand(String operand) {

    if(_isOperandADot(operand) && !_isPreviousActionADigit())
      {
      }
    else {
      if(_isOperandADot(operand) &&  currentNumber.contains("."))
      {

      }
      else{
        actionsString += operand;
        currentNumber += operand;
        _addToActions(operand);
        notifyListeners();
      }
    }
  }
  bool _isOperandADot(String operand)
  {
    return operand == ".";
  }
  bool _isPreviousActionADigit()
  {
    if(actions.isNotEmpty)
      {
        var index = actions.length - 1;
        return actions[index] == '1' || actions[index] == '2' || actions[index] == '3'
            || actions[index] == '4' || actions[index] == '5' || actions[index] == '6'
            || actions[index] == '7' || actions[index] == '8' || actions[index] == '9'
            || actions[index] == '0';

      }
    return false;
  }
  //addAction

  void addOperator(String operator) {
    // If the previous character was also an operator
    //    Dont do anything

    if(operator == "=")
      {
        // Calcualte the sum
      }

    else if (!_wasPreviousActionAnOperator() && actions.isNotEmpty) {
      _clearCurrentNumber();
      _addToActions(operator);
      actionsString += operator;
      notifyListeners();
    } else if(actions.isEmpty || _wasPreviousActionAnOperator()) {



    }
  }


  bool _wasPreviousActionAnOperator() {
    if (actions.isNotEmpty) {
      var index = actions.length - 1;
      if (actions[index] == 'x' ||
          actions[index] == '-' ||
          actions[index] == '+' ||
          actions[index] == '÷') {
        return true;
      }
    }
    return false;
  }


  void _clearCurrentNumber()
  {
    currentNumber = "";

  }
  void _addToActions(String action) {
    actions.add(action);
  }
  void removeLast() {
    if (actionsString.isNotEmpty) {

      _deleteLastFromActions();
      int index = actionsString.length - 1;

      if(_isActionADigit(actionsString[index]) && currentNumber.isNotEmpty)
      {
        _deleteLastFromCurrentNumber();
      }
      actionsString = actionsString.substring(0, index);

      notifyListeners();
    }
  }


  bool _isActionADigit(String action)
  {
    return action == '1' || action == '2' || action == '3'
        || action == '4' || action== '5' || action == '6'
        || action == '7' || action == '8' || action == '9'
        || action == '0';
  }
  void _deleteLastFromCurrentNumber()
  {
    int index = currentNumber.length - 1;

    currentNumber = currentNumber.substring(0, index);
  }
  // if the last cahracter is a digit, delete it also from the currentNumber
  void _deleteLastFromActions() {
    actions.removeLast();
  }
}