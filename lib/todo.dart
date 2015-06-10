library todomvc.td_model;

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
