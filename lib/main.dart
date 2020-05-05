import 'package:flutter/material.dart';
import 'package:get_ip/get_ip.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My IP address'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _myIp = "unknown";
  String _time = "unknown";

  @override
  void initState() {
    super.initState();
    _setIp();
  }

  void _setIp() async {
    String myAddress = await GetIp.ipAddress;
    var formatter = new DateFormat('HH:mm:ss');
    String now = formatter.format(new DateTime.now());
    setState(() {
      _myIp = myAddress;
      _time =
          "$now - ${(new DateTime.now().millisecond).toString().padLeft(3, '0')}";
    });
  }

  void _onClick() {
    _setIp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_myIp',
              style: TextStyle(
                  fontSize: 100,
                  color: Colors.black,
                  fontWeight: FontWeight.w100),
            ),
            Container(
              height: 60,
            ),
            Text(
              '$_time',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.black45,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClick,
        tooltip: 'Increment and get IP',
        child: Icon(Icons.subtitles),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
