import 'package:check_inspecao_app/app/custom_exceptions/exception_app.dart';
import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/models/item_inspecao_model.dart';
import 'package:check_inspecao_app/app/models/item_inspecao_questionario_formulario_model.dart';
import 'package:check_inspecao_app/app/models/questionario_formulario_model.dart';
import 'package:check_inspecao_app/app/models/store_base.dart';
import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_controller.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'questionario_controller.g.dart';

class QuestionarioController = _QuestionarioControllerBase with _$QuestionarioController;

abstract class _QuestionarioControllerBase with Store {
  final _service = Modular.get<CheckInspecaoService>();

  @observable
  ExceptionApp? exceptionApp;
  @observable
  bool loading = false;
  @action
  setLoading(bool value) => loading = value;

  @observable
  bool todosSelecionados = false;

  @computed
  bool? get itemChecked {}
  var questionarios = ObservableList<QuestionarioFormularioModel>();

  @observable
  var itensSelecaoTela = ObservableMap<int, dynamic>.of({});

  List<ItemInspecaoQuestionarioFormulario>? get listaItensSelecionados =>
      questionarioSelecionado?.itensQuestionario;
  @computed
  set itemInspecaoSelecionado(ItemInspecaoModel value) {
    var itemFormulario = ItemInspecaoQuestionarioFormulario(
        itemInspecao: value, itemInspecaoId: value.id, questionarioFormularioId: questionarioSelecionado?.id);
    questionarioSelecionado!.itensQuestionario?.add(itemFormulario);
    var item =
        itensSelecaoTela.values.firstWhere((element) => element['item'].id == itemFormulario.itemInspecaoId);
    item['checked'] = true;

    itensSelecaoTela = itensSelecaoTela;
    questionarioSelecionado = questionarioSelecionado;
  }

  @computed
  set itemInspecaoRemovido(ItemInspecaoModel value) {
    var itemExclusao = questionarioSelecionado!.itensQuestionario
        ?.firstWhere((element) => element.itemInspecaoId == value.id);
    questionarioSelecionado!.itensQuestionario?.remove(itemExclusao);

    var item = itensSelecaoTela.values.firstWhere((element) => element['item'].id == value.id);
    item['checked'] = false;

    itensSelecaoTela = itensSelecaoTela;
    questionarioSelecionado = questionarioSelecionado;
  }

  @observable
  QuestionarioFormularioModel? questionarioSelecionado;

  final txtCtrlDescricao = TextEditingController();

  bool _isInativoValue = false;

  bool? get isInativo => _isInativoValue;

  @computed
  set setisInativo(bool value) {
    _isInativoValue = value;
    questionarioSelecionado?.isInativo = value;
    questionarioSelecionado = questionarioSelecionado;
  }

  @action
  buscarQuestionarios() async {
    setLoading(true);
    var lista = await _service.getQuestionarios();
    questionarios.clear();
    for (var item in lista) {
      questionarios.add(item);
    }
    setLoading(false);
  }

  @action
  novoQuestionario() async {
    questionarioSelecionado = null;
    questionarioSelecionado = QuestionarioFormularioModel();
    questionarioSelecionado?.itensQuestionario = <ItemInspecaoQuestionarioFormulario>[];
    txtCtrlDescricao.clear();

    Modular.to.pushNamed<int>('/Questionarios/Editar');
  }

  @action
  editarQuestionario() async {
    if (questionarioSelecionado != null) {
      txtCtrlDescricao.text = questionarioSelecionado?.descricao ?? '';
      Modular.to.pushNamed<int>('/Questionarios/Editar');
    }
  }

  @action
  salvarQuestionario() async {
    try {
      if (questionarioSelecionado == null) return;
      questionarioSelecionado?.descricao = txtCtrlDescricao.text;
      var value = await _service.salvarQuestionarioFormmulario(questionarioSelecionado!);
      if (value != null) buscarQuestionarios();
      Modular.to.pop();
    } catch (e) {
      exceptionApp = ExceptionApp(e.toString());
    }
  }

  @action
  addNovoItemQuestionario() async {
    var grupoId = await Modular.to.pushNamed<int>('/Grupos/false');
    if (grupoId != null) {
      SubGruposController subGrupoStore = Modular.get();
      await subGrupoStore.buscarItens(GrupoModel(id: grupoId));
      itensSelecaoTela.clear();
      int index = 0;
      for (var item in subGrupoStore.itens) {
        var checked =
            questionarioSelecionado?.itensQuestionario?.any((element) => element.itemInspecaoId == item.id);
        itensSelecaoTela[index] = {'checked': checked ?? false, 'item': item};
        index++;
      }

      Modular.to.pushNamed('/Questionarios/Selecao');
    }
  }

  @action
  selecionarTodos() {
    todosSelecionados = !todosSelecionados;
    for (var item in itensSelecaoTela.values) {
      var selecionado = item['item'];
      item['checked'] = todosSelecionados;
      if (todosSelecionados) {
        itemInspecaoSelecionado = selecionado;
      } else {
        itemInspecaoRemovido = selecionado;
      }
    }
  }
}
