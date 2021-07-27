import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class AudioUtil {
  AudioUtil._internal();
  static AudioUtil _instance = AudioUtil._internal();

  static AudioUtil get instance => _instance;

  Future<void> init(List<String> files) async {
    Flame.bgm.initialize();
    await Flame.audio.loadAll(files);
    _pref = await Hive.openBox('preferences');

    if (_pref.get('bgm') == null) {
      _pref.put('bgm', true);
    }
    if (_pref.get('sfx') == null) {
      _pref.put('sfx', true);
    }
    _sfx = ValueNotifier(_pref.get('sfx'));
    _bgm = ValueNotifier(_pref.get('bgm'));
  }

  late Box _pref;
  late ValueNotifier<bool> _sfx;
  late ValueNotifier<bool> _bgm;
  ValueNotifier<bool> get listenSfx => _sfx;
  ValueNotifier<bool> get listenBgm => _bgm;

  void setSfx(bool flag) {
    _pref.put('sfx', flag);
    _sfx.value = flag;
  }

  void setBgm(bool flag) {
    _pref.put('bgm', flag);
    _bgm.value = flag;
  }
}
