import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _haveStarted3Times = '';

  void initState(){
    super.initState();
    _incrementStartup();
  }

  Future<int>_getIntFromSharedPref() async {
    final pfres = await SharedPreferences.getInstance();
    final startupNumber = pfres.getInt('startupNumber');
    if(startupNumber == null){
      return 0;
    }
    return startupNumber;

  }
  Future<void> _resetCounter() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('startupNumber', 0);
  }
  Future<void> _incrementStartup() async{
    final prefs = await SharedPreferences.getInstance();
    int lastStartupNumber = await _getIntFromSharedPref();
    int currentStartupNumber = ++lastStartupNumber;
    await prefs.setInt('startupNumber', currentStartupNumber); 
    if(currentStartupNumber == 3 ){
      setState(() =>_haveStarted3Times = '  $currentStartupNumber Times completed' );
      await _resetCounter();
    }
    else{
       setState(() =>_haveStarted3Times = '  $currentStartupNumber Times completed' );

    }
    
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(child: Text(_haveStarted3Times,style: TextStyle(fontSize: 32),),),

    );
  }
}