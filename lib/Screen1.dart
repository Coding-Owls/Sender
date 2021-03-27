import 'dart:async';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class Screen1 extends StatefulWidget{
  String message;
  String id;
  Screen1({
    this.message,
    this.id
  });

  @override
  State<StatefulWidget> createState() {
    return Screen1State(message: message, id: id);
  }


}

class Screen1State extends State<Screen1>{

  String message;
  String id;
  Screen1State({this.message, this.id});
  String uuid;
  static const int majorId = 1;
  static const int minorId = 100;
  static const int transmissionPower = -59;
  static const String identifier = 'Coding Owls';
  static const AdvertiseMode advertiseMode = AdvertiseMode.lowPower;
  static const String layout = BeaconBroadcast.ALTBEACON_LAYOUT;
  static const int manufacturerId = 0x0118;

  BeaconBroadcast beaconBroadcast = BeaconBroadcast();

  BeaconStatus _isTransmissionSupported;
  bool _isAdvertising = false;

  StreamSubscription<bool> _isAdvertisingSubscription;

  @override
  void initState() {
    super.initState();
    beaconBroadcast
        .checkTransmissionSupported()
        .then((isTransmissionSupported) {
      setState(() {
        _isTransmissionSupported = isTransmissionSupported;
      });
    });

    _isAdvertisingSubscription =
        beaconBroadcast.getAdvertisingStateChange().listen((isAdvertising) {
          setState(() {
            _isAdvertising = isAdvertising;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    uuid = id;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Beacon Broadcast'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/send.gif", height: 500,width: 500,),
                Text('Is beacon started?',
                    style: Theme.of(context).textTheme.headline5),
                Text('$_isAdvertising',
                    style: Theme.of(context).textTheme.subtitle1),
                Container(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: RaisedButton(
                        color: Colors.brown,
                        onPressed: () {
                          beaconBroadcast
                              .setUUID(uuid)
                              .setMajorId(majorId)
                              .setMinorId(minorId)
                              .setTransmissionPower(transmissionPower)
                              .setAdvertiseMode(advertiseMode)
                              .setIdentifier(identifier)
                              .setLayout(layout)
                              .setManufacturerId(manufacturerId)
                              .start();
                        },
                        child: Text('START',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    Center(
                      child: RaisedButton(
                        color: Colors.brown,
                        onPressed: () {
                          beaconBroadcast.stop();
                        },
                        child: Text('STOP', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_isAdvertisingSubscription != null) {
      _isAdvertisingSubscription.cancel();
    }
  }
}