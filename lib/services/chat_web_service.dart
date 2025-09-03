import 'dart:async';
import 'dart:convert';
import 'package:web_socket_client/web_socket_client.dart';

class ChatWebService {
  static final _instance = ChatWebService._internal();
  WebSocket? _socket;
  bool _isConnected = false;

  factory ChatWebService() => _instance;

  ChatWebService._internal();
  final _searchResultController = StreamController<Map<String, dynamic>>();
  final _contentController = StreamController<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get searchResultStream =>
      _searchResultController.stream;
  Stream<Map<String, dynamic>> get contentStream => _contentController.stream;
  bool get isConnected => _isConnected;

  void connect() {
    try {
      _socket = WebSocket(Uri.parse("ws://localhost:8000/ws/chat"));

      _socket!.messages.listen(
        (message) {
          final data = json.decode(message);
          print('Received message: $data'); // Debug log
          
          // Handle the actual format from your backend
          if (data.containsKey('type')) {
            if (data['type'] is List) {
              // Your backend sends search results in the 'type' field as a List
              final searchResults = data['type'] as List;
              print('Processing search results: ${searchResults.length} items');
              _searchResultController.add({
                'type': 'search_result',
                'data': searchResults
              });
            } else if (data['type'] == 'search_result') {
              _searchResultController.add(data);
            } else if (data['type'] == 'content') {
              _contentController.add(data);
            } else {
              print('Unknown message type: ${data['type']}');
            }
          } else {
            print('Message missing type field: $data');
          }
        },
        onError: (error) {
          print('WebSocket error: $error');
          _isConnected = false;
        },
        onDone: () {
          print('WebSocket connection closed');
          _isConnected = false;
        },
      );
      
      // Listen for connection state changes
      _socket!.connection.listen(
        (state) {
          print('WebSocket state: $state');
          _isConnected = state is Connected;
        },
      );
    } catch (e) {
      print('Failed to connect to WebSocket: $e');
      _isConnected = false;
    }
  }

  void chat(String query) {
    print('Sending query: $query');
    if (_socket != null && _isConnected) {
      _socket!.send(json.encode({'query': query}));
      print('Message sent successfully');
    } else {
      print('WebSocket not connected. Cannot send message.');
      // Optionally, you could try to reconnect here
      // connect();
    }
  }
}
