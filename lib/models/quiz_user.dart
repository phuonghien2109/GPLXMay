import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class QuizUser {
  final String id;
  final String name;
  final String photoUrl;
  final String email;
  final int score;
  final List<int> listscore;

  QuizUser(
      {required this.id,
      required this.name,
      required this.photoUrl,
      required this.email,
      required this.score,
      required this.listscore});

  QuizUser copyWith({
    String? id,
    String? name,
    String? photoUrl,
    String? email,
    int? score,
    List<int>? listscore,
  }) {
    return QuizUser(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      score: score ?? this.score,
      listscore: listscore ?? this.listscore,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'email': email,
      'score': score,
      'listscore': listscore,
    };
  }

  factory QuizUser.fromMap(Map<String, dynamic> map) {
    return QuizUser(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      email: map['email'] ?? '',
      score: map['score']?.toInt() ?? 0, 
      listscore: List<int>.from(map['listscore']),
    );
  }

  factory QuizUser.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;
    data['id'] = id;
    return QuizUser.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  factory QuizUser.fromJson(String source) =>
      QuizUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuizUser(id: $id, name: $name, photoUrl: $photoUrl, email: $email, score: $score, listscore: $listscore';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizUser &&
        other.id == id &&
        other.name == name &&
        other.photoUrl == photoUrl &&
        other.email == email &&
        listEquals(other.listscore, listscore)&&
        other.score == score;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        photoUrl.hashCode ^
        email.hashCode ^
        listscore.hashCode ^
        score.hashCode;
  }
}
