@HtmlImport('td_todos.html')
library todomvc.td_todos;

import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'td_input.dart';
import 'td_item.dart';
import 'todo.dart';

@PolymerRegister('td-todos')
class TodoList extends PolymerElement {
  @Property(computed: 'isZero(completedCount)')
  bool completedEmpty;

  @Property(computed: 'itemsIsNotEmpty(items.*)')
  bool anyItems;

  @Property(observer: 'itemsChanged')
  List<Todo> items;

  @Property(observer: 'storageIdChanged')
  String storageId = 'storage';

  @Property(computed: 'countCompleted(items.*)')
  int completedCount;

  @Property(computed: 'countActive(items.*)')
  int activeCount;

  @Property(computed: 'checkAllCompleted(completedCount, activeCount)')
  bool allCompleted;

  @Property(computed: 'getActiveItemWord(activeCount)')
  String activeItemWord;

  @Property(observer: 'filterChanged')
  String filter = window.location.hash.replaceFirst('#', '');

  Storage storage = window.localStorage;

  final filters = {
    'active': (item) => !item.completed,
    'completed': (item) => item.completed,
  };

  factory TodoList() => new Element.tag('td-todos');
  TodoList.created() : super.created();

  ready() {
    window.onHashChange.listen((_) {
      set('filter', window.location.hash.replaceFirst('#', ''));
    });
  }

  TodoInput get _newTodo => $['new-todo'];

  @eventHandler
  bool itemsIsNotEmpty() => items.isNotEmpty;

  @eventHandler
  bool isZero(int value) => value == 0;

  @eventHandler
  void addTodoAction() {
    newItem(_newTodo.value);
    _newTodo.value = '';
  }

  @eventHandler
  void cancelAddTodoAction() {
    _newTodo.value = '';
  }

  @eventHandler
  void destroyItemAction(e, detail) {
    destroyItem(detail);
  }

  @eventHandler
  void toggleAllCompletedAction(e) {
    setItemsCompleted(e.target.checked);
  }

  @eventHandler
  void clearCompletedAction() {
    clearItems();
  }

  @eventHandler
  int countActive() => items.where(filters['active']).length;

  @eventHandler
  int countCompleted() => items.where(filters['completed']).length;

  @eventHandler
  bool checkAllCompleted() {
    return completedCount > 0 && activeCount == 0;
  }

  @eventHandler
  String getActiveItemWord() => activeCount == 1 ? 'item' : 'items';

  @Observe('items.*')
  void itemsChanged() {
    if (storageId != null) {
      storage[storageId] = JSON.encode(items);
    }
  }

  @eventHandler
  void storageIdChanged() {
    _setItems();
  }

  @eventHandler
  filterChanged() {
    ($['todo-repeat'] as DomRepeat).render();
    window.location.hash = filter;
    for (Element li in $['filters'].querySelectorAll('li')) {
      if (li.attributes['label'] == filter) {
        li.classes.add('selected');
      } else {
        li.classes.remove('selected');
      }
    }
  }

  @eventHandler
  void filterAction(MouseEvent e) {
    if (e.target is! AnchorElement) return;
    var target = e.target as AnchorElement;
    set('filter', target.parent.attributes['label']);
  }

  void _setItems() {
    if (storage[storageId] == null) {
      set('items', []);
    } else {
      set('items', JSON.decode(
          storage[storageId]).map((i) => new Todo.fromJson(i)).toList());
    }
  }

  @eventHandler
  bool itemsFilter(Todo item) {
    var filterFn = filters[filter];
    return filterFn != null ? filterFn(item) : true;
  }

  void newItem(String title) {
    title = title.trim();
    if (title != '') {
      add('items', new Todo(title));
    }
  }

  void destroyItem(Todo item) {
    removeItem('items', item);
  }

  void clearItems() {
    removeWhere('items', filters['completed']);
  }

  void setItemsCompleted(bool completed) {
    for (var i = 0; i < items.length; i++) {
      set('items.$i.completed', completed);
    }
  }
}
