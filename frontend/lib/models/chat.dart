class Chat {
  int id;
  int personOne;
  int personTwo;

  Chat({required this.id, required this.personOne, required this.personTwo});

  factory Chat.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'personOne': int personOne, 'personTwo': int personTwo}
            => Chat(id: id, personOne: personOne, personTwo: personTwo),
      (_) => throw const FormatException('Failed to load chat.')
    };
  }
}
