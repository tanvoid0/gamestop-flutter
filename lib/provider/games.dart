import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gamestop/api/api.dart';
import 'package:gamestop/model/model.dart';

class Games with ChangeNotifier {
  List<Game> _games = [];
  List<Game> _apiGames = [];
  int page = 1;
  Map<String, List<Game>> _gamesByGenre = {
    "All": [],
    "Action": [],
    "Indie": [],
    "Adventure": [],
    "RPG": [],
    "Strategy": [],
    "Shooter": [],
    "Casual": [],
    "Simulation": [],
    "Puzzle": [],
    "Arcade": [],
    "Platformer": [],
    "Racing": [],
    "Massively Multiplayer": [],
    "Sports": [],
    "Fighting": [],
    "Family": [],
    "Board Games": [],
    "Educational": [],
    "Card": []
  };

  List<Game> get games {
    return [..._games];
  }

  List<Game> get apiGames {
    return [..._apiGames];
  }

  int gameIndex(id) {
    return _games.indexWhere((game) => game.id == id);
  }

  int commentIndex(id, gameInd) {
    return _games[gameInd].comments.indexWhere((comment) => comment.id == id);
  }

  Map<String, List<Game>> get gamesByGenre {
    return _gamesByGenre;
  }

  Future<void> setGameByGenre() async {
    _gamesByGenre.forEach((key, value) {
      _gamesByGenre[key] =
          _games.where((game) => game.genres.contains(key)).toList();
      // print("Key: ${key} value: ${value}");
    });

    _gamesByGenre['All'] = _games;
  }

  Future<void> createGame(id, user) async {
    print("processing");
    return GameApi.createGame(id, user).then((Game data) {
      if (data != null) {
        _games = [...games, data];
        setGameByGenre();
        notifyListeners();
      }
    }).catchError((error) {
      if (error is DioError) {
        print(error.message);
        if (error.response.statusCode == 409) {
          throw "Game already added";
        }
        // print("DIO error");
      }
      return null;
    });
  }

  Future<void> fetchServerGames() async {
    try {
      return GameApi.getListOfGames().then((data) {
        if (data != null) {
          _games = [...data];
          setGameByGenre();
          notifyListeners();
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> initialFetch() async {
    await fetchServerGames();
    await fetchApiGames();
  }

  Future<void> fetchApiGames() async {
    try {
      var listofgames = await GameApi.getListOfApiGames(page.toString());
      if (listofgames != null) {
        page++;
        _apiGames = [..._apiGames, ...listofgames];
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<bool> postComment(String comment, String game_id, User user) async {
    final index = _games.indexWhere((game) => game.id == game_id);
    try {
      final Comment data = await GameApi.postComment(comment, game_id, user);
      _games[index].comments.add(data);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
      print(e);
    }
  }

  Future<bool> postReview(double rating, String game_id, User user) async {
    final index = _games.indexWhere((game) => game.id == game_id);
    try {
      final Review data = await GameApi.postReview(rating, game_id, user);
      _games[index].rating = data.avgRating;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> approveComment(
      String comment_id, String game_id, User user) async {
    try {
      final success = await GameApi.approveComment(comment_id, user);
      if (success) {
        int gameInd = gameIndex(game_id);
        int cmntInd = commentIndex(comment_id, gameInd);
        games[gameInd].comments[cmntInd].approve = true;
        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteComment(
      String comment_id, String game_id, User user) async {
    GameApi.deleteComment(comment_id, user).then((success) {
      int gameInd = gameIndex(game_id);
      int cmntInd = commentIndex(comment_id, gameInd);
      _games[gameInd].comments.removeAt(cmntInd);
      notifyListeners();
      return true;
    }).catchError((e) {
      return false;
    });
  }
}
