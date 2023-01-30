import 'dart:async';
import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


final client = MqttServerClient.withPort('194.59.165.32', 'rama', 1883);

var data;
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

  try {
    await client.connect();
    client.subscribe('pummamqtt', MqttQos.atLeastOnce);
  } catch (e) {
    print('Errornya karena : $e');
    client.disconnect();
  }

  client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    print('$tag payload = ${c[0].topic}');
    final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
    final payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
    data = jsonDecode(payload);
    print('DATA FROM SENSOR : $payload');
    print('Ketinggian Air : ${data['tinggi']}!');
  });

   return client;
}

// connection succeeded
void onConnected() {
  print('Connected');
}

// unconnected
void onDisconnected() {
  print('Disconnected');
}

// subscribe to topic succeeded
void onSubscribed(String topic) {
  print('Subscribed topic: $topic');
}

// subscribe to topic failed
void onSubscribeFail(String topic) {
  print('Failed to subscribe $topic');
}

// unsubscribe succeeded
void onUnsubscribed(String topic) {
  print('Unsubscribed topic: $topic');
}

// PING response received
void pong() {
  print('Ping response client callback invoked');
}
