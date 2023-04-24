import 'dart:math';

class Manager {
  final List<String> allCards = [];
  final User user0 = User();
  final User user1 = User();
  final User user2 = User();
  final User user3 = User();
  late final User me;
  void init() {
    xiPai();
  }

  void xiPai() {
    final temp = <String>[];
    for (var i = 0; i < 4; i++) {
      for (var j = 1; j <= 9; j++) {
        temp.add("W$j");
        temp.add("B$j");
        temp.add("T$j");
      }
      temp.add("E");
      temp.add("S");
      temp.add("W");
      temp.add("N");
      temp.add("Z");
      temp.add("F");
      temp.add("B");
    }

    allCards.clear();
    for (var i = temp.length; i > 0; i--) {
      allCards.add(temp.removeAt(random(i)));
    }
  }
}

class User {
  final List<String> cards = [];
}

int random(int max) => Random().nextInt(max);
