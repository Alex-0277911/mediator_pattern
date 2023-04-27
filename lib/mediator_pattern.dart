//Паттерн медіатор - це патерн проектування, який сприяє вільному зв'язку між
// об'єктами, інкапсулюючи їхню взаємодію в об'єкті-медіаторі. Паттерн медіатор
// корисний у ситуаціях, коли група об'єктів повинна взаємодіяти один з одним,
// але вони не повинні бути щільно з'єднані один з одним.

// У Dart ви можете реалізувати патерн медіатор, визначивши клас медіатора,
// який інкапсулює взаємодію між об'єктами. Клас медіатора повинен мати
// посилання на всі об'єкти, які повинні взаємодіяти один з одним.

// Ось приклад реалізації патерну медіатора в Dart:

// У цьому прикладі ми маємо двох конкретних колег, ConcreteColleague1 і
// ConcreteColleague2, і посередника, Mediator, який є посередником у взаємодії
// між двома колегами. Кожен колега має посилання на посередника, яке він
// використовує для надсилання повідомлень іншому колезі. Коли колега надсилає
// повідомлення, посередник отримує його і пересилає відповідному колезі.

abstract class Colleague {
  void send(String message);
  void receive(String message);
}

class ConcreteColleague1 extends Colleague {
  late Mediator _mediator;

  ConcreteColleague1(Mediator mediator) {
    _mediator = mediator;
  }

  @override
  void send(String message) {
    _mediator.send(message, this);
  }

  @override
  void receive(String message) {
    print('ConcreteColleague1 received message: $message');
  }
}

class ConcreteColleague2 extends Colleague {
  late Mediator _mediator;

  ConcreteColleague2(Mediator mediator) {
    _mediator = mediator;
  }

  @override
  void send(String message) {
    _mediator.send(message, this);
  }

  @override
  void receive(String message) {
    print('ConcreteColleague2 received message: $message');
  }
}

class Mediator {
  late ConcreteColleague1 _colleague1;
  late ConcreteColleague2 _colleague2;

  set colleague1(ConcreteColleague1 colleague1) {
    _colleague1 = colleague1;
  }

  set colleague2(ConcreteColleague2 colleague2) {
    _colleague2 = colleague2;
  }

  void send(String message, Colleague colleague) {
    if (colleague == _colleague1) {
      _colleague2.receive(message);
    } else if (colleague == _colleague2) {
      _colleague1.receive(message);
    }
  }
}

void main() {
  Mediator mediator = Mediator();
  ConcreteColleague1 colleague1 = ConcreteColleague1(mediator);
  ConcreteColleague2 colleague2 = ConcreteColleague2(mediator);

  mediator.colleague1 = colleague1;
  mediator.colleague2 = colleague2;

  colleague1.send('Hello, colleague2!');
  colleague2.send('Hi, colleague1!');
}
