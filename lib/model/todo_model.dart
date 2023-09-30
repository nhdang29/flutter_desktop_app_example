class Todo{
  final String? id;
  final String todo;
  final String moTa;
  final bool isComplete;

  Todo({ this.id,required this.todo, required this.moTa, this.isComplete = false});
  Todo copyWith({String? id ,String? todo, String? moTa, bool? isComplete}){
    return Todo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      moTa: moTa ?? this.moTa,
      isComplete: isComplete ?? this.isComplete
    );
  }

  Todo.fromJson(Map<String, dynamic> json)
    : todo = json["todo"] ?? "", moTa = json["moTa"] ?? "", isComplete = json["complete"] ?? false, id = json["id"] ?? "";

  Map<String, dynamic> toJson() => {
    "todo": todo,
    "moTa": moTa,
    "complete": isComplete
  };

}