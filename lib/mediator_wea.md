// Компонент WeatherAPI викликає метод updateCache класу WeatherMediator, щоб
// оновити кеш з новою інформацією про погоду. Компонент UserInterface також
// викликає метод getFromCache WeatherMediator, щоб отримати інформацію про погоду з кешу.
// ми створюємо екземпляри компонентів WeatherMediator, WeatherAPI та UserInterface.
// Потім ми викликаємо метод displayWeather компонента UserInterface, щоб
// відобразити інформацію про погоду для місцезнаходження. Метод displayWeather
// спочатку перевіряє, чи доступна в кеші інформація про погоду для цього місця.
// Якщо так, то він відображає інформацію з кешу. Якщо її немає в кеші, то
// відображається повідомлення про завантаження і викликається метод getWeather
// компонента WeatherMediator для отримання інформації про погоду. Після того,
// як інформацію про погоду буде отримано, вона буде показана користувачеві.

// Загалом, посередник може бути корисним способом спрощення зв'язку між
// компонентами у системі, особливо коли у ній задіяно багато компонентів.
// Він може допомогти зменшити складність коду і полегшити його підтримку
// та модифікацію в майбутньому.

// Клас WeatherInfo представляє інформацію про погоду для місця розташування

class WeatherInfo {
  // властивості
  String location;
  double temperature;
  double humidity;
  // контруктор
  WeatherInfo(
      {required this.location,
      required this.temperature,
      required this.humidity});
}

// Клас-медіатор виступає в ролі центрального вузла для зв'язку між компонентами
class WeatherMediator {
  // властивості
  // зберігати кешовану інформацію про погоду
  Map<String, WeatherInfo> cache = {};
  // методи
  WeatherInfo? getFromCache(String location) {
    return cache[location];
  }

  void updateCache(String location, WeatherInfo weatherInfo) {
    cache[location] = weatherInfo;
  }

  Future<WeatherInfo?> getWeather(String location) async {
    WeatherInfo? weatherInfo = getFromCache(location);
    WeatherAPI weatherAPI = WeatherAPI();
    if (weatherInfo != null) {
      return weatherInfo; // повертати кешовану інформацію про погоду, якщо вона доступна
    }
    // викликати weather API для отримання інформації про погоду для вказаного місця
    // та оновити кеш з новою інформацією
    weatherInfo = await weatherAPI.getWeatherInfo(location);
    if (weatherInfo != null) {
      updateCache(location, weatherInfo);
    }
    return weatherInfo;
  }
}

// Клас WeatherAPI отримує інформацію про погоду з віддаленого сервера
class WeatherAPI {
  // властивості
  String baseURL = 'https://api.weather.com/';
  WeatherInfo weatherInfo = WeatherInfo(
    location: '',
    temperature: 25.5,
    humidity: 78,
  );

  // методи
  Future<WeatherInfo?> getWeatherInfo(String location) async {
    return weatherInfo;
  }
}

// Компонент UserInterface викликає метод getWeather класу WeatherMediator,
// щоб отримати інформацію про погоду для певного місця.
class UserInterface {
  // властивості
  WeatherMediator mediator;
  // конструктор
  UserInterface({required this.mediator});
  // методи
  void displayWeather(String location) {
    WeatherInfo? weatherInfo = mediator.getFromCache(location);
    if (weatherInfo != null) {
      // виводити інформацію про погоду з кешу
      weatherInfo.location = location;
      print(weatherInfo.location);
      print(weatherInfo.temperature);
      print(weatherInfo.humidity);
    } else {
      // вивести повідомлення про завантаження
      // викликати посередника для отримання інформації про погоду для вказаного місця
      mediator.getWeather(location).then((weatherInfo) {
        if (weatherInfo != null) {
          // відображати інформацію про погоду
          weatherInfo.location = location;
          print(weatherInfo.location);
          print(weatherInfo.temperature);
          print(weatherInfo.humidity);
        } else {
          // відобразити повідомлення про помилку
        }
      });
    }
  }
}

// Приклад використання компонентів
void main() {
  // створити екземпляри компонентів
  WeatherMediator mediator = WeatherMediator();
  // WeatherAPI weatherAPI = WeatherAPI();
  UserInterface ui = UserInterface(mediator: mediator);

  // відображати погоду для місцезнаходження
  // String location = 'Dnipro';
  String location = 'Dnipro';
  ui.displayWeather(location);
}
