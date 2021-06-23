import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
  
      home: TakePictureScreen(
        camera: firstCamera,
      ), 
      ),
    );
  
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    
    _controller = CameraController(
     
      widget.camera,
  
      ResolutionPreset.medium,
    );

    
    _initializeControllerFuture = _controller.initialize();
  }
 
  @override
  void dispose() {
    
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ictitle=Container(
      height: MediaQuery.of(context).size.height / 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
       Row(
      children: <Widget>[
        Expanded(
          child:Icon(Icons.arrow_back),
        ),
        const Spacer(),
        Text('Savings',
        textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        const Spacer(flex: 2)
      ],
    ),
    SizedBox(height: 20.0),
    Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
     child:Text('Pay through UPI',style: TextStyle(fontWeight: FontWeight.bold),),
    ),
    SizedBox(height: 8.0),
    Center(
  child:SizedBox(
      width: 350,
   child: TextFormField(
      autofocus: false,
          decoration: InputDecoration(
            hintText: 'Enter UPI Number ',
            contentPadding: EdgeInsets.fromLTRB(15.0,10.0, 20.0, 10.0),
            enabledBorder: UnderlineInputBorder(      
                            borderSide: BorderSide(color: Colors.purple),
            ),
            focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                  ),
          ),
        ),
    ),
        ),
        ],
    ),
    );
        final contact=Container(
    
          height: MediaQuery.of(context).size.height / 5,
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding:EdgeInsets.fromLTRB(15.0, 0, 0, 0),
         child: Text('Search Contacts',style: TextStyle(fontWeight:FontWeight.bold,),),
          ),
           SizedBox(height:8.0),
          Center(
            child: SizedBox(
              width:350,
             child:TextFormField(
               
          decoration: InputDecoration(
            hintText: 'Enter Number ',
            contentPadding: EdgeInsets.fromLTRB(15.0,10.0, 20.0, 10.0),
            enabledBorder: UnderlineInputBorder(      
                            borderSide: BorderSide(color: Colors.purple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                  ),
           suffixIcon: IconButton(
           onPressed: () {},
            icon: Icon(Icons.phone_android_outlined,color: Colors.purple,),
            ),
            
          ),
        ),
          ),
        ),
        SizedBox(height: 13.0),
        Row(children: <Widget>[
        Container(
  width: 75,
  height: 75,
  decoration: BoxDecoration(
	shape: BoxShape.circle,
	image: DecorationImage(
	  image: NetworkImage('https://content.fakeface.rest/female_14_873f53c26f0e35fd3678980a40211f7514452ac2.jpg'),
	  fit: BoxFit.fill,
	),
),),
Column(children: <Widget>[
  Text('Sumanth Varma',style: TextStyle(fontWeight: FontWeight.bold),),
  SizedBox(height: 8.0),
  Text('75035273489',style: TextStyle(color: Colors.grey),),
],),
        ],),
        ],
        ),
        );
      
                  
      return Scaffold(
      
        backgroundColor: Colors.white,
        
         body:SafeArea(
                        
             bottom: false,           
             child:ListView(
              
               padding: EdgeInsets.fromLTRB(0, 6, 0, 20),
               children:<Widget> [
                 ictitle,
                 SizedBox(height: 8.0),
                 Container(
                  height: MediaQuery.of(context).size.height / 2,

                 child:FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            
            return CameraPreview(_controller);
          } else {
            
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),),
      SizedBox(height: 8.0),
      contact,
      SizedBox(height:8.0),
  
      
      
      
                 
                 
               ],),),
      );
  
  } 
}

