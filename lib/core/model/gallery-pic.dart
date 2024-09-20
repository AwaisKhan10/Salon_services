import 'dart:io';

class GalleryPic {
  String? id;
  String? imgUrl;
  String? label;
  File? imgFile;

  GalleryPic({this.id, this.imgUrl, this.label, this.imgFile});

  GalleryPic.fromJson(json, docid) {
    id = docid;
    imgUrl = json['imgUrl'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imgUrl'] = this.imgUrl;
    data['label'] = this.label;
    return data;
  }
}
