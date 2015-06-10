@HtmlImport('td_todos.html')
library todomvc.td_todos;

import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'todo.dart';
import 'td_input.dart';
import 'td_item.dart';
//import 'router/simple_router.dart';

@PolymerElement('td-todos')
class TodoList extends PolymerStandardElement {
  @Property(computed: 'isEmpty(completedCount)')
  bool completedEmpty;

  @Property(notify: true, observer: 'itemsChanged')
  List<Todo> items;

  @Property(notify: true, observer: 'storageIdChanged')
  String storageId = 'storage';

  @Property(notify: true, computed: 'countCompleted(items.*)')
  int completedCount;

  @Property(notify: true, computed: 'countActive(items.*)')
  int activeCount;

  @Property(
      notify: true,
      computed: 'checkAllCompleted(completedCount, activeCount)')
  bool allCompleted;

  @Property(notify: true, computed: 'getActiveItemWord(activeCount)')
  String activeItemWord;

  @Property(notify: true, observer: 'filterChanged')
  String filter;

  Storage storage = window.localStorage;

  final filters = {
    'active': (item) => !item.completed,
    'completed': (item) => item.completed,
  };

//  @Property(notify: true)
//  String activeRoute;

  factory TodoList() => new Element.tag('td-todos');
  TodoList.created() : super.created();

  TodoInput get _newTodo => $['new-todo'];

  @eventHandler
  bool isEmpty() => completedCount == 0;

//  void routeAction(e, route) {
//    if (model != null) model.filter = route;
//
//    // TODO(jmesserly): polymer_expressions lacks boolean conversions.
//    activeRoute = (route != null && route != '') ? route : 'all';
//  }

  @eventHandler
  void addTodoAction(_, __) {
    newItem(_newTodo.value);
    _newTodo.value = '';
  }

  @eventHandler
  void cancelAddTodoAction(_, __) {
    _newTodo.value = '';
  }

  @eventHandler
  void destroyItemAction(e, detail) {
    destroyItem(detail);
  }

  @eventHandler
  void toggleAllCompletedAction(e, detail) {
    setItemsCompleted(e.target.checked);
  }

  @eventHandler
  void clearCompletedAction(_, __) {
    clearItems();
  }

  @eventHandler
  int countActive(_) => items.where(filters['active']).length;

  @eventHandler
  int countCompleted(_) => items.where(filters['completed']).length;

  @eventHandler
  bool checkAllCompleted(completedCount, activeCount) =>
  completedCount > 0 && activeCount == 0;

  @eventHandler
  String getActiveItemWord(int activeCount) =>
  activeCount == 1 ? 'item' : 'items';

  @Observe('items.*')
  void itemsChanged() {
    if (storage != null && storageId != null) {
      storage[storageId] = JSON.encode(items);
    }
  }

  // TODO(jakemac): Add change listeners!.
  @eventHandler
  void storageIdChanged() {
    _setItems();
  }

  @eventHandler
  filterChanged() {
    new JsObject.fromBrowserObject($['todo-repeat']).callMethod('render');
  }

  @eventHandler
  void filterAction(MouseEvent e, detail) {
    AnchorElement target = e.target;
    set('filter', target.text.toLowerCase());
    for (var child in  ($['filters'] as DivElement).children) {
      if (child == target.parent) {
        child.classes.add('selected');
      } else {
        child.classes.remove('selected');
      }
    }
  }

  void _setItems() {
    if (storage[storageId] == null) {
      set('items', []);
    } else {
      set('items', JSON.decode(
          storage[storageId]).map((i) => new Todo.fromJson(i)).toList());
    }
  }

  /// Dynamically filter items based on the current value of `filter`.
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

  // TODO(jmesserly): workaround for HTML Imports not setting correct baseURI
//  String get baseUri =>
//      element.element.ownerDocument == document ? '../' : '';
}
