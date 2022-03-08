import 'package:check_inspecao_app/app/models/item_inspecao_questionario_formulario_model.dart';

class QuestionarioFormularioModel {
  late int? id;
  late String? descricao;
  late List<ItemInspecaoQuestionarioFormulario>? itensQuestionario;
  late bool isInativo;

  QuestionarioFormularioModel({this.id, this.descricao, this.isInativo = false, this.itensQuestionario});

  factory QuestionarioFormularioModel.fromJson(Map<String, dynamic> json) {
    var itens = <ItemInspecaoQuestionarioFormulario>[];
    if (json['itensQuestionario'] != null) {
      for (var item in json['itensQuestionario']) {
        itens.add(ItemInspecaoQuestionarioFormulario.fromJson(item));
      }
    }
    return QuestionarioFormularioModel(
      id: json['id'],
      descricao: json['descricao'],
      isInativo: json['isInativo'],
      itensQuestionario: itens,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id ?? 0,
      'descricao': descricao,
      'isInativo': isInativo,
      'itensQuestionario': itensQuestionario,
    };

    return data;
  }
}
