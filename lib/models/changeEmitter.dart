import 'package:rxdart/rxdart.dart';

abstract class ChangeEmitter {
  BehaviorSubject<void> changeEmitter;
}
