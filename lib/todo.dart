library todomvc.td_model;

import 'package:polymer/polymer_micro.dart';
import 'package:polymer/polymer.dart';

class Todo extends Object with JsProxy {
  @reflectable
  String title;

  @reflectable
  bool completed = false;

  Todo(this.title);

  Todo.fromJson(Map json)
      : title = json['title'], completed = json['completed'];

  Map toJson() => { 'title': title, 'completed': completed };

  String toString() => "$title (${completed ? '' : 'not '}done)";
}
