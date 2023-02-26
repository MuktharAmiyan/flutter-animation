import 'package:flutter/material.dart';

class Day4 extends StatelessWidget {
  const Day4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: ListView.builder(
          itemCount: people.length,
          itemBuilder: (_, index) {
            final person = people[index];
            return ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailsPage(person: person),
                  ),
                );
              },
              leading: Hero(
                tag: person.name,
                child: Text(
                  person.emoji,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              title: Text(person.name),
              subtitle: Text('${person.age} Year old'),
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          }),
    );
  }
}

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;
  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

const people = [
  Person(name: 'Jhon', age: 20, emoji: '🦹🏻'),
  Person(name: 'Jane', age: 21, emoji: '👩🏻‍🎤'),
  Person(name: 'Jack', age: 22, emoji: '🧝🏻'),
];

class DetailsPage extends StatelessWidget {
  final Person person;
  const DetailsPage({super.key, required this.person});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: person.name,
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return ScaleTransition(
                  scale: animation.drive(
                    Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).chain(
                      CurveTween(curve: Curves.fastOutSlowIn),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: toHeroContext.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return ScaleTransition(
                  scale: animation.drive(Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).chain(CurveTween(curve: Curves.fastOutSlowIn))),
                  child: Material(
                    color: Colors.transparent,
                    child: fromHeroContext.widget,
                  ),
                );
            }
          },
          child: Text(
            person.emoji,
            style: const TextStyle(fontSize: 60),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              person.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${person.age} Year old',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
