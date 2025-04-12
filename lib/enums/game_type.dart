enum GameType {
  easy(1, 20, "Easy"),
  medium(2, 15, "Medium"),
  hard(3, 8, "Hard"),
  ;

  const GameType(this.id, this.time, this.name);
  final int id;
  final int time;
  final String name;

  static GameType fromId(int id) {
    return GameType.values.firstWhere(
      (e) => e.id == id,
      orElse: () => GameType.easy, // varsayılan değer verebilirsin veya null döndür
    );
  }
}
