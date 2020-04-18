import 'ClubInfo.dart';
class GetBags{
  final ClubInfo golfClub;
  final String id;
  final String bagName;

  GetBags(
      {
        this.golfClub, this.id, this.bagName
      });

  List<Object> get props => [golfClub, id, bagName];

  static GetBags fromJson(dynamic json){
    return GetBags(
      golfClub: json['golfClub'],
          id: json['_id'],
      bagName: json['bagName']
    );
  }
}