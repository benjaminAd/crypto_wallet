import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'add_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color : Colors.white,
        ),
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.uid).collection('Coins').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                  );
              }

              return ListView(
                children : snapshot.data!.docs.map((document) => Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Coin Name : ${document.id}"),
                      Text("Amount Owned : ${document.data()['Amount']}"),
                    ],
                  ),
                )).toList(),
              );
            },
          ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddView()));
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor : Colors.blue,

      ),
    );
  }
}