class FaqModel {
  int id ;
  String question;
  String answer;
  String category;
  int adminId;

  FaqModel(
      {required this.id,
        required this.question,
        required this.answer,
        required this.category,
        required this.adminId});

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      category: json['category'],
      adminId: json['adminId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question": question,
      "answer": answer,
      "category": category,
      "adminId": adminId
    };
  }
}
