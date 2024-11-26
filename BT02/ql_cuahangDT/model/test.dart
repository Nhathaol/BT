import 'Class.dart';

void main(){
    print("=== Testing hệ thống quản lý cửa hàng điện thoại ===");

    // 1. Tạo và quản lý thông tin điện thoại
    print("\n== Quản lý điện thoại ==");
    var dt1 = DienThoai("DT-001", "iPhone 14", "Apple", 20000000, 25000000, 10, true);
    var dt2 = DienThoai("DT-002", "Samsung Galaxy S23", "Samsung", 15000000, 18000000, 5, true);
    var dt3 = DienThoai("DT-003", "Xiaomi 13", "Xiaomi", 10000000, 13000000, 0, true);
    
    var cuaHang = CuaHang("Cửa Hàng Điện Thoại ABC", "123 Đường A, TP HCM");
    cuaHang.themDienThoai(dt1);
    cuaHang.themDienThoai(dt2);
    cuaHang.themDienThoai(dt3);

    print("Thêm điện thoại thành công. Danh sách điện thoại:");
    cuaHang.danhSachDienThoai.forEach((dt) => dt.hienThiThongTin());

    // Cập nhật thông tin điện thoại
    print("\nCập nhật giá bán của iPhone 14...");
    cuaHang.capNhatDienThoai("DT-001", giaBan: 26000000);
    dt1.hienThiThongTin();

    // Kiểm tra validation
    try {
      print("\nThử tạo điện thoại không hợp lệ...");
      var dtInvalid = DienThoai("", "Invalid Phone", "Unknown", -10000, 0, -1, false);
    } catch (e) {
      print("Validation thành công: $e");
    }

    // 2. Tạo và quản lý hóa đơn
    print("\n== Quản lý hóa đơn ==");
    var hd1 = HoaDon("HD-001", DateTime.now(), dt1, 2, 26000000, "Nguyễn Văn A", "0987654321");
    cuaHang.taoHoaDon(hd1);
    print("Tạo hóa đơn hợp lệ:");
    hd1.hienThiThongTin();

    // Kiểm tra ràng buộc tồn kho
    try {
      print("\nThử tạo hóa đơn với số lượng vượt tồn kho...");
      var hdInvalid = HoaDon("HD-002", DateTime.now(), dt2, 10, 18000000, "Trần Văn B", "0987123456");
    } catch (e) {
      print("Ràng buộc tồn kho hoạt động đúng: $e");
    }

    // Tính toán tiền và lợi nhuận
    print("\nTính tổng tiền và lợi nhuận hóa đơn 1:");
    print("Tổng tiền: ${hd1.tinhTongTien()}");
    print("Lợi nhuận: ${hd1.tinhLoiNhuan()}");

    // 3. Thống kê báo cáo
    print("\n== Thống kê báo cáo ==");
    var fromDate = DateTime.now().subtract(Duration(days: 30));
    var toDate = DateTime.now();

    // Doanh thu theo thời gian
    double doanhThu = cuaHang.tinhDoanhThu(fromDate, toDate);
    print("Doanh thu từ ${fromDate.toLocal()} đến ${toDate.toLocal()}: $doanhThu");

    // Lợi nhuận theo thời gian
    double loiNhuan = cuaHang.danhSachHoaDon
        .where((hd) => hd.ngayBan.isAfter(fromDate) && hd.ngayBan.isBefore(toDate))
        .map((hd) => hd.tinhLoiNhuan())
        .reduce((a, b) => a + b);
    print("Lợi nhuận từ ${fromDate.toLocal()} đến ${toDate.toLocal()}: $loiNhuan");

    // Top bán chạy
    var topBanChay = cuaHang.danhSachDienThoai
        .where((dt) => dt.soLuongTon < 10)
        .toList();
    print("Top điện thoại bán chạy:");
    topBanChay.forEach((dt) => dt.hienThiThongTin());

    // Báo cáo tồn kho
    print("Báo cáo tồn kho:");
    cuaHang.danhSachDienThoai.forEach((dt) {
      print("Mã: ${dt.maDienThoai} | Tên: ${dt.tenDienThoai} | Tồn kho: ${dt.soLuongTon}");
    });
  }
