library todomvc.td_input;

import 'dart:html';
import 'package:polymer/polymer.dart';

@PolymerRegister('td-input', extendsTag: 'input')
class TodoInput extends InputElement with PolymerMixin, JsProxy {
  factory TodoInput() => new Element.tag('input', 'td-input');
  TodoInput.created() : super.created() {
    polymerCreated();
  }

  @Listen('keypress')
  keyPressAction(e) {
    // Listen for enter on keypress but esc on keyup, because
    // IE doesn't fire keyup for enter.
    if (e.keyCode == KeyCode.ENTER) {
      e.preventDefault();
      fire('td-input-commit');
    }
  }

  @Listen('keyup')
  keyUpAction(e) {
    if (e.keyCode == KeyCode.ESC) {
      fire('td-input-cancel');
    }
  }
}
