@HtmlImport('td_item.html')
library todomvc.td_item;

import 'dart:async';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'todo.dart';
import 'td_input.dart';

@PolymerRegister('td-item', extendsTag: 'li')
class TodoItem extends LIElement with PolymerMixin, PolymerBase, JsProxy {
  @property
  bool editing = false;

  // Need to notify parent when we modify the item, since whether its completed
  // or not affects its visibility based on the current filter.
  @Property(notify: true)
  Todo item;

  @Property(computed: 'getClassString(editing, item.completed)')
  String classString;

  factory TodoItem() => new Element.tag('li', 'td-item');
  TodoItem.created() : super.created() {
    polymerCreated();
  }

  @reflectable
  editAction([_, __]) {
    set('editing', true);
    // schedule focus for the end of microtask, when the input will be visible
    new Future(() {}).then((_) {
      $['edit'].focus();
    });
  }

  @reflectable
  commitAction([_, __]) {
    if (editing) {
      set('editing', false);
      set('item.title', item.title.trim());
      if (item.title == '') {
        destroyAction();
      }
    }
  }

  @reflectable
  cancelAction([_, __]) {
    set('editing', false);
  }

  @reflectable
  destroyAction([_, __]) {
    fire('td-destroy-item', detail: item);
  }

  @reflectable
  String getClassString([_, __]) =>
      'view${editing ? ' editing' : ''}${item.completed ? ' completed' : ''}';
}
