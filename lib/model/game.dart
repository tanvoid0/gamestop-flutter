// To parse this JSON data, do
//
//     final game = gameFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';

import 'model.dart';

class Game {
  Game({
    this.comments,
    this.developers,
    this.genres,
    this.platforms,
    this.reviews,
    this.screenshots,
    this.id,
    this.gameId,
    this.title,
    this.description,
    this.image,
    this.released,
    this.videos,
    this.website,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.rating,
    this.pcRequirements,
  });

  List<Comment> comments;
  List<String> developers;
  List<String> genres;
  List<String> platforms;
  List<Review> reviews;
  List<String> screenshots;
  String id;
  String gameId;
  String title;
  String description;
  String image;
  DateTime released;
  List<Video> videos;
  String website;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  double rating;
  Requirements pcRequirements;

  static List<Game> toList(Response response) {
    return (response.data as List).map((game) => Game.fromJson(game)).toList();
  }

  factory Game.fromRawJson(String str) => Game.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x))),
        developers: json["developers"] == null
            ? []
            : List<String>.from(json["developers"].map((x) => x)),
        genres: json["genres"] == null
            ? []
            : List<String>.from(json["genres"].map((x) => x)),
        platforms: json["platforms"] == null
            ? []
            : List<String>.from(json["platforms"].map((x) => x)),
        reviews: json['reviews'] == null
            ? []
            : List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        screenshots: List<String>.from(json["screenshots"].map((x) => x)),
        id: json["_id"] == null ? json['id'].toString() : json['_id'],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
        released:
            json["released"] == null ? null : DateTime.parse(json["released"]),
        videos: json["videos"] == null
            ? []
            : List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        website: json["website"] == null ? null : json["website"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        pcRequirements: json['pc_requirements'] == null
            ? null
            : Requirements.fromJson(json['pc_requirements']),
      );

  Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "developers": List<dynamic>.from(developers.map((x) => x)),
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "platforms": List<dynamic>.from(platforms.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "screenshots": List<dynamic>.from(screenshots.map((x) => x)),
        "_id": id,
        "id": gameId,
        "title": title,
        "description": description,
        "image": image,
        "released": released.toIso8601String(),
        "videos": List<Video>.from(videos.map((x) => x)),
        "website": website,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "rating": rating,
        "pc_requirements": pcRequirements,
      };
}

class Comment {
  Comment({
    this.approve,
    this.id,
    this.comment,
    this.user,
    this.game,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.approvedBy,
    this.commentId,
  });

  bool approve;
  String id;
  String comment;
  User user;
  String game;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String approvedBy;
  String commentId;

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        approve: json["approve"],
        id: json["_id"],
        comment: json["comment"],
        user: User.fromMap(json["user"]),
        game: json["game"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        approvedBy: json["approved_by"],
        commentId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "approve": approve,
        "_id": id,
        "comment": comment,
        "user": user,
        "game": game,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "approved_by": approvedBy,
        "id": commentId,
      };
}

class Review {
  Review({
    this.location,
    this.id,
    this.rating,
    this.user,
    this.game,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.reviewId,
    this.avgRating,
  });

  Location location;
  String id;
  double rating;
  User user;
  String game;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String reviewId;
  double avgRating;

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        location: Location.fromJson(json["location"]),
        id: json["_id"],
        rating: json["rating"].toDouble(),
        user: User.fromMap(json["user"]),
        game: json["game"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        reviewId: json["id"],
        avgRating: json['avgRating'] == null ? 0 : json['avgRating'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "_id": id,
        "rating": rating,
        "user": user,
        "game": game,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": reviewId,
        'avgRating': avgRating,
      };
}

class Requirements {
  Requirements({this.minimum, this.recommended});

  String minimum;
  String recommended;

  factory Requirements.fromRawJson(String str) =>
      Requirements.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Requirements.fromJson(Map<String, dynamic> json) => Requirements(
        minimum: json['minimum'].toString(),
        recommended: json['recommended'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'minimum': minimum,
        'recommended': recommended,
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Video {
  Video({
    this.data,
    this.id,
    this.name,
    this.preview,
  });

  Data data;
  String id;
  String name;
  String preview;

  factory Video.fromRawJson(String str) => Video.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        data: Data.fromJson(json["data"]),
        id: json["_id"],
        name: json["name"],
        preview: json["preview"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "_id": id,
        "name": name,
        "preview": preview,
      };
}

class Data {
  Data({
    this.the480,
    this.max,
  });

  String the480;
  String max;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        the480: json["480"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "480": the480,
        "max": max,
      };
}
