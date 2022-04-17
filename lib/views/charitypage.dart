import 'package:flutter/material.dart';

import 'package:link_text/link_text.dart';

class charitypage extends StatefulWidget {
  Map text;

  charitypage({ Key? key, required this.text }) : super(key: key);

  
  @override
  State<charitypage> createState() => _charitypageState();
}

class _charitypageState extends State<charitypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.text['charityName']),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.network(widget.text['category']['image']),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(       
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const Text("Tagline:  ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.only(left: 10)
                      ,
                      decoration: BoxDecoration(border: Border.all(),borderRadius: const BorderRadius.all(Radius.circular(15))),
                      
                      width: 260,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.text['tagLine'],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),softWrap: true,),
                      ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(       
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Mission:  ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Container(
                      decoration: BoxDecoration(border: Border.all(),borderRadius: const BorderRadius.all(Radius.circular(15))),
                      
                      padding: const EdgeInsets.only(left: 10)
                      ,
                      width: 260,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.text['mission'],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),softWrap: true,),
                      ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(       
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Website URL:  ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Container(
                      decoration: BoxDecoration(border: Border.all(),borderRadius: const BorderRadius.all(Radius.circular(15))),
                      
                      padding: const EdgeInsets.only(left: 10)
                      ,
                      width: 226,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinkText(widget.text['websiteURL'],)//style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),softWrap: true,),
                      ))
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(       
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Donation Address :  ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      Container(
                        decoration: BoxDecoration(border: Border.all(),borderRadius: const BorderRadius.all(Radius.circular(15))),
                        
                        padding: const EdgeInsets.only(left: 10)
                        ,
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text((widget.text['mailingAddress']['streetAddress1']?? "")+',\n'+(widget.text['mailingAddress']["streetAddress2"]??"")+',\n'+(widget.text['mailingAddress']['city']??"")+','+(widget.text['mailingAddress']['stateOrProvince']??"")+","+(widget.text['mailingAddress']['country']??"")+',\n'+(widget.text['mailingAddress']['postalCode']??""))//style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),softWrap: true,),
                        ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}