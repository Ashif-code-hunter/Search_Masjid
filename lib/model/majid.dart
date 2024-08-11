class Masjid {
  String id;
  String name;
  String address;
  String image;
  String type;
  List<Member>? members;
  String? fcmToken; // Add this field
  String? masjidPhone; // Add this field

  Masjid({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.type,
    required this.masjidPhone,
    this.members,
    this.fcmToken,
  });

  factory Masjid.fromJson(Map<String, dynamic> json) {
    return Masjid(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      image: json['image'],
      type: json['type'],
      masjidPhone: json['masjidPhone'],
      members: (json['members'] as List).map(
        (e) {
          return Member(
            name: e['name'] ?? '',
            image: e['image'],
            position: e['position'],
            phone: e['phone'],
            type: e['type'],
          );
        },
      ).toList(),
      fcmToken: json['fcmToken'], // Add this field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'image': image,
      'masjidPhone':masjidPhone,
      'type': type,
      'members': members,
      'fcmToken': fcmToken, // Add this field
    };
  }

  @override
  String toString() {
    return 'Masjid{id: $id, name: $name, address: $address, image: $image, type: $type, members: $members, fcmToken: $fcmToken, masjidPhone: $masjidPhone}';
  }
}

class Member {
  String name;
  String? image;
  String position;
  String phone;
  String type;

  Member({
    required this.name,
    this.image,
    required this.position,
    required this.phone,
    required this.type,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      image: json['image'],
      position: json['position'],
      phone: json['phone'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'position': position,
      'phone': phone,
      'type': type,
    };
  }
}
