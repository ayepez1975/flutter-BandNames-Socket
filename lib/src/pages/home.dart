// ignore_for_file: avoid_print

import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'AC-DC', votes: 2),
    Band(id: '3', name: 'Credence', votes: 5),
    Band(id: '4', name: 'Soda Stereo', votes: 9)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, int i) => _bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        elevation: 0,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: ((direction) {
        print(direction);
        print('id banda ${band.id}');
        //llamar el borrado en el server
      }),
      background: Container(
        padding: EdgeInsets.only(left: 8),
        color: Colors.red,
        alignment: Alignment.centerLeft,
        child: const Text(
          'Band Delete',
          style: TextStyle(color: Colors.white),
        ),
      ),
      key: Key(band.id),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: (() {
          print(band.name);
        }),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    Platform.isAndroid
        ? showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text('New Band name'),
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  MaterialButton(
                    elevation: 5,
                    onPressed: () {
                      print(textController.text);
                      addBandToList(textController.text);
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              );
            })
        : showCupertinoDialog(
            context: context,
            builder: (_) {
              return CupertinoAlertDialog(
                title: const Text('New Band name'),
                content: CupertinoTextField(
                  controller: textController,
                ),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: (() {
                      addBandToList(textController.text);
                    }),
                    child: const Text('Add'),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: const Text('Dismiss'),
                  )
                ],
              );
            });
  }

  addBandToList(String name) {
    if (name.length > 1) {
      setState(() {
        bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      });
    }
    Navigator.pop(context);
  }
}
