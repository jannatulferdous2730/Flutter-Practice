abstract class Animal {
  String _name;

  Animal(this._name);

  String getName() => _name;

  void makeSound();
}

class Lion extends Animal {
  double _maneSize;

  Lion(String name, double maneSize)
      : _maneSize = maneSize,
        super(name);

  double get maneSize => _maneSize;
  set maneSize(double value) {
    if (value < 0) {
      throw ArgumentError('Mane size cannot be negative');
    }
    _maneSize = value;
  }

  @override
  void makeSound() {
    print('Roar');
  }
}

class Elephant extends Animal {
  double _trunkLength;

  Elephant(String name, double trunkLength)
      : _trunkLength = trunkLength,
        super(name);

  double get trunkLength => _trunkLength;
  set trunkLength(double value) {
    if (value < 0) {
      throw ArgumentError('Trunk length cannot be negative');
    }
    _trunkLength = value;
  }

  @override
  void makeSound() {
    print('Trumpet');
  }
}

class Parrot extends Animal {
  int _vocabularySize;

  Parrot(String name, int vocabularySize)
      : _vocabularySize = vocabularySize,
        super(name);

  int get vocabularySize => _vocabularySize;
  set vocabularySize(int value) {
    if (value < 0) {
      throw ArgumentError('Vocabulary size cannot be negative');
    }
    _vocabularySize = value;
  }

  @override
  void makeSound() {
    print('Squawk');
  }
}

void main() {
  List<Animal> zoo = [
    Lion('Singho', 1.2),
    Elephant('Hati', 2.5),
    Parrot('TiyaPakhi', 50),
  ];

  for (var animal in zoo) {
    print('Name:  ${animal.getName()} ');
    if (animal is Lion) {
      print('Mane Size: ${animal.maneSize}');
    } else if (animal is Elephant) {
      print('Trunk Length: ${animal.trunkLength}');
    } else if (animal is Parrot) {
      print('Vocabulary Size: ${animal.vocabularySize}');
    }
    print('Sound:');
    animal.makeSound();
    print('---');
  }
}