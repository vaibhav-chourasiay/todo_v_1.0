import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn/dbhelper.dart';
import 'package:learn/pages/addpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sqlite",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.pacifico().fontFamily,
      ),
      routes: {
        "/": (context) => const HomePage(),
        "addtask": (context) => const AddPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper? d;
  Future<List<dynamic>>? datalist;
  @override
  void initState() {
    super.initState();
    d = DatabaseHelper.instance;

    getData();
  }

// this is inset data function for ui
  getData() {
    datalist = d!.getdata();
  }

// to delete value
  deletevalue(int id) {
    // print("get inside => $id");
    d!.deleteData(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Sqlite"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: datalist,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List detail = snapshot.data ?? [];
                  return Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemBuilder: (context, index) {
                        bool value = false;

                        return Card(
                          elevation: 10.0,
                          color: Colors.deepPurple[100],
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [Icon(CupertinoIcons.bag)],
                            ),
                            title: Text(
                              detail[index]["title"],
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              detail[index]["des"],
                              style: const TextStyle(
                                color: Colors.black54,
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  fillColor: MaterialStateProperty.all(
                                      Colors.deepPurpleAccent),
                                  value: value,
                                  onChanged: (value) {
                                    value = value!;
                                    deletevalue(detail[index]["id"]);
                                    getData();
                                    setState(() {});
                                  },
                                  activeColor: Colors.deepPurple,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: detail.length,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "addtask").then((value) {
            getData();
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
