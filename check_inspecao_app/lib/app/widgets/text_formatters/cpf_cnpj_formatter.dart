import 'package:flutter/services.dart';

enum TypeFormatter { Cpf, Cnpj, AnyOne }

class CpfCnpjFormatter extends TextInputFormatter {
  TypeFormatter? typeFormater;
  CpfCnpjFormatter({this.typeFormater = TypeFormatter.AnyOne});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (this.typeFormater == TypeFormatter.Cnpj)
      return _formataCnpj(oldValue, newValue);
    else if (this.typeFormater == TypeFormatter.Cpf)
      return _formataCpf(oldValue, newValue);
    else {
      return _formataCpfCnpj(oldValue, newValue);
    }
  }

  TextEditingValue _formataCpf(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length > newValue.text.length) return newValue;
    if (newValue.text.length > 14) return oldValue;
    final StringBuffer newText = StringBuffer();
    int selectionIndex = 0;
    if (newValue.text.length == 3) {
      newText.write(newValue.text + '.');
      selectionIndex = newValue.selection.end + 1;
    } else if (newValue.text.length == 7) {
      newText.write(newValue.text + '.');
      selectionIndex = newValue.selection.end + 1;
    } else if (newValue.text.length == 11) {
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

  TextEditingValue _formataCnpj(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length > newValue.text.length) return newValue;
    if (newValue.text.length > 18) return oldValue;
    final StringBuffer newText = StringBuffer();
    int selectionIndex = 0;
    if (newValue.text.length == 2) {
      newText.write(newValue.text + '.');
      selectionIndex = newValue.selection.end + 1;
    } else if (newValue.text.length == 6) {
      newText.write(newValue.text + '.');
      selectionIndex = newValue.selection.end + 1;
    } else if (newValue.text.length == 10) {
      newText.write(newValue.text + '/');
      selectionIndex = newValue.selection.end + 1;
    } else if (newValue.text.length == 15) {
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

  TextEditingValue _formataCpfCnpj(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length > newValue.text.length) return newValue;
    if (newValue.text.length > 18) return oldValue;
    final StringBuffer newText = StringBuffer();
    int selectionIndex = 0;

    if (newValue.text.length > 0 && newValue.text.length == 11) {
      selectionIndex = newValue.text.length;
      newText.write(newValue.text.substring(0, 3) + '.');
      newText.write(newValue.text.substring(3, 6) + '.');
      newText.write(newValue.text.substring(6, 9) + '-');
      newText.write(newValue.text.substring(9, 11));
      selectionIndex = selectionIndex + 3;
    } else if (newValue.text.length > 14 && newValue.text.length == 17) {
      String currentText = newValue.text;
      currentText = currentText.replaceAll('.', '');
      currentText = currentText.replaceAll('-', '');
      newValue = TextEditingValue(
        text: currentText,
        selection: TextSelection.collapsed(offset: currentText.length),
      );
      selectionIndex = newValue.text.length;

      newText.write(newValue.text.substring(0, 2) + '.');
      newText.write(newValue.text.substring(2, 5) + '.');
      newText.write(newValue.text.substring(5, 8) + '/');
      newText.write(newValue.text.substring(8, 12) + '-');
      newText.write(newValue.text.substring(12, 14));
      selectionIndex = selectionIndex + 4;
    } else {
      newText.write(newValue.text);
      selectionIndex = newValue.text.length;
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
