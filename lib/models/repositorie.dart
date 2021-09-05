import 'dart:convert';

import 'package:github_search/models/owner.dart';
import 'package:intl/intl.dart';

Repositorie repositorieFromJson(String str) =>
    Repositorie.fromJson(json.decode(str));

String repositorieToJson(Repositorie data) => json.encode(data.toJson());

class Repositorie {
  Repositorie({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  int? totalCount;
  bool? incompleteResults;
  List<Item>? items;

  factory Repositorie.fromJson(Map<String, dynamic> json) => Repositorie(
        totalCount: json["total_count"],
        incompleteResults: json["incomplete_results"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "incomplete_results": incompleteResults,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.name,
    this.fullName,
    this.private,
    this.owner,
    this.description,
    this.htmlUrl,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.stargazersCount,
    this.watchers,
  });

  int? id;
  String? name;
  String? fullName;
  bool? private;
  Owner? owner;
  String? description;
  String? htmlUrl;
  int? stargazersCount;
  int? watchers;
  DateTime? createdAt;
  String? updatedAt;
  DateTime? pushedAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        fullName: json["full_name"],
        private: json["private"],
        owner: Owner.fromJson(json["owner"]),
        description: json["description"] == null ? null : json["description"],
        htmlUrl: json["html_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: new DateFormat('dd MMMM', 'ru_Ru')
            .format(DateTime.parse(json["updated_at"])),
        pushedAt: DateTime.parse(json["pushed_at"]),
        stargazersCount: json["stargazers_count"],
        watchers: json["watchers"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "full_name": fullName,
        "private": private,
        "owner": owner!.toJson(),
        "description": description == null ? null : description,
        "html_url": htmlUrl,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt,
        "pushed_at": pushedAt!.toIso8601String(),
        "stargazers_count": stargazersCount,
        "watchers": watchers,
      };
}
