import 'package:fluent_ui/fluent_ui.dart';
import './pages/export_pages.dart';
import 'constant.dart';
import 'package:firedart/firedart.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    minimumSize: Size(800,600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  Firestore.initialize(projectId);
  FirebaseAuth.initialize(apiKey, VolatileStore());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter fluent ui',
      theme: FluentThemeData(
        accentColor: Colors.green,
        brightness: Brightness.light
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {

  int topIndex = 0;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _init();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: NavigationView(
        appBar: const NavigationAppBar(
          title: Text('NavigationView'),
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: (){},
          //   icon: const Icon(FluentIcons.caret_hollow_mirrored),
          // ),
        ),
        pane: NavigationPane(
          selected: topIndex,
          size: const NavigationPaneSize(
            openMaxWidth: 250,
          ),
          displayMode: PaneDisplayMode.compact,
          onChanged: (index) => setState(() => topIndex = index),
          items: [
            PaneItem(
              icon: const Icon(FluentIcons.home),
              title: const Text('Dash Board'),
              body: const DashBoard(),
              infoBadge: const InfoBadge(
                source: Text("4"),
              )
            ),
            PaneItem(
              icon: const Icon(FluentIcons.add),
              title: const Text('Thêm thông tinn'),
              body: const AddTodo(),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.add),
              title: const Text('Thêm thông tinn 2'),
              body: const Text("sdf"),
            ),
          ],
          footerItems: [
            PaneItem(
              icon: const Icon(FluentIcons.settings),
              title: const Text('Settings'),
              body: const Text("hello"),
            ),
          ],
        ),
      )
    );
  }


  @override
  void onWindowClose() {
    windowManager.isPreventClose().then((isPreventClose){
      if (isPreventClose) {
        showDialog(
          context: context,
          builder: (_) {
            return ContentDialog(
              title: const Text('Thoát khỏi ứng dụng'),
              content: const Text("Bạn có chắc muốn thoát khỏi ứng dụng không?"),
              actions: [
                Button(
                  child: const Text('Trờ lại'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FilledButton(
                  child: const Text('Có'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await windowManager.destroy();
                  },
                ),
              ],
            );
          },
        );
      }
    });

  }

}
