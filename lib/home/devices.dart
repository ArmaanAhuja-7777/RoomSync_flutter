import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class Devices extends StatefulWidget {
  const Devices({super.key});

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  late IOWebSocketChannel _channel;
  late bool _fanStatus;
  late bool _ledStatus;

  @override
  void initState() {
    super.initState();
    _channel = IOWebSocketChannel.connect('ws://20.55.55.11:6969');
    _fanStatus = false; // Initialize fan status
    _ledStatus = false; // Initialize LED status
    _channel.stream.listen(
      (data) {
        Map<String, dynamic> parsedData = json.decode(data);
        print(parsedData);
        setState(() {
          _fanStatus = parsedData['fan_status'] ?? false;
          _ledStatus = parsedData['led_status'] ?? false;
        });
      },
      onError: (error) {
        print('Error: $error');
        // Handle error, e.g., show an error message
      },
      onDone: () {
        print('Connection closed');
        // Handle connection closed, e.g., show a message to reconnect
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Fan Status:'),
            Switch(
              value: _fanStatus,
              onChanged: (value) {
                _channel.sink.add(json.encode({'fan_status': value}));
              },
            ),
            Text('LED Status:'),
            Switch(
              value: _ledStatus,
              onChanged: (value) {
                _channel.sink.add(json.encode({'led_status': value}));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
