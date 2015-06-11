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
      #anyItems: (o) => o.anyItems,
      #items: (o) => o.items,
      #storageId: (o) => o.storageId,
      #completedCount: (o) => o.completedCount,
      #activeCount: (o) => o.activeCount,
      #allCompleted: (o) => o.allCompleted,
      #activeItemWord: (o) => o.activeItemWord,
      #filter: (o) => o.filter,
      #isZero: (o) => o.isZero,
      #itemsIsNotEmpty: (o) => o.itemsIsNotEmpty,
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
      #classString: (o) => o.classString,
      #editAction: (o) => o.editAction,
      #commitAction: (o) => o.commitAction,
      #cancelAction: (o) => o.cancelAction,
      #destroyAction: (o) => o.destroyAction,
      #getClassString: (o) => o.getClassString,

      // For TodoInput
      #keyPressAction: (o) => o.keyPressAction,
      #keyUpAction: (o) => o.keyUpAction,
    },
    setters: {
      #completedEmpty: (o, v) { o.completedEmpty = v; },
      #anyItems: (o, v) { o.anyItems = v; },
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
      #classString: (o, v) { o.classString = v; },
    },
    parents: {
      Todo: _M0,
      TodoInput: _M0,
      TodoList: _M0,
      TodoItem: _M0,
      Observe: EventHandler,
      Listen: EventHandler,
      EventHandler: _M0,
    },
    declarations: {
      TodoList: {
        #completedEmpty: const Declaration(#completedEmpty, bool, annotations: const [const Property(computed: 'isZero(completedCount)')]),
        #anyItems: const Declaration(#anyItems, bool, annotations: const [const Property(computed: 'itemsIsNotEmpty(items.*)')]),
        #items: const Declaration(#items, List, annotations: const [const Property(notify: true, observer: 'itemsChanged')]),
        #storageId: const Declaration(#storageId, String, annotations: const[const Property(notify: true, observer: 'storageIdChanged')]),
        #completedCount: const Declaration(#completedCount, int, annotations: const[const Property(notify: true, computed: 'countCompleted(items.*)')]),
        #activeCount: const Declaration(#activeCount, int, annotations: const[const Property(notify: true, computed: 'countActive(items.*)')]),
        #allCompleted: const Declaration(#allCompleted, bool, annotations: const[const Property(notify: true, computed: 'checkAllCompleted(completedCount, activeCount)')]),
        #activeItemWord: const Declaration(#activeItemWord, String, annotations: const[const Property(notify: true, computed: 'getActiveItemWord(activeCount)')]),
        #filter: const Declaration(#filter, String, annotations: const[const Property(notify: true, observer: 'filterChanged')]),
        #isZero: const Declaration(#isZero, Function, kind: METHOD, annotations: const[eventHandler]),
        #itemsIsNotEmpty: const Declaration(#itemsIsNotEmpty, Function, kind: METHOD, annotations: const[eventHandler]),
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
        #classString: const Declaration(#classString, String, annotations: const[const Property(computed: 'getClassString(editing, item.completed)')]),
        #editAction: const Declaration(#editAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #commitAction: const Declaration(#commitAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #cancelAction: const Declaration(#cancelAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #destroyAction: const Declaration(#destroyAction, Function, kind: METHOD, annotations: const[eventHandler]),
        #getClassString: const Declaration(#getClassString, Function, kind: METHOD, annotations: const[eventHandler]),
      },
      TodoInput: {
        #keyPressAction: const Declaration(#keyPressAction, Function, kind: METHOD, annotations: const[const Listen('keypress')]),
        #keyUpAction: const Declaration(#keyUpAction, Function, kind: METHOD, annotations: const[const Listen('keyup')]),
      },
    },
    names:  {
      // General lifecycle methods
      #ready: 'ready',
      #attached: 'attached',
      #detached: 'detached',

      // For TodoList
      #completedEmpty: 'completedEmpty',
      #anyItems: 'anyItems',
      #items: 'items',
      #storageId: 'storageId',
      #completedCount: 'completedCount',
      #activeCount: 'activeCount',
      #allCompleted: 'allCompleted',
      #activeItemWord: 'activeItemWord',
      #filter: 'filter',
      #itemsIsNotEmpty: 'itemsIsNotEmpty',
      #isZero: 'isZero',
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
      #classString: 'classString',
      #editAction: 'editAction',
      #commitAction: 'commitAction',
      #cancelAction: 'cancelAction',
      #destroyAction: 'destroyAction',
      #getClassString: 'getClassString',

      // For TodoInput
      #keyPressAction: 'keyPressAction',
      #keyUpAction: 'keyUpAction',
    }
  ));
  await initPolymer();
}
