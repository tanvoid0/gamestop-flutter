import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gamestop/data/constants.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/provider/provider_export.dart';

class GameApi {
  static final url = "$server/game";
  static final games_url = url;
  static final games_rawg_url = "$url/rawg";
  static final game_detail_url = "$url";
  static final game_search_url = "$url/search";
  static final comment_post_url = "$url/comment";
  static final comment_approve_url = "$url/comment/approve";
  static final comment_delete_url = "$url/comment";

  static final review_post_url = "$url/review";
  static Dio _dio = Dio();

  static Future<List<Game>> getListOfGames() async {
    return _dio.get(games_url).then((response) {
      return Game.toList(response);
    }).catchError((error) {
      print(error.toString());
    });
  }

  static Future<Game> createGame(String game_id, user) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer ${user.token}";
    return _dio.post("$games_url/$game_id").then((response) {
      print("Game ${response.data}");
      return Game.fromJson(response.data);
    }).catchError((error) {
      throw error;
    });
  }

  static Future<List<Game>> getListOfApiGames(String page) async {
    // print("${page.runtimeType} $page");
    // return null;
    return await _dio.get(games_rawg_url, queryParameters: {
      "page": page,
    }).then((response) {
      return Game.toList(response);
    }).catchError((error, stackTrace) {
      print("Error: $error");
      return null;
    });
  }

  static Future<Game> fetchGameDetail(int id) async {
    try {
      final response = await _dio.get("$game_detail_url/$id");
      Game game = Game.fromJson(response.data);
      return game;
    } catch (error) {
      throw error;
    }
  }

  static Future<List<Game>> fetchSearchList(String query) async {
    try {
      final response = await _dio.get("$game_search_url/$query");
      return Game.toList(response);
      // print("Searching");
      // final response = await _dio.get("$game_search_url/$query");
      // print("finished");
      // return (response.data as List)
      //     .map(
      //       (game) => Game(
      //         name: game['name'],
      //         id: game['id'],
      //         backgroundImage: game['background_image'],
      //         released: DateTime.parse(game["released"]),
      //       ),
      //     )
      //     .toList();
    } catch (error) {
      print(error);
    }
  }

  static Future<Comment> postComment(
      String comment, String game_id, User user) async {
    try {
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "Bearer ${user.token}";
      final Map<String, String> data = {
        'comment': comment,
        'game': game_id,
      };
      final response = await _dio.post(comment_post_url, data: data);
      print("Check response ${response.data}");
      return Comment.fromJson(response.data);
      // print("Response ${response.data}");
      // if (response.statusCode == 401) {
      //   throw "Unauthorized!";
      // }
      // final new_comment = Comment.fromJson(response.data);
      // print("Response ${response.data}");
      // return new_comment;
    } catch (e) {
      print(e);

      // throw e;
    }
    return null;
  }

  static Future<Review> postReview(
      double rating, String game_id, User user) async {
    // final response = await _dio.post("")
    try {
      print("Token ${user.token}");
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "Bearer ${user.token}";
      final location = await User.getLocation();

      final Map<String, dynamic> data = {
        'game': game_id,
        'location': {
          'lat': location.latitude,
          'lng': location.longitude,
        },
        'rating': rating,
        'user': user.id,
      };
      final response = await _dio.post(review_post_url, data: data);
      print("Check response ${response.data}");
      return Review.fromJson(response.data);
      // _dio.options.headers['content-Type'] = 'application/json';
      // _dio.options.headers["authorization"] = "Bearer ${user.token}";
      // final Map<String, dynamic> review = {
      //   'game': game_id,
      //   'location': {
      //     'lat': location.latitude,
      //     'lng': location.longitude,
      //   },
      //   'rating': rating,
      //   'user': user.id,
      // };
      // print(review);
      // final response = await _dio.post(review_post_url, data: review);
      // print("Response: ${response.data}");
      //
      // return true;
    } catch (e) {
      print("Rating error! $e");
      return null;
    }
    return null;
  }

  static Future<bool> approveComment(String comment_id, User user) async {
    return _dio.post(comment_approve_url + "/$comment_id").then((response) {
      print("Response ${response.data}");
      return true;
    }).onError((error, stackTrace) {
      print("Error $error, stack: $stackTrace");
      return false;
    }).catchError((err) {
      print("Message ${err}");
      if (err is DioError) {
        print("Dio Error");
      }
      return false;
      // print(err);
    });
  }

  static Future<bool> deleteComment(String comment_id, User user) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer ${user.token}";
    return _dio.delete("$comment_delete_url/$comment_id").then((resopnse) {
      return true;
    }).catchError((err) {
      print(err);
      return false;
    });
  }
}
