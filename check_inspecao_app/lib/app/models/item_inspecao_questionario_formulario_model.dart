import 'package:check_inspecao_app/app/models/item_inspecao_model.dart';

class ItemInspecaoQuestionarioFormulario {
  int? itemInspecaoId;
  ItemInspecaoModel? itemInspecao;
  int? questionarioFormularioId;

  ItemInspecaoQuestionarioFormulario({this.itemInspecaoId, this.itemInspecao, this.questionarioFormularioId});

  ItemInspecaoQuestionarioFormulario.fromJson(Map<String, dynamic> json) {
    itemInspecaoId = json['itemInspecaoId'];
    itemInspecao = json['itemInspecao'] != null ? new ItemInspecaoModel.fromJson(json['itemInspecao']) : null;
    questionarioFormularioId = json['questionarioFormularioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemInspecaoId'] = this.itemInspecaoId ?? 0;
    if (this.itemInspecao != null) {
      data['itemInspecao'] = this.itemInspecao!.toJson();
    }
    data['questionarioFormularioId'] = this.questionarioFormularioId ?? 0;
    return data;
  }
}
