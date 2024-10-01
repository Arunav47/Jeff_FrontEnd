class Journal{
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? dateadded;

  Journal({this.id, this.userid, this.title, this.content, this.dateadded});

  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id : map['id'],
      userid : map['userid'],
      title : map['title'],
      content : map['content'],
      dateadded : DateTime.tryParse(map['dateadded'])
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'userid' : userid,
      'title' : title,
      'content' : content,
      'dateadded' : dateadded!.toIso8601String()
    };
  }
}