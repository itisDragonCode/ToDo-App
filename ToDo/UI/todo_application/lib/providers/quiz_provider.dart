
import 'dart:convert';

import 'package:http/http.dart';

import '../models/quiz.dart';
import '../models/search_result.dart';
import '../providers/base_provider.dart';

class QuizProvider extends BaseProvider<Quiz> {
  QuizProvider() : super('Quizzes');
  @override
  Quiz fromJson(data) {
    return Quiz.fromJson(data);
  }

  Future<SearchResult<Quiz>> getActiveQuizzes({dynamic filter}) async {
    var url = "${BaseProvider.baseUrl}$endpoint/GetActiveQuizzes";

    if (filter != null) {
      var querryString = getQueryString(filter);
      url = "$url?$querryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    Response response = await get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<Quiz>();
      result.hasNextPage = data['hasNextPage'];
      result.hasPreviousPage = data['hasPreviousPage'];
      result.isFirstPage = data['isFirstPage'];
      result.isLastPage = data['isLastPage'];
      result.pageCount = data['pageCount'];
      result.pageNumber = data['pageNumber'];
      result.pageSize = data['pageSize'];
      result.totalCount = data['totalCount'];

      for (var a in data['items']) {
        result.items.add(fromJson(a));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }
}