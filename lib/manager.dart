import 'dart:math';

class Manager {
  final List<String> allCards = [];
  final List<String> haili = [];
  final User user0 = User(0);
  final User user1 = User(1);
  final User user2 = User(2);
  final User user3 = User(3);
  late final List<User> users = [user0, user1, user2, user3];
  late User me;
  late User zhuang;
  late User activedUser;

  List<String> get iDontKnowCards {
    // others users` cards + left cards
    final cards = users
        .where((e) => e != me)
        .map((e) => e.cards)
        .expand((e) => e)
        .toList();
    cards.addAll(allCards);
    cards.sort(cardComparer);
    return cards;
  }

  List<String> get iWillTakeCards {
    final ii = (activedUser.index - me.index + 3) % 4;
    final cards = <String>[];
    for (var i = 0; i < allCards.length; i++) {
      if (i % 4 == ii) {
        cards.add(allCards[i]);
      }
    }

    return cards;
  }

  void init() {
    allCards.clear();
    haili.clear();
    for (final u in users) {
      u.cards.clear();
    }

    me = users[random(4)];
    activedUser = zhuang = users[random(4)];

    xiPai();

    daShaizi();

    faPai();

    haili.add(zhuang.cards.removeAt(random(14)));

    waitShePai();
  }

  void xiPai() {
    final temp = <String>[];
    for (var i = 0; i < 4; i++) {
      for (var j = 1; j <= 9; j++) {
        temp.add("${j}W");
        temp.add("${j}B");
        temp.add("${j}T");
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

  void daShaizi() {
    final shanzi1 = random(12) + 1;
    final shanzi2 = random(12) + 1;

    final tempCards = [...allCards];
    allCards.clear();
    final start = (shanzi1 + shanzi2) * 2;
    allCards.addAll(
      [
        ...tempCards.getRange(start, tempCards.length),
        ...tempCards.getRange(0, start)
      ],
    );
  }

  void faPai() {
    final zhuangIndex = zhuang.index;
    for (var j = 0; j < 3; j++) {
      for (var i = zhuangIndex; i < zhuangIndex + 4; i++) {
        final user = users[i % 4];
        final range = allCards.getRange(0, 4);
        user.cards.addAll(range);
        allCards.removeRange(0, 4);
      }
    }
    for (var i = zhuangIndex; i < zhuangIndex + 4; i++) {
      final user = users[i % 4];
      user.cards.add(allCards.removeAt(0));
    }
    zhuang.cards.add(allCards.removeAt(0));
  }

  void shePai(String card) {
    if (!me.cards.contains(card)) {
      throw 'have no this card $card!';
    }

    me.cards.removeAt(me.cards.indexOf(card));
    waitShePai();
  }

  void waitShePai() {
    while (allCards.length > 12) {
      activedUser = users[(activedUser.index + 1) % 4];
      activedUser.cards.add(allCards.removeAt(0));
      if (activedUser != me) {
        haili.add(activedUser.cards.removeAt(random(14)));
        continue;
      }

      print('haili: $haili');
      print('I don`t know cards: $iDontKnowCards');
      print('I will take cards: $iWillTakeCards');
      print('my cards $me');
      return;
    }
  }
}

class User {
  final int index;
  final List<String> cards = [];

  User(this.index);

  @override
  String toString() {
    cards.sort(cardComparer);
    return '$index: $cards';
  }
}

int cardComparer(String a, String b) {
  if (a == b) {
    return 0;
  } else if (a.length == 2 && b.length == 1) {
    return -1;
  } else if (a.length == 1 && b.length == 2) {
    return 1;
  } else if (a.length == 2 && b.length == 2) {
    final first = a[1].compareTo(b[1]);
    if (first != 0) return first;
    return a[0].compareTo(b[0]);
  } else if (a.length == 1 && b.length == 1) {
    final fengs = ['E', 'S', 'W', 'N', 'Z', 'F', 'B'];
    return fengs.indexOf(a).compareTo(fengs.indexOf(b));
  }
  throw 'error';
}

int random(int max) => Random().nextInt(max);
