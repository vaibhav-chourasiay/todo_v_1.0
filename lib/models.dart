class MyModal {
  int? id;
  String? title;
  String? des;

  MyModal({
    this.id,
    required this.title,
    required this.des,
  });

  MyModal.fromMap(Map r) {
    id = r["id"];
    title = r["title"];
    des = r["des"];
  }

  toMap() {
    return {
      "id": id,
      "title": title,
      "des": des,
    };
  }
}
