import 'package:flutter/material.dart';
import 'package:shepai/manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final manager = Manager();
  @override
  void initState() {
    super.initState();
    manager.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: manager.me.cards.map((e) => buildCard(e)).toList(),
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      manager.init();
                    });
                  },
                  icon: const Icon(Icons.restore),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String card) {
    return InkWell(
      onTap: () {
        setState(() {
          manager.shePai(card);
        });
      },
      child: Container(
        width: 60,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 2,
            color: const Color(0xff666666),
          ),
          image: DecorationImage(
            image: AssetImage('assets/$card.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
