import 'package:fluent_ui/fluent_ui.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.green,
                child: ListView(
                  children: const [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dash Board",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Dash Board",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1000,),
                    Text(
                      "Dash Board",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(direction: Axis.vertical),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.red,
                child: const Column(
                  children: [
                    Text(
                      "Dash Board",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
