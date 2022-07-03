
import 'package:chatboot_rl_nlp/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Helper? helper;
  String response = "default";

  TextEditingController _txt = new TextEditingController();

  int _count = 0;

  int _whoSendMsg = 0;
  List<String> listesMsg = [];
  List<int> persons = [];

  @override
  void initState() {
    helper = Helper();
    super.initState();
  }

  Future initialize(String request) async{
    if( helper != null) {
      response = await helper?.getResponse(request) as String;
      setState(() {
        listesMsg.add(response);
        persons.add(1);
        _count = _count + 1;
        print(response);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: SafeArea(
        child: Column(
          children: [
            _topChat(),
            _bodyChat(),
            Container(
              height: 55,
              color: Colors.white,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.emoji_emotions_outlined),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            hintText: "type text",
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.transparent)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.blueGrey)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.transparent)
                            ),
                          ),
                          controller: _txt,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          setState((){
                            listesMsg.add(_txt.text.trim());
                            persons.add(0);
                            _count = _count + 1;
                            initialize(_txt.text.trim());
                            _txt.text = "";

                          });
                        },
                        icon: Icon(Icons.send),
                      )
                    ],
                  ),
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.blueGrey
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _topChat(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 18,),
          Center(child: Text("Sarah", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),)),
          Center(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://c.tenor.com/CigpzapemsoAAAAi/hi-robot.gif"),
                  fit: BoxFit.contain
                )
              ),
            )
          )
        ],
      ),
    );
  }
  Widget _bodyChat() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: List.generate(_count,
                        (index) =>
                            _itemChat(
                              chat: persons[index],
                              message: listesMsg[index],
                              time: DateFormat("kk:mm").format(DateTime.now()),
                            ),
                ),
              )
            ),
            /*Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  _itemChat(
                    avatar: 'assets/image/robot.png',
                    chat: 1,
                    message: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    time: '18.00',
                  ),
                  _itemChat(
                    chat: 0,
                    message: 'Okey 🐣',
                    time: '18.00',
                  ),
                  _itemChat(
                    avatar: 'assets/image/robot.png',
                    chat: 1,
                    message: 'It has survived not only five centuries, 😀',
                    time: '18.00',
                  ),
                  _itemChat(
                    avatar: 'assets/image/me.png',
                    chat: 0,
                    message:
                    'Contrary to popular belief, Lorem Ipsum is not simply random text. 😎',
                    time: '18.00',
                  ),
                  _itemChat(
                    avatar: 'assets/image/robot.png',
                    chat: 1,
                    message:
                    'The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
                    time: '18.00',
                  ),
                  _itemChat(
                    avatar: 'assets/image/robot.png',
                    chat: 1,
                    message: '😅 😂 🤣',
                    time: '18.00',
                  ),_itemChat(
                    avatar: 'assets/image/me.png',
                    chat: 0,
                    message:
                    'Contrary to popular belief, Lorem Ipsum is not simply random text. 😎',
                    time: '18.00',
                  ),_itemChat(
                    avatar: 'assets/image/me.png',
                    chat: 0,
                    message:
                    'Contrary to popular belief, Lorem Ipsum is not simply random text. 😎',
                    time: '18.00',
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),*/
          ],
        ),
      ),

    );
  }


  // 0 = Send
  // 1 = Recieved
  _itemChat({required int chat, String? avatar, message, time}) {
    return Row(
      mainAxisAlignment: chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        chat == 1 ? Avatar(image: "assets/image/robot.png", size: 35,) : Text('$time', style: TextStyle(color: Colors.grey.shade400),),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: chat == 0 ? Colors.indigo.shade100 : Colors.indigo.shade50,
              borderRadius: chat == 0
                  ? BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )
                  : BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Text('$message'),
          ),
        ),
        chat == 0 ? Avatar(image: "assets/image/me.png", size: 35,) : Text('$time', style: TextStyle(color: Colors.grey.shade400),),
      ],
    );
  }
  Widget _formChat() {
    return Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 120,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          color: Colors.white,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Type your message...',
              suffixIcon: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.indigo),
                padding: EdgeInsets.all(14),
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.all(20),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final double size;
  final image;
  final EdgeInsets margin;
  Avatar({this.image, this.size = 35, this.margin = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}