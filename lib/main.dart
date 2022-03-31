import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "Hello World...!";
  Future _scanQR() async {
    try {
      String? cameraScanResult = await scanner.scan();
      setState(() {
        result = cameraScanResult!; // setting string result with cameraScanResult
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner Example In Flutter"),
      ),
      body: Center(
        child: Text(result), // Here the scanned result will be shown
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          onPressed: () async{
          //  var status =await Permission.camera.status;
            if(await Permission.camera.request().isGranted){
       //       print(status);
            _scanQR(); }

          },

          label: Text("Scan")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}