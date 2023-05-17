class NewsModel{

  final String title;
  final String source;
  final String imgLink;
  final String srcLink;
  final String desc;
  final String author;

  const NewsModel({
    required this.source,
    required this.title,
    required this.imgLink,
    required this.srcLink, 
    required this.desc, 
    required this.author, 
  });

  // factory function to map json to list

  factory NewsModel.fromJson(Map<String, dynamic> json){
    return NewsModel(
      source: json['source']['name'] as String,
      title: json['title'] as String,
      imgLink: json['urlToImage'] as String,
      srcLink: json['url'] as String,
      desc: json['description'] as String,
      author: json['author'] as String,
    );
  }
}