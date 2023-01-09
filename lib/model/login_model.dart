class LoginModel {
  Information? information;
  bool? status;
  String? message;

  LoginModel({this.information, this.status, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    information = json['information'] != null
        ? Information.fromJson(json['information'])
        : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (information != null) {
      data['information'] = information!.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Information {
  String? id;
  String? name;
  String? email;
  String? contact;
  String? password;
  String? newsletter;
  String? profileImage;
  String? pincode;
  String? address;
  String? verify;
  String? suspended;
  String? deletedByUser;
  String? created;
  String? status;

  Information(
      {this.id,
      this.name,
      this.email,
      this.contact,
      this.password,
      this.newsletter,
      this.profileImage,
      this.pincode,
      this.address,
      this.verify,
      this.suspended,
      this.deletedByUser,
      this.created,
      this.status});

  Information.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    password = json['password'];
    newsletter = json['newsletter'];
    profileImage = json['profile_image'];
    pincode = json['pincode'];
    address = json['address'];
    verify = json['verify'];
    suspended = json['suspended'];
    deletedByUser = json['deleted_by_user'];
    created = json['created'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['contact'] = contact;
    data['password'] = password;
    data['newsletter'] = newsletter;
    data['profile_image'] = profileImage;
    data['pincode'] = pincode;
    data['address'] = address;
    data['verify'] = verify;
    data['suspended'] = suspended;
    data['deleted_by_user'] = deletedByUser;
    data['created'] = created;
    data['status'] = status;
    return data;
  }
}
