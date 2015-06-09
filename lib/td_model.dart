library todomvc.td_model;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:polymer/polymer_micro.dart';

class Todo extends Object with JsProxy {
  String title;
  bool completed = false;

  Todo(this.title);

  Todo.fromJson(Map json)
      : title = json['title'], completed = json['completed'];

  Map toJson() => { 'title': title, 'completed': completed };

  String toString() => "$title (${completed ? '' : 'not '}done)";
}

@PolymerElement('td-model')
class TodoModel extends PolymerMicroElement {
  @Property(notify: true, observer: 'itemsChanged')
  List<Todo> items;
  @Property(notify: true, computed: 'filterItems(items.*)')
  Iterable<Todo> filtered;
  @Property(notify: true, observer: 'storageIdChanged')
  String storageId = 'storage';

  @Property(notify: true, computed: 'countCompleted(items.*)')
  int completedCount;
  @Property(notify: true, computed: 'countActive(items.*)')
  int activeCount;
  @Property(notify: true,
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

  factory TodoModel() => new Element.tag('td-model');
  TodoModel.created() : super.created();

  @eventHandler
  void filterChanged([_, __]) {
    set('filtered', filterItems());
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

  @eventHandler
  void itemsChanged([_, __]) {
    set('filtered', filterItems());
    if (storage != null && storageId != null) {
      storage[storageId] = JSON.encode(items);
    }
  }

  // TODO(jakemac): Add change listeners!.
  @eventHandler
  void storageIdChanged([_, __]) {
    _setItems();
  }
  
  void _setItems() {
    if (storage[storageId] == null) {
      set('items', []);
    } else {
      set('items', JSON.decode(
          storage[storageId]).map((i) => new Todo.fromJson(i)).toList());
    }
    itemsChanged();
  }

  @eventHandler
  Iterable<Todo> filterItems() {
    var fn = filters[filter];
    return fn != null ? items.where(fn) : items;
  }

  void newItem(String title) {
    title = title.trim();
    if (title != '') {
      add('items', new Todo(title));
    }
    itemsChanged();
  }

  void destroyItem(Todo item) {
    removeItem('items', item);
    itemsChanged();
  }

  void clearItems() {
    var filter = filters['completed'];
    removeWhere('items', filter);
    itemsChanged();
  }

  void setItemsCompleted(bool completed) {
    for (var i = 0; i < items.length; i++) {
      set('items.$i.completed', completed);
    }
    itemsChanged();
  }
}
