import 'package:fluent_ui/fluent_ui.dart';
import 'package:my_first_desktop_app/model/todo_model.dart';
import '../controller/todo_controller.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});


  @override
  Widget build(BuildContext context) {

    TextEditingController todoEdittingController = TextEditingController();
    TextEditingController moTaEdittingController = TextEditingController();
    FocusNode moTaFocusNode = FocusNode();
    FocusNode addFocusNode = FocusNode();
    final todoController = TodoController();


    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ScaffoldPage(
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Todo App",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.green
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InfoLabel(
                  label: "Nhập công việc",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.green
                  ),
                  child: Card(
                    borderColor: Colors.green,
                    backgroundColor: Colors.grey[30],
                    child: SizedBox(
                      width: 600,
                      height: 50,
                      child: TextBox(
                        controller: todoEdittingController,
                        placeholder: "todo...",
                        onSubmitted: (value) {
                          moTaFocusNode.requestFocus();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  borderColor: Colors.green,
                  backgroundColor: Colors.grey[30],
                  child: InfoLabel(
                    label: "Nhập mô tả",
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.green
                    ),
                    child: SizedBox(
                      width: 600,
                      height: 50,
                      child: TextBox(
                        controller: moTaEdittingController,
                        focusNode: moTaFocusNode,
                        placeholder: "mô tả ...",
                        onSubmitted: (value) {
                          addFocusNode.requestFocus();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              FilledButton(
                focusNode: addFocusNode,
                onPressed: (){
                  todoController.addTodo(Todo(todo: todoEdittingController.text, moTa: moTaEdittingController.text))
                  .then((_){
                    showSnackbar(context, const InfoBar(title: Text("Thêm thành công!!!")));
                    todoEdittingController.clear();
                    moTaEdittingController.clear();
                  });
                },
                child: const Text("Thêm công việc"),
              ),
              const SizedBox(height: 10,),
              const Divider(),
            ]
          ),
          content: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                // color: Colors.grey,
                child: StreamBuilder(
                  stream: todoController.todoStream(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData) {
                      return const ProgressBar();
                    }
                    if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return const Text("Chưa có công việc!!");
                    }

                    return Column(
                        children: snapshot.data!.map((e){
                          final doc = e.map;
                          doc["id"] = e.id;
                          return TodoListTile(todo: Todo.fromJson(doc));
                        }).toList(),
                      );

                  },
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}

class TodoListTile extends StatefulWidget {
  const TodoListTile({required this.todo,super.key});

  final Todo todo;

  @override
  State<TodoListTile> createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {

  bool isDelete = false;
  final todoController = TodoController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: 800,
      child: Card(
        backgroundColor: Colors.grey[20],
        child: ListTile(
          title: Text(widget.todo.todo),
          subtitle: widget.todo.isComplete ? const Text("Đã xong") : const Text("Chưa xong"),
          trailing: isDelete ? const ProgressRing() : IconButton(
            onPressed: () async {
              setState(() {
                isDelete = true;
              });
              await todoController.deleteTodo(widget.todo);
              setState(() {
                isDelete = false;
              });
            },
            icon: const Icon(FluentIcons.delete),
          ),
          onPressed: (){
            todoController.toggleTodo(widget.todo);
          },
        ),
      ),
    );
  }
}

