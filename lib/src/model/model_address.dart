class ModelAddress {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String city;
  final String state;
  final String street;

  ModelAddress( this.name, this.address, this.phone, this.city,
      this.state, this.street,{this.id});

  ModelAddress.fromMap(Map<String, dynamic> json)
      : this.id = json["id"].toString(),
        this.name = json["name"],
        this.address = json["address"],
        this.phone = json["phone"],
        this.city = json["city"],
        this.state = json["state"],
        this.street = json["street"];

  toMap() => {
        "id": this.id,
        "name": this.name,
        "address": this.address,
        "phone": this.phone,
        "city": this.city,
        "state": this.state,
        "street": this.street,
      };
}