library todomvc.index;

import 'package:todomvc/td_input.dart';
import 'package:todomvc/td_item.dart';
import 'package:todomvc/td_todos.dart';
import 'package:todomvc/todo.dart';
import 'package:polymer/init.dart';
import 'package:polymer/polymer.dart';
import 'package:smoke/static.dart';
import 'package:smoke/smoke.dart';

abstract class _M0 {} // Fake empty parent class.

main() async {
  /// No transformer yet, so need to handcode the static config for smoke!
  useGeneratedCode(new StaticConfiguration(
    checkedMode: false,
    getters: {
      // General lifecycle methods
      #ready: (o) => o.ready,
      #attached: (o) => o.attached,
      #detached: (o) => o.detached,

      // For TodoList
      #completedEmpty: (o) => o.completedEmpty,
      #items: (o) => o.items,
      #storageId: (o) => o.storageId,
      #completedCount: (o) => o.completedCount,
      #activeCount: (o) => o.activeCount,
      #allCompleted: (o) => o.allCompleted,
      #activeItemWord: (o) => o.activeItemWord,
      #filter: (o) => o.filter,
      #isEmpty: (o) => o.isEmpty,
      #addTodoAction: (o) => o.addTodoAction,
      #cancelAddTodoAction: (o) => o.cancelAddTodoAction,
      #destroyItemAction: (o) => o.destroyItemAction,
      #toggleAllCompletedAction: (o) => o.toggleAllCompletedAction,
      #clearCompletedAction: (o) => o.clearCompletedAction,
      #countActive: (o) => o.countActive,
      #countCompleted: (o) => o.countCompleted,
      #checkAllCompleted: (o) => o.checkAllCompleted,
      #getActiveItemWord: (o) => o.getActiveItemWord,
      #itemsChanged: (o) => o.itemsChanged,
      #storageIdChanged: (o) => o.storageIdChanged,
      #filterChanged: (o) => o.filterChanged,
      #filterAction: (o) => o.filterAction,
      #itemsFilter: (o) => o.itemsFilter,

      // For Todo
      #title: (o) => o.title,
      #completed: (o) => o.completed,

      // For TodoItem
      #editing: (o) => o.editing,
      #item: (o) => o.item,
      #editAction: (o) => o.editAction,
      #commitAction: (o) => o.commitAction,
      #cancelAction: (o) => o.cancelAction,
      #destroyAction: (o) => o.destroyAction,
    },
    setters: {
      #completedEmpty: (o, v) { o.completedEmpty = v; },
      #items: (o, v) { o.items = v; },
      #storageId: (o, v) { o.storageId = v; },
      #completedCount: (o, v) { o.completedCount = v; },
      #activeCount: (o, v) { o.activeCount = v; },
      #allCompleted: (o, v) { o.allCompleted = v; },
      #activeItemWord: (o, v) { o.activeItemWord = v; },
      #filter: (o, v) { o.filter = v; },
      #title: (o, v) { o.title = v; },
      #completed: (o, v) { o.completed = v; },
      #editing: (o, v) { o.editing = v; },
      #item: (o, v) { o.item = v; },
    },
    parents: {
      Todo: _M0,
      TodoInput: _M0,
      TodoList: _M0,
      TodoItem: _M0,
      Observe: EventHandler,
      EventHandler: _M0,
    },
    declarations: {
      TodoList: {
        #completedEmpty: const Declaration(#completedEmpty, bool, annotations: const [const Property(computed: 'isEmpty(completedCount)')]),
        #items: const Declaration(#items, List, annotations: const [const Property(notify: true, observer: 'itemsChanged')]),
        #storageId: const Declaration(#storageId, String, annotations: const[const Property(notify: true, observer: 'storageIdChanged')]),
        #completedCount: const Declaration(#completedCount, int, annotations: const[const Property(notify: true, computed: 'countCompleted(items.*)')]),
        #activeCount: const Declaration(#activeCount, int, annotations: const[const Property(notify: true, computed: 'countActive(items.*)')]),
        #allCompleted: const Declaration(#allCompleted, bool, annotations: const[const Property(notify: true, computed: 'checkAllCompleted(completedCount, activeCount)')]),
        #activeItemWord: const Declaration(#activeItemWord, String, annotations: const[const Property(notify: true, computed: 'getActiveItemWord(activeCount)')]),
        #filter: const Declaration(#filter, String, annotations: const[const Property(notify: true, observer: 'filterChanged')]),
        #ready: const Declaration(#ready, Function, kind: METHOD),
        #isEmpty: const Declaration(#isEmpty, Function, kind: METHOD, annotations: const[eventHandler]),
        #addTodoAction: const Declaration(#addTodoAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #cancelAddTodoAction: const Declaration(#cancelAddTodoAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #destroyItemAction: const Declaration(#destroyItemAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #toggleAllCompletedAction: const Declaration(#toggleAllCompletedAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #clearCompletedAction: const Declaration(#clearCompletedAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #countActive: const Declaration(#countActive, Function, kind: METHOD, annotations: const[eventHandler]),
        #countCompleted: const Declaration(#countCompleted, Function, kind: METHOD, annotations: const[eventHandler]),
        #checkAllCompleted: const Declaration(#checkAllCompleted, Function, kind: METHOD, annotations: const[eventHandler]),
        #getActiveItemWord: const Declaration(#getActiveItemWord, Function, kind: METHOD, annotations: const[eventHandler]),
        #itemsChanged: const Declaration(#itemsChanged, Function, kind: METHOD, annotations: const[const Observe('items.*')]),
        #storageIdChanged: const Declaration(#storageIdChanged, Function, kind: METHOD, annotations: const[eventHandler]),
        #filterChanged: const Declaration(#filterChanged, Function, kind: METHOD, annotations: const[eventHandler]),
        #filterAction: const Declaration(#filterAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #itemsFilter: const Declaration(#itemsFilter, Function, kind: METHOD, annotations: const[eventHandler]),
      },
      Todo: {
        #title: const Declaration(#title, String),
        #completed: const Declaration(#completed, bool),
      },
      TodoItem: {
        #editing: const Declaration(#editing, bool, annotations: const[property]),
        #item: const Declaration(#item, Todo, annotations: const[const Property(notify: true)]),
        #editAction: const Declaration(#editAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #commitAction: const Declaration(#commitAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #cancelAction: const Declaration(#cancelAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #destroyAction: const Declaration(#destroyAction, Function, kind: METHOD, annotations: const[eventHandler]),
      },
      TodoInput: {
      },
    },
    names:  {
      // General lifecycle methods
      #ready: 'ready',
      #attached: 'attached',
      #detached: 'detached',

      // For TodoList
      #completedEmpty: 'completedEmpty',
      #items: 'items',
      #storageId: 'storageId',
      #completedCount: 'completedCount',
      #activeCount: 'activeCount',
      #allCompleted: 'allCompleted',
      #activeItemWord: 'activeItemWord',
      #filter: 'filter',
      #isEmpty: 'isEmpty',
      #addTodoAction: 'addTodoAction',
      #cancelAddTodoAction: 'cancelAddTodoAction',
      #destroyItemAction: 'destroyItemAction',
      #toggleAllCompletedAction: 'toggleAllCompletedAction',
      #clearCompletedAction: 'clearCompletedAction',
      #countActive: 'countActive',
      #countCompleted: 'countCompleted',
      #checkAllCompleted: 'checkAllCompleted',
      #getActiveItemWord: 'getActiveItemWord',
      #itemsChanged: 'itemsChanged',
      #storageIdChanged: 'storageIdChanged',
      #filterChanged: 'filterChanged',
      #filterAction: 'filterAction',
      #itemsFilter: 'itemsFilter',

      // For Todo
      #title: 'title',
      #completed: 'completed',

      // For TodoItem
      #editing: 'editing',
      #item: 'item',
      #editAction: 'editAction',
      #commitAction: 'commitAction',
      #cancelAction: 'cancelAction',
      #destroyAction: 'destroyAction',
    }
  ));
  await initPolymer();
}
