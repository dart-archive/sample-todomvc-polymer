@HtmlImport('td_todos.html')
library todomvc.td_todos;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'td_model.dart';
import 'td_input.dart';
import 'td_item.dart';
//import 'router/simple_router.dart';

@PolymerElement('td-todos')
class TodoList extends PolymerStandardElement {
  @Property(notify: true, observer: 'modelIdChanged') String modelId;

  @Property(notify: true) TodoModel model;
  @Property(computed: 'isEmpty(model)')
  bool modelCompletedEmpty;

  @Property(notify: true) String activeRoute;

  factory TodoList() => new Element.tag('td-todos');
  TodoList.created() : super.created();

  TodoInput get _newTodo => $['new-todo'];

  ready() {
    set('modelId', 'model');
  }

  @eventHandler
  bool isEmpty(TodoModel model) => model.completedCount == 0;

  @eventHandler
  void modelIdChanged(newId, [__]) {
    set('model', document.querySelector('#$newId'));
  }

//  void routeAction(e, route) {
//    if (model != null) model.filter = route;
//
//    // TODO(jmesserly): polymer_expressions lacks boolean conversions.
//    activeRoute = (route != null && route != '') ? route : 'all';
//  }

  @eventHandler
  void addTodoAction(_, __) {
    model.newItem(_newTodo.value);
    notifyPath('model.items', model.items);
    notifyPath('model.filtered', model.filtered);
    _newTodo.value = '';
  }

  @eventHandler
  void cancelAddTodoAction(_, __) {
    _newTodo.value = '';
  }

  @eventHandler
  void itemChangedAction(_, __) {
    if (model != null) model.itemsChanged();
  }

  @eventHandler
  void destroyItemAction(e, detail) {
    model.destroyItem(detail);
    notifyPath('model.items', model.items);
    notifyPath('model.filtered', model.filtered);
  }

  @eventHandler
//  void toggleAllCompletedAction(e, detail, sender) {
  void toggleAllCompletedAction(e, detail) {
    model.setItemsCompleted(e.target.checked);
  }

  @eventHandler
  void clearCompletedAction(_, __) {
    model.clearItems();
    notifyPath('model.items', model.items);
    notifyPath('model.filtered', model.filtered);
  }

  // TODO(jmesserly): workaround for HTML Imports not setting correct baseURI
//  String get baseUri =>
//      element.element.ownerDocument == document ? '../' : '';
}
