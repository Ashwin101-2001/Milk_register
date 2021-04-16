class  Milk {

  int _id;
  String _day;
  String _month;
  String _year;
  double _q;
  String _date;

  Milk(this._day, this._month, this._year, this._q,){
    this._date="${this.day}/${this.month}/${this.year}";
  }

  Milk.withId(this._id,this._day, this._month, this._year, this._q );
   int get id => _id;

  String get day => _day;

  String get month => _month;
  String get date => _date;

  String get year => _year;

  double get q => _q;


  set day(String d) {

      this._day = d;
  }
  set month(String d) {

    this._month=d;
  }

  set year(String d) {

    this._year = d;

  }




  set q(double d) {

    this._q = d;
  }
  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['day'] = _day;
    map['month'] = _month;
    map['year'] = _year;
    map['q'] = _q;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Milk.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._day = map['day'];
    this._month = map['month'];
    this._year = map['year'];
    this._q = map['q'];
    this._date = map['date'];
  }
}