// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library todomvc.test.mainpage_test;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:unittest/html_config.dart';
import 'package:unittest/unittest.dart';
import 'package:todomvc/td_todos.dart';

/**
 * This test runs the TodoMVC app and checks the state of the initial page.
 */
main() async {
  await initPolymer();
  useHtmlConfiguration();

  TodoList todoList;

  setUp(() {
    todoList = Polymer.dom(document.body).querySelector('td-todos');
  });

  tearDown(() {
    todoList.clear('items');
  });

  test('initial state', () {
    expect(todoList is TodoList, true, reason: 'TodoList should be created');

    final root = Polymer.dom(todoList.root);
    final newTodo = root.querySelector('#new-todo');
    expect(newTodo.placeholder, "What needs to be done?");

    // Validate a style got applied
    var color = root.querySelector('#footer').getComputedStyle().color;
    expect(color, 'rgb(119, 119, 119)');

    expect(todoList.items, [], reason: 'no items yet');
  });
}
