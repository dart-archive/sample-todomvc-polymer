// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library todomvc.test.listorder_test;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:todomvc/td_todos.dart';
import 'package:todomvc/todo.dart';

/**
 * This test runs the TodoMVC app, adds a few elements, marks some as done, and
 * switches from back and forth between "Active" and "All". This will make some
 * nodes to be hidden and readded to the page.
 */
main() async {
  await initPolymer();

  PolymerDom root;
  TodoList todoList;

  setUp(() {
    todoList = Polymer.dom(document.body).querySelector('td-todos');
    root = Polymer.dom(todoList.root);
  });

  test('programmatically add items to model', () {
    todoList.addAll('items', [
      new Todo('one (unchecked)'),
      new Todo('two (checked)')..completed = true,
      new Todo('three (unchecked)')
    ]);
    return window.animationFrame.then((_) {
      expect(root.querySelectorAll('#todo-list li[is=td-item]').length, 3);

      for (var a in root.querySelectorAll('#filters > li > a')) {
        a.href = '#${Uri.parse(a.href).fragment}';
      }
    });
  });

  test('navigate to #active', () {
    window.location.hash = 'active';
    return window.animationFrame.then((_) {
      expect(root.querySelectorAll('#todo-list li[is=td-item]').length, 2);
    });
  });

  test('navigate to #completed', () {
    window.location.hash = 'completed';
    return window.animationFrame.then((_) {
      expect(root.querySelectorAll('#todo-list li[is=td-item]').length, 1);
    });
  });

  test('navigate back to #', () {
    window.location.hash = '';
    return window.animationFrame.then((_) {
      expect(root.querySelectorAll('#todo-list li[is=td-item]').length, 3);
      todoList.clear('items');
    });
  });
}
