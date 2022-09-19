class LightinigModel{
  String month;
  String area;
  String catergory;
  String fitting;
  String num_of_fitting;
  String lamp_rating;
  String num_oflamps;
  String hpmonth;
  String light_controle;
  String improvements;
  String lusx_levels;
  String natural_light;
  String Required_lux_level;
  String Actual_lux_level;



  LightinigModel({
    this.month='00-00-0000',
    this.area='None',
    this.catergory='None',
    this.fitting='None',
    this.num_of_fitting='0',
    this.lamp_rating='0',
    this.num_oflamps='0',
    this.hpmonth='0',
    this.light_controle='None',
    this.improvements='None',
    this.lusx_levels='None',
    this.natural_light='None',
    this.Required_lux_level='0',
    this.Actual_lux_level='0'
  });

  LightinigModel copyWith({
    String? month,
    String? area,
    String? catergory,
    String? fitting,
    String? num_of_fitting,
    String? lamp_rating,
    String? num_oflamps,
    String? hpmonth,
    String? light_controle,
    String? improvements,
    String? lusx_levels,
    String? natural_light,
    String? Required_lux_level,
    String? Actual_lux_level,
  }) {
    return LightinigModel(
      month: month ?? this.month,
      area: area ?? this.area,
      catergory: catergory ?? this.catergory,
      fitting: fitting ?? this.fitting,
      num_of_fitting: num_of_fitting ?? this.num_of_fitting,
      lamp_rating: lamp_rating ?? this.lamp_rating,
      num_oflamps: num_oflamps ?? this.num_oflamps,
      hpmonth: hpmonth ?? this.hpmonth,
      light_controle: light_controle ?? this.light_controle,
      improvements: improvements ?? this.improvements,
      lusx_levels: lusx_levels ?? this.lusx_levels,
      natural_light: natural_light ?? this.natural_light,
      Required_lux_level: Required_lux_level ?? this.Required_lux_level,
      Actual_lux_level: Actual_lux_level ?? this.Actual_lux_level,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'month': this.month,
      'area': this.area,
      'catergory': this.catergory,
      'fitting': this.fitting,
      'num_of_fitting': this.num_of_fitting,
      'lamp_rating': this.lamp_rating,
      'num_oflamps': this.num_oflamps,
      'hpmonth': this.hpmonth,
      'light_controle': this.light_controle,
      'improvements': this.improvements,
      'lusx_levels': this.lusx_levels,
      'natural_light': this.natural_light,
      'Required_lux_level': this.Required_lux_level,
      'Actual_lux_level': this.Actual_lux_level,
    };
  }

  factory LightinigModel.fromMap(Map<String, dynamic> map) {
    return LightinigModel(
      month: map['month'] as String,
      area: map['area'] as String,
      catergory: map['catergory'] as String,
      fitting: map['fitting'] as String,
      num_of_fitting: map['num_of_fitting'] as String,
      lamp_rating: map['lamp_rating'] as String,
      num_oflamps: map['num_oflamps'] as String,
      hpmonth: map['hpmonth'] as String,
      light_controle: map['light_controle'] as String,
      improvements: map['improvements'] as String,
      lusx_levels: map['lusx_levels'] as String,
      natural_light: map['natural_light'] as String,
      Required_lux_level: map['Required_lux_level'] as String,
      Actual_lux_level: map['Actual_lux_level'] as String,
    );
  }
}

class LightinigService {

}