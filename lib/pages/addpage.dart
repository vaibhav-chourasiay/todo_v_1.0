import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn/dbhelper.dart';
import 'package:learn/models.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> with TickerProviderStateMixin {
  Animation? animation;

  AnimationController? animationController;

  Animation? animation2;

  AnimationController? animationController2;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _des = TextEditingController();
  final d = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    // for add task
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween(begin: 0.0, end: 40.0).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeInOut,
    ));
    animationController!.addListener(() {
      setState(() {});
    });
    animationController!.forward();
    // for button
    animationController2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation2 = Tween(begin: 0.0, end: 70.0).animate(CurvedAnimation(
      parent: animationController2!,
      curve: Curves.easeInOut,
    ));
    animationController2!.addListener(() {
      setState(() {});
    });
    animationController2!.forward();
  }

// this is inset data function for ui
  Future<int> inset(String _title, String _des) {
    return d.insetData(MyModal(title: _title, des: _des));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "Add Task",
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              size: 40.0,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Here.",
                    style: TextStyle(
                      fontSize:
                          (animation!.value != null) ? animation!.value : 20.0,
                      fontFamily: "lato",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "your daily task!",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "lato",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _title,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please write something here";
                              }
                            },
                            style: const TextStyle(
                                color: Colors.white, fontFamily: "lato"),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              enabled: true,
                              hintText: "Enter Your Aim !",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                            controller: _des,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please write something here";
                              }
                            },
                            style: const TextStyle(
                                color: Colors.white, fontFamily: "lato"),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              enabled: true,
                              hintText: "Enter description here !",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35.0,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                int i = await inset(_title.text, _des.text);

                                // ignore: avoid_print
                                print(i);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Task is added"),
                                  ),
                                );
                              }
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: (animation2!.value != null)
                                        ? animation2!.value
                                        : 10),
                              ),
                            ),
                            child: const Text(
                              "Submit Your Today's Task",
                              style: TextStyle(
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
