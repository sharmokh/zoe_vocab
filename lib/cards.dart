List<StudyCard> cards = [
  StudyCard('ant', 'animals', 1),
  StudyCard('bear', 'animals', 1),
  StudyCard('bird', 'animals', 1),
  StudyCard('butterfly', 'animals', 3),
  StudyCard('cat', 'animals', 1),
  StudyCard('caterpillar', 'animals', 4),
  StudyCard('apple', 'food', 2),
  StudyCard('clap', 'actions', 1),
  StudyCard('crawl', 'actions', 1),
  StudyCard('dog', 'animals', 1),
  StudyCard('laugh', 'actions', 1),
  StudyCard('rotate', 'actions', 2),
  StudyCard('sitting up', 'actions', 3),
  StudyCard('smile', 'actions', 1),
  StudyCard('snowball', 'weather', 2),
  StudyCard('stop', 'outside', 1),
  StudyCard('turn on', 'actions', 2),
  StudyCard('turn off', 'actions', 2),
  StudyCard('walk', 'actions', 1),

];

class StudyCard {
  final String name;
  final String category;
  final int syllable;

  const StudyCard(this.name, this.category, this.syllable);
}
