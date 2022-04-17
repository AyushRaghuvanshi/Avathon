import 'package:conditional_builder/conditional_builder.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/views/charitypage.dart';
import 'package:project/views/popup.dart';
import 'package:project/widgets/searchbar.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

enum MenuAction { logout }

class _MainPageState extends State<MainPage> {
  String query = '';
  int a = 1;
  List charity = [];
  bool loader=true;
  var selectedcard;
  List somecharity = [];
  Future getdata() async {
    var response = await Dio().get(
        'https://api.data.charitynavigator.org/v2/Organizations?app_id=42f106f1&app_key=1efb3394edc9ab81c316e370b0676af9&pageSize=100&pageNum=$a&rated=true&sort=RATING%3ADESC');
    for (var i in response.data) {
      charity.add(i);
      print(i);
    }
    print(somecharity.length);

    return charity;
  }

  Future _asyncMethod() async {
    await getdata();
    setState(() {
      somecharity = charity;
      loader=false;
    });
  }
Future _fetchdata() async{
    somecharity=somecharity;
}

  @override
  void initState() {
    
    charity = [];
    somecharity = [];

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });
    
  }

  @override
  Widget build(BuildContext context) {
      


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
//
        title: const Text("Charity Finder"),
        actions: [
          ConditionalBuilder(
            condition: loader,
            builder: (context){
              return Center(child: CircularProgressIndicator(color: Colors.white,));
            },
          )
          ,
          PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldlogout = await showLogoutPop(context);
                  if (shouldlogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (route) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuAction>(
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Logout ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(Icons.logout_rounded, color: Colors.black),
                    ],
                  ),
                  value: MenuAction.logout,
                )
              ];
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0x55FFE5B4)),
        child: Column(
          children: [
            buildSearch(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton.icon(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                      onPressed: () async {
                        if (a == 1) {
                          return;
                        }
                        setState(() {
                          loader=true;
                        });
                        
                        charity = [];
                        somecharity = [];
                        try {
                          await getdata();
                        } catch (e) {
                          await showErrorPopup(context, 'No More Data Found');
                          return;
                        }
                        setState(() {
                          a--;
                          somecharity = [];

                          somecharity = charity;
                          loader=false;
                        });
                        
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      label: const Text("")),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text("$a"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                      onPressed: () async {
                        charity = [];
                        somecharity = [];
                        setState(() {
                          loader=true;
                        });
                        try {
                          await getdata();
                        } catch (e) {
                          await showErrorPopup(context, 'No More Data Found');
                          return;
                        }
                        setState(() {
                          a++;
                          

                          somecharity = charity;
                          loader=false;
                        });
                        searchBook('');
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      label: const Text("")),
                ),
              ],
            ),
            FutureBuilder(
              future: _fetchdata() ,
              builder: (context, AsyncSnapshot ){
                
                if(somecharity==[]){
                  return CircularProgressIndicator();
                }
                else{
                
                return Container(
                  
                  child: Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(

                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:  Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: ListView.builder(
                        itemCount: somecharity.length,
                        itemBuilder: (context, i) {
                          final data = somecharity[i];
            
                          return buildcard(data);
                        }),
                  ),
              )),
                );}
              }),
          ],
        ),
      ),
    );
  }

  Widget buildcard(data) => TextButton(
        onPressed: () {
          selectedcard = data;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => charitypage(
                      text: selectedcard,
                    )),
          );
        },
        child: ListTile(
          contentPadding: const EdgeInsets.all(5),
          title: Text(data['charityName'] ?? ""),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['tagLine'] ?? ""),
              Image.network(data['currentRating']['ratingImage']['large'] ?? "")
            ],
          ),
          leading: Image.network(data['category']['image'] ?? ""),
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Charity Name or Tagline',
        onChanged: searchBook,
      );

  void searchBook(String query) {
    final somecharity = charity.where((name) {
      final namelower = name['charityName'].toString().toLowerCase();
      final tagline = name['tagLine'].toString().toLowerCase();
      final searchlower = query.toLowerCase();
      return namelower.contains(searchlower) || tagline.contains(searchlower);
    }).toList();
    setState(() {
      this.query = query;
      this.somecharity = somecharity;
    });
  }
}
