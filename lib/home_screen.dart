import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_open_apis/apod_model.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  ApodModel? apodModel;

  Future<void> fetchData() async {
    final url = Uri.parse("https://api.nasa.gov/planetary/apod?api_key=nKbmC5xUZBLot7dy5GSIXMEkeaIj7jiMFI79DO6E");

    try{

      final response = await http.get(url);

      if(response.statusCode == 200){

        apodModel = ApodModel.fromJson(jsonDecode(response.body));

        print((response.body));

        setState(() {});

      }else{
        print("error : ${response.statusCode}");
      }

    }catch(error){
      print(error);
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Home Screen"),
      ),
      body: apodModel == null ? Center(child: CircularProgressIndicator(),) : Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(apodModel?.title ?? "none", style: TextStyle(fontSize: 30),),

            Image.network(apodModel?.url ?? ""),
            
            Text(apodModel?.explanation ?? "")
          ],
        ),
      ),
    );
  }
}
