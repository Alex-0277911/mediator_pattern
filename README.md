Паттерн медіатор - це патерн проектування, який сприяє вільному зв'язку між
об'єктами, інкапсулюючи їхню взаємодію в об'єкті-медіаторі. Паттерн медіатор
корисний у ситуаціях, коли група об'єктів повинна взаємодіяти один з одним,
але вони не повинні бути щільно з'єднані один з одним.

У Dart ви можете реалізувати патерн медіатор, визначивши клас медіатора,
який інкапсулює взаємодію між об'єктами. Клас медіатора повинен мати
посилання на всі об'єкти, які повинні взаємодіяти один з одним.

Ось приклад реалізації патерну медіатора в Dart:

У цьому прикладі ми маємо двох конкретних колег, ConcreteColleague1 і
ConcreteColleague2, і посередника, Mediator, який є посередником у взаємодії
між двома колегами. Кожен колега має посилання на посередника, яке він
використовує для надсилання повідомлень іншому колезі. Коли колега надсилає
повідомлення, посередник отримує його і пересилає відповідному колезі.