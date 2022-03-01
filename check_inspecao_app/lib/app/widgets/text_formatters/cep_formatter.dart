import 'package:flutter/services.dart';

class CepFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length > newValue.text.length) return newValue;
    if (newValue.text.length > 10) return oldValue;
    final StringBuffer newText = StringBuffer();
    int selectionIndex = 0;
    if (newValue.text.length == 2) {
      newText.write(newValue.text + '.');
      selectionIndex = newValue.selection.end + 1;
    } else if (newValue.text.length == 6) {
      newText.write(newValue.text + '-');
      selectionIndex = newValue.selection.end + 1;
    } else {
      newText.write(newValue.text);
      selectionIndex = newValue.selection.end;
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
