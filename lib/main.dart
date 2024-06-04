import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: PageView(
          children: [
            Screen1(),
            Screen2(),
            Screen3(),
            Screen4(),
          ],
        ),
        theme: ThemeData(
          textTheme: GoogleFonts.bungeeSpiceTextTheme(),
        ),
        debugShowCheckedModeBanner: false);
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('from LETO'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text(
              'COOLGRAM',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('swipe right to register ->',
                  textDirection: TextDirection.ltr),
            ),
          ),
        ],
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final _formKey = GlobalKey<FormState>();
  String _status = 'busy';
  String _status1 = 'busy';

  void _buyCrypto() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final message = 'success';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _sellCrypto() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final message = 'well please register';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'registration',
          style: GoogleFonts.bungeeSpice(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) => _status = value!,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'login',
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                onSaved: (value) => _status1 = value!,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _buyCrypto,
                    child: Text('register'),
                  ),
                  ElevatedButton(
                    onPressed: _sellCrypto,
                    child: Text('exit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<String> columnList = [];
  List<String> listViewList = [];
  List<String> listViewSeparatedList = [];
  var currentItem = "";
  int activeListType = 1;

  void addItemToList(String item, int listType) {
    setState(() {
      if (listType == 0) columnList.add(item);
      else if (listType == 1) listViewList.add(item);
      else if (listType == 2)listViewSeparatedList.add(item);
    });
  }

  void removeCrypt(int index) {
    setState(() {
      columnList.removeAt(index);
    });
  }

  void removeStock(int index) {
    setState(() {
      listViewList.removeAt(index);
    });
  }

  void removeMet(int index) {
    setState(() {
      listViewSeparatedList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What to buy?'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Cryptocurrency', //Column List
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              children: List.generate(columnList.length, (index) {
                return ListTile(
                  tileColor: Colors.green.shade100,
                  title: Text(columnList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      removeCrypt(index);
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Text('Stock', // ListView
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: listViewList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Colors.green.shade200,
                  title: Text(listViewList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      removeStock(index);
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text('Precious metals', // ListView.separated
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              itemCount: listViewSeparatedList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Colors.green.shade300,
                  title: Text(listViewSeparatedList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      removeMet(index);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add assets'),
                content: TextField(
                  onChanged: (value) {
                    currentItem = value;
                  },
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      addItemToList(currentItem, activeListType);
                      Navigator.of(context).pop();
                      currentItem = '';
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeListType,
        onTap: (int index) {
          setState(() {
            // _selectedIndex = index;
            activeListType = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Cryptocurrency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            label: 'Precious metals',
          ),
        ],
      ),
    );
  }
}

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4>{
  who() {
    if (Platform.isIOS) return IosPage();
    if (Platform.isWindows) return WinPage();
    if (kIsWeb) return WebPage();
    if (Platform.isAndroid) return AndroidPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: who(),
    );
  }
}

class IosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('IOS page', style: GoogleFonts.bungeeSpice(),),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.apple, size: 500, color: Colors.black,),
            ],
          )
      ),
    );
  }
}

class WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Web page', style: GoogleFonts.bungeeSpice(),),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.web, size: 500, color: Colors.black,),
            ],
          )
      ),
    );
  }
}

class AndroidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Android page', style: GoogleFonts.bungeeSpice(),),
          backgroundColor: Colors.white,
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.android, size: 500, color: Colors.black,),
              ],
            )
        )
    );
  }
}

class WinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Desktop page', style: GoogleFonts.bungeeSpice(), ),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.desktop_windows, size: 500, color: Colors.black,),
            ],
          )
      ),
    );
  }
}