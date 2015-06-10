@HtmlImport('td_item.html')
library todomvc.td_item;

import 'dart:async';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'todo.dart';
import 'td_input.dart';

@PolymerElement('td-item', extendsTag: 'li')
class TodoItem extends LIElement with PolymerJsMixin, JsProxy {
  @Property(notify: true) bool editing = false;
  @Property(notify: true) Todo item;

  factory TodoItem() => new Element.tag('li', 'td-item');
  TodoItem.created() : super.created() {
    polymerCreated();
    on['blur'].listen(commitAction);
  }

  @eventHandler
  editAction([_, __]) {
    set('editing', true);
    // schedule focus for the end of microtask, when the input will be visible
    new Future(() {}).then((_) {
      $['edit'].focus();
    });
  }

  @eventHandler
  commitAction([_, __]) {
    if (editing) {
      set('editing', false);
      set('item.title', item.title.trim());
      if (item.title == '') {
        destroyAction();
      }
    }
  }

  @eventHandler
  cancelAction([_, __]) {
    set('editing', false);
  }

  @eventHandler
  destroyAction([_, __]) {
    fire('td-destroy-item', detail: item);
  }
}
