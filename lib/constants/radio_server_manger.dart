import 'dart:math';



class RadioServerManager {

  static final RadioServerManager _instance = RadioServerManager._internal();

  factory RadioServerManager() {
    return _instance;
  }

  RadioServerManager._internal();

  final Random _random = Random();

  final List<String> _servers = [
    'https://de1.api.radio-browser.info',
    'https://de2.api.radio-browser.info',
    'https://fi1.api.radio-browser.info',
    'https://nl1.api.radio-browser.info',
    'https://us1.api.radio-browser.info',
  ];

  int _currentIndex = 0;

  String getRandomServer() {
    _currentIndex = _random.nextInt(_servers.length);
    return _servers[_currentIndex];
  }


  String nextServer(){
    _currentIndex = (_currentIndex + 1 ) % _servers.length;
    return _servers[_currentIndex];
  }

  List<String> get allServers => _servers;
}
