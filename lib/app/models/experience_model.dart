/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'parents/model.dart';

class Experience extends Model {
  String? title;
  String? description;

  Experience({String? id, this.title, this.description}) {
    this.id = id;
  }

  Experience.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    title = transStringFromJson(json, 'title');
    description = transStringFromJson(json, 'description');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
