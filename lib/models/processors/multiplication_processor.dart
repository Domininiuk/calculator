import 'package:calculator/models/calculations.dart';
import 'package:calculator/models/processors/calculation_processor.dart';
import 'package:rational/rational.dart';
class MultiplicationProcessor implements CalculationProcessor{
  MultiplicationProcessor(this._calculations);
  final CalculationsModel _calculations;

  @override
  CalculationsModel process() {
    if (_isCurrentNumberTripleDigitOrLonger()) {
      _processTripleDigitOrLongerNumber();
    } else if (_isCurrentNumberDoubleDigit()) {
      _processDoubleDigitNumber();
    } else if (_isCurrentNumberSingleDigit()) {
      _processSingleDigitNumber();
    }
    return _calculations;
  }

  bool _isCurrentNumberTripleDigitOrLonger() {
    return _calculations.isCurrentNumberTripleDigitOrLonger();
  }

  void _processTripleDigitOrLongerNumber() {
    if (_isCurrentNumberSmallerThanOne() && !_isCurrentNumberAllZeroes()) {
      _updateResultOfCalculations();
      multiplyResultOfCalculations();
    } else if (_isCurrentNumberAllZeroes()) {
      _doNothing();
    } else {
      _reverseCalculationOfAllPreviousDigits();
      multiplyResultOfCalculations();
    }
  }

  bool _isCurrentNumberAllZeroes() {
    return _calculations.isCurrentNumberAllZeroes();
  }

  void _updateResultOfCalculations() {
    _calculations.updateResultOfCalculations();
  }

  bool _isCurrentNumberDoubleDigit() {
    return _calculations.isCurrentNumberDoubleDigit();
  }

  void _reverseCalculationOfAllPreviousDigits() {
    _calculations.divideResultOfCalculations(_calculations
        .currentNumber
        .substring(0, _calculations.currentNumber.length - 1));

  }

  bool _isCurrentNumberSmallerThanOne() {
    return _calculations.isCurrentNumberSmallerThanOne();
  }

  void _processDoubleDigitNumber() {
    if (_isFirstDigitZero()) {
      _doNothing();
    } else {
      reverseCalculationOfFirstDigit();
      multiplyResultOfCalculations();
    }
  }

  void reverseCalculationOfFirstDigit() {
    _calculations.divideResultOfCalculations(_calculations.currentNumber[0]);
  }

  void _doNothing() {}

  bool _isFirstDigitZero() {
    return _calculations.isFirstDigitZero();
  }

  bool _isCurrentNumberSingleDigit() {
    return _calculations.isCurrentNumberSingleDigit();
  }

  void _processSingleDigitNumber() {
    if (_isCurrentNumberZero()) {
      _updateFormerResult();
    }
    multiplyResultOfCalculations();
  }

  bool _isCurrentNumberZero() {
    return _calculations.isCurrentNumberZero();
  }

  void _updateFormerResult() {
    _calculations.updateFormerResult();
  }

  void multiplyResultOfCalculations() {
    _calculations.multiplyResultOfCalculations(_calculations.currentNumber);
  }
}
