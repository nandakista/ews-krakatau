import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

Future<MqttServerClient> connectClient() async {
  String tag = 'MqttClient';

  MqttServerClient client = MqttServerClient.withPort('194.59.165.32', 'rama', 1883);
  client.logging(on: false);
  client.onConnected = onConnected;
  client.onDisconnected = onDisconnected;
  client.onSubscribed = onSubscribed;
  client.onSubscribeFail = onSubscribeFail;
  client.pongCallback = pong;
  final connMessage = MqttConnectMessage()
      .authenticateAs('unila', 'pwdMQTT@123')
      .withClientIdentifier("Mqtt_MyClientUniqueId")
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMessage;
  return client;

  try {
    await client.connect();
    client.subscribe('pummamqtt', MqttQos.atLeastOnce);
  } catch (e) {
    debugPrint('Errornya karena : $e');
    client.disconnect();
  }

  client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    debugPrint('$tag payload = ${c[0].topic}');
    final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
    final payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
    final data = jsonDecode(payload);
    debugPrint('DATA FROM SENSOR : $payload');
    debugPrint('Ketinggian Air : ${data['tinggi']}!');
  });
}

void onConnected() {
  debugPrint('Connected');
}

void onDisconnected() {
  debugPrint('Disconnected');
}

void onSubscribed(String topic) {
  debugPrint('Subscribed topic: $topic');
}

void onSubscribeFail(String topic) {
  debugPrint('Failed to subscribe $topic');
}

void onUnsubscribed(String topic) {
  debugPrint('Unsubscribed topic: $topic');
}

// PING response received
void pong() {
  debugPrint('Ping response client callback invoked');
}
