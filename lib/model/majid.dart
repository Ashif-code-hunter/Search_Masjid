class Masjid {
  String id;
  String name;
  String address;
  String image;
  String type;
  List<Member> members;

  Masjid({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.type,
    required this.members,
  });

  factory Masjid.fromJson(Map<String, dynamic> json) {
    return Masjid(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      image: json['image'],
      type: json['type'],
      members: (json['members'] as List)
          .map((e) => Member(
              name: e['name'],
              image: e['image'],
              position: e['position'],
              phone: e['phone'],
              type: e['type']))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'image': image,
      'type': type,
      'members': members
    };
  }

  @override
  String toString() {
    return 'Masjid{ id: $id ,name: $name, address: $address, image: $image, type: $type, members: $members}';
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
      'type': type
    };
  }
}
