// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library todomvc.test.markdone_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'package:todomvc/td_todos.dart';
import 'package:todomvc/todo.dart';

Node findWithText(node, String text) {
  if (node.text == text) return node;
  if (node is Element && node.localName == 'dom-module') {
    return null;
  }
  if (node is PolymerMixin && Polymer.dom((node as PolymerMixin).root) != null) {
    var r = findWithText(Polymer.dom(node.root), text);
    if (r != null) return r;
  }
  for (var n in node.childNodes) {
    var r = findWithText(n, text);
    if (r != null) return r;
  }
  return null;
}

/**
 * This test runs the TodoMVC app, adds a few todos, marks some as done
 * programatically, and clicks on a checkbox to mark others via the UI.
 */
main() async {
  await initPolymer();
  useHtmlConfiguration();

  TodoList todoList;

  setUp(() {
    todoList = querySelector('td-todos');
  });

  tearDown(() {
    todoList.clear('items');
  });

  test('mark done', () {
    todoList.addAll('items', [
      new Todo('one (unchecked)'),
      new Todo('two (unchecked)'),
      new Todo('three (checked)')..completed = true,
      new Todo('four (checked)'),
    ]);

    return new Future(() {
      var body = Polymer.dom(document.body);

      var label = findWithText(body, 'four (checked)');
      expect(label is LabelElement, true, reason: 'text is in a label: $label');

      PolymerDom host = Polymer.dom(label.parentNode.parentNode.root);
      var node = host.querySelector('input');
      expect(node is InputElement, true, reason: 'node is a checkbox');
      expect(node.type, 'checkbox', reason: 'node type is checkbox');
      expect(node.checked, isFalse, reason: 'element is unchecked');

      node.dispatchEvent(new MouseEvent('click', detail: 1));
      expect(node.checked, true, reason: 'element is checked');
    });
  });
}
