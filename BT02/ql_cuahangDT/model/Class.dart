class DienThoai {
  late String _maDienThoai;
  late String _tenDienThoai;
  late String _hangSanXuat;
  late double _giaNhap;
  late double _giaBan;
  late int _soLuongTon;
  late bool _trangThai; // Còn kinh doanh hay không

  DienThoai(
    this._maDienThoai,
    this._tenDienThoai,
    this._hangSanXuat,
    this._giaNhap,
    this._giaBan,
    this._soLuongTon,
    this._trangThai,
  ) {
    maDienThoai = _maDienThoai;
    tenDienThoai = _tenDienThoai;
    hangSanXuat = _hangSanXuat;
    giaNhap = _giaNhap;
    giaBan = _giaBan;
    soLuongTon = _soLuongTon;
  }

  // Getters và Setters với validation
  String get maDienThoai => _maDienThoai;
  set maDienThoai(String value) {
    if (value.isEmpty || !RegExp(r'^DT-\d{3}$').hasMatch(value)) {
      throw ArgumentError("Mã điện thoại không hợp lệ (định dạng 'DT-XXX').");
    }
    _maDienThoai = value;
  }

  String get tenDienThoai => _tenDienThoai;
  set tenDienThoai(String value) {
    if (value.isEmpty) {
      throw ArgumentError("Tên điện thoại không được để trống.");
    }
    _tenDienThoai = value;
  }

  String get hangSanXuat => _hangSanXuat;
  set hangSanXuat(String value) {
    if (value.isEmpty) {
      throw ArgumentError("Hãng sản xuất không được để trống.");
    }
    _hangSanXuat = value;
  }

  double get giaNhap => _giaNhap;
  set giaNhap(double value) {
    if (value <= 0) {
      throw ArgumentError("Giá nhập phải lớn hơn 0.");
    }
    _giaNhap = value;
  }

  double get giaBan => _giaBan;
  set giaBan(double value) {
    if (value <= 0 || value <= _giaNhap) {
      throw ArgumentError("Giá bán phải lớn hơn giá nhập và lớn hơn 0.");
    }
    _giaBan = value;
  }

  int get soLuongTon => _soLuongTon;
  set soLuongTon(int value) {
    if (value < 0) {
      throw ArgumentError("Số lượng tồn không được nhỏ hơn 0.");
    }
    _soLuongTon = value;
  }

  bool get trangThai => _trangThai;
  set trangThai(bool value) {
    _trangThai = value;
  }

  // Phương thức tính lợi nhuận dự kiến
  double tinhLoiNhuan() {
    return (_giaBan - _giaNhap) * _soLuongTon;
  }

  // Phương thức hiển thị thông tin điện thoại
  void hienThiThongTin() {
    print("Mã: $_maDienThoai | Tên: $_tenDienThoai | Hãng: $_hangSanXuat");
    print("Giá nhập: $_giaNhap | Giá bán: $_giaBan | Tồn kho: $_soLuongTon");
    print("Trạng thái: ${_trangThai ? "Còn kinh doanh" : "Ngừng kinh doanh"}");
  }

  // Phương thức kiểm tra có thể bán
  bool coTheBan() {
    return _trangThai && _soLuongTon > 0;
  }
}

class HoaDon {
  String _maHoaDon;
  DateTime _ngayBan;
  DienThoai _dienThoai;
  int _soLuongMua;
  double _giaBanThucTe;
  String _tenKhachHang;
  String _soDienThoaiKhach;

  HoaDon(
    this._maHoaDon,
    this._ngayBan,
    this._dienThoai,
    this._soLuongMua,
    this._giaBanThucTe,
    this._tenKhachHang,
    this._soDienThoaiKhach,
  ) {
    maHoaDon = _maHoaDon;
    ngayBan = _ngayBan;
    soLuongMua = _soLuongMua;
    giaBanThucTe = _giaBanThucTe;
  }

  // Getters và Setters với validation
  String get maHoaDon => _maHoaDon;
  set maHoaDon(String value) {
    if (value.isEmpty || !RegExp(r'^HD-\d{3}$').hasMatch(value)) {
      throw ArgumentError("Mã hóa đơn không hợp lệ (định dạng 'HD-XXX').");
    }
    _maHoaDon = value;
  }

  DateTime get ngayBan => _ngayBan;
  set ngayBan(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw ArgumentError("Ngày bán không được sau ngày hiện tại.");
    }
    _ngayBan = value;
  }

  int get soLuongMua => _soLuongMua;
  set soLuongMua(int value) {
    if (value <= 0 || value > _dienThoai.soLuongTon) {
      throw ArgumentError("Số lượng mua không hợp lệ.");
    }
    _soLuongMua = value;
    _dienThoai.soLuongTon -= value; // Cập nhật tồn kho
  }

  double get giaBanThucTe => _giaBanThucTe;
  set giaBanThucTe(double value) {
    if (value <= 0) {
      throw ArgumentError("Giá bán thực tế phải lớn hơn 0.");
    }
    _giaBanThucTe = value;
  }

  // Các phương thức
  double tinhTongTien() {
    return _soLuongMua * _giaBanThucTe;
  }

  double tinhLoiNhuan() {
    return _soLuongMua * (_giaBanThucTe - _dienThoai.giaNhap);
  }

  void hienThiThongTin() {
    print("Hóa đơn: $_maHoaDon | Ngày: $_ngayBan");
    print("Khách: $_tenKhachHang | SĐT: $_soDienThoaiKhach");
    print("Điện thoại: ${_dienThoai.tenDienThoai} | SL: $_soLuongMua");
    print("Tổng tiền: ${tinhTongTien()} | Lợi nhuận: ${tinhLoiNhuan()}");
  }
}

class CuaHang {
  String tenCuaHang;
  String diaChi;
  List<DienThoai> danhSachDienThoai = [];
  List<HoaDon> danhSachHoaDon = [];

  CuaHang(this.tenCuaHang, this.diaChi);

  // Quản lý điện thoại
  void themDienThoai(DienThoai dt) {
    danhSachDienThoai.add(dt);
  }

  void capNhatDienThoai(String ma,
      {String? ten, double? giaNhap, double? giaBan}) {
    var dt = danhSachDienThoai.firstWhere((d) => d.maDienThoai == ma,
        orElse: () => throw ArgumentError("Không tìm thấy."));
    if (ten != null) dt.tenDienThoai = ten;
    if (giaNhap != null) dt.giaNhap = giaNhap;
    if (giaBan != null) dt.giaBan = giaBan;
  }

  // Quản lý hóa đơn
  void taoHoaDon(HoaDon hd) {
    danhSachHoaDon.add(hd);
  }

  double tinhDoanhThu(DateTime from, DateTime to) {
    return danhSachHoaDon
        .where((hd) => hd.ngayBan.isAfter(from) && hd.ngayBan.isBefore(to))
        .map((hd) => hd.tinhTongTien())
        .reduce((a, b) => a + b);
  }
}
