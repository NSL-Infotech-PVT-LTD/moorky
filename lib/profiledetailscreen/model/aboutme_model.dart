class Aboutme_Model{
  String? icon;
  String? name;

  Aboutme_Model({this.icon, this.name});
  Map<String, dynamic> toJson() => {
    "icon": icon == null ? null : icon,
    "name": name == null ? null : name,
  };
}