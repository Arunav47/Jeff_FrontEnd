class Journal{
  String? id;
  String? userId;
  String? title;
  String? content;
  DateTime? dateAdded;

  Journal({this.id, this.userId, this.title, this.content, this.dateAdded});

  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id : map['id'],
      userId : map['userId'],
      title : map['title'],
      content : map['content'],
      dateAdded : DateTime.tryParse(map['dateAdded'])
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'userId' : userId,
      'title' : title,
      'content' : content,
      'dateAdded' : dateAdded!.toIso8601String()
    };
  }
}