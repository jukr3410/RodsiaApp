// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Garage _$GarageFromJson(Map<String, dynamic> json) {
  return Garage(
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    image: json['image'] as String
   );
}

Map<String, dynamic> _$GarageToJson(Garage instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'image': instance.image,
    };
