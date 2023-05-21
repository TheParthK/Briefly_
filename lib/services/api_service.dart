import 'dart:convert';

import 'package:briefly/models/news_model.dart';
import 'package:http/http.dart';

// http request service

class APIservice{
    Future<List<NewsModel>> getArticle(String topic) async{
      final endPointURL = 
        "https://newsapi.org/v2/everything?q=${topic!=''?topic:'tech'}&apiKey=[YOUR API KEY]";
      Response res = await get(Uri.parse(endPointURL));
      // checking for 200 status code
      if(res.statusCode == 200){
        Map<String, dynamic> json = jsonDecode(res.body);
        List<dynamic> body = json['articles'];
        print(body);
        List<NewsModel> newsItems = [];
        for(var i in body){
          if(
            i['source']['name'] != null &&
            i['title'] != null &&
            i['title'] != null &&
            i['urlToImage'] != null &&
            i['url'] != null &&
            i['description'] != null &&
            i['author'] != null 
            ){
              newsItems.add(NewsModel.fromJson(i));
            }
        }
        return newsItems;
      } else {
        throw ("Can't get articles from API atm");
      }
    }
}
