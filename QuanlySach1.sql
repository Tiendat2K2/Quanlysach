CREATE DATABASE QuanlySach
GO
USE QuanlySach
-- Tạo bảng "Sách"
GO
CREATE TABLE Sach (
    MaSach INT PRIMARY KEY,
    TenSach NVARCHAR(255),
    TacGia NVARCHAR(255),
    NamXuatBan INT,
	Nhaxuatban NVARCHAR(255),
    SoLuongHienCo INT
);
GO
-- Tạo bảng "Thẻ thành viên"
CREATE TABLE TheThanhVien (
    MaThe INT PRIMARY KEY,
    TenThanhVien NVARCHAR(255),
    DiaChi NVARCHAR(255),
    DienThoai INT,
    Email NVARCHAR(255)UNIQUE
);
GO
-- Tạo bảng "Mượn sách"
CREATE TABLE MuonSach (
    MaMuon INT PRIMARY KEY,
    MaSach INT ,
    MaThe INT ,
    NgayMuon DATE,
    NgayHetHan DATE,
	TenThanhVien NVARCHAR(255),
	FOREIGN KEY(MaSach) REFERENCES dbo.Sach(MaSach),
	FOREIGN KEY(MaThe) REFERENCES dbo.TheThanhVien(MaThe),
);
GO
-- Tạo bảng "Trả sách"
CREATE TABLE TraSac (
    MaTra INT PRIMARY KEY,
    MaMuon INT ,
	TenThanhVien NVARCHAR(255),
    NgayTra DATE,
    MaThe INT,
	FOREIGN KEY(MaThe) REFERENCES dbo.TheThanhVien(MaThe),
	FOREIGN KEY(MaMuon) REFERENCES dbo.MuonSach(MaMuon),
);
GO
-- Tạo bảng Quanly
CREATE TABLE Admins(
ID INT PRIMARY KEY IDENTITY(1,1),
TaiKhoan NVARCHAR(255),
Matkhau NVARCHAR(255),
emali NVARCHAR(255)UNIQUE,
Hoten NVARCHAR(255),
GioiTinh NVARCHAR(10),
Diachi NVARCHAR(255),
std INT,
MaTra INT,
MaMuon INT,
MaThe INT,
MaSach INT,
FOREIGN KEY(MaTra) REFERENCES dbo.TraSac(MaTra),
FOREIGN KEY(MaMuon) REFERENCES dbo.MuonSach(MaMuon),
FOREIGN KEY(MaThe) REFERENCES dbo.TheThanhVien(MaThe),
FOREIGN KEY(MaSach) REFERENCES dbo.Sach(MaSach)
)
GO
SELECT * FROM dbo.TraSac
SELECT * FROM dbo.Admins
SELECT * FROM dbo.TheThanhVien
SELECT * FROM dbo.MuonSach
SELECT * FROM dbo.Sach
GO
-- Insert records into "Sach" table
INSERT INTO dbo.Sach
(MaSach,TenSach,TacGia,NamXuatBan,Nhaxuatban,SoLuongHienCo)VALUES
(4,N'OOPJAVA',N'trang',2000,N'trang',10),
(5,N'Xử lý Anh',N'hà',2000,N'linh',10),
(6,N'Hệ quản trị cơ sở dữ liệu',N'linh',2000,N'hay',10);
-- Insert records into "TheThanhVien" table

INSERT INTO TheThanhVien (MaThe, TenThanhVien, DiaChi, DienThoai, Email)
VALUES
    (2100535, N'Nguyễn Tiến Đạt', N'Xóm mới', 123456789, 'datanhtrai@gmail.com'),
    (2100454, N'Nguyễn Thị Lan', N'Lai Xá', 987654321, 'lan@gmail.com'),
    (2100316, N'Nguyễn Trọng Phúc', N'Lai xá', 555555555, 'phuc@gmail.com');
GO
-- Insert records into "MuonSach" table
INSERT INTO MuonSach (MaMuon, MaSach, MaThe, NgayMuon, NgayHetHan, TenThanhVien)
VALUES
    (1, 1, 2100535, '2023-07-10', '2023-07-17', N'Nguyễn Tiến Đạt'),
    (2, 2, 2100454, '2023-07-11', '2023-07-18', N'Nguyễn Thị Lan'),
    (3, 3, 2100316, '2023-07-12', '2023-07-19', N'Nguyễn Trọng Phúc');
GO
-- Insert records into "TraSach" table
INSERT INTO dbo.TraSac
(MaTra,MaMuon,TenThanhVien,NgayTra,MaThe)
VALUES
(1,1,N'Nguyễn Tiến Đạt','2023-07-17',2100535),
(2,2,N'Nguyễn Thị Lan','2023-07-18',2100454),
(3,3,N'Nguyễn Trọng Phúc','2023-07-19',2100316);
 GO
-- Quản lý
INSERT INTO dbo.Admins (TaiKhoan, Matkhau, emali, Hoten, GioiTinh, Diachi, std)
VALUES
(N'Tiendat2k', N'1111', N'datanhtrai@gmail.com', N'Nguyễn Tiến Đạt', N'Nam', N'Xóm mới',123456789),
(N'Thi lan', N'11111', N'lan@gmail.com', N'Nguyễn thị lan', N'Nữ', N'Lai xá', 987654321),
(N'Trong phuc', N'11111', N'phuc@gmail.com', N'Nguyễn Trọng Phúc', N'Nam', N'Lai xá', 555555555);

GO
	CREATE PROCEDURE InsertSach
    @MaSach INT,
    @TenSach NVARCHAR(255),
    @TacGia NVARCHAR(255),
    @NamXuatBan INT,
	@Nhaxuatban NVARCHAR(255),
    @SoLuongHienCo INT
AS
BEGIN
    INSERT INTO Sach (MaSach, TenSach, TacGia,Nhaxuatban, NamXuatBan, SoLuongHienCo)
    VALUES (@MaSach, @TenSach, @TacGia,@Nhaxuatban, @NamXuatBan, @SoLuongHienCo)
END
-- thêm
EXEC dbo.InsertSach @MaSach = 7,       -- int
                    @TenSach = N'hack',    -- nvarchar(255)
                    @TacGia = N'trang',     -- nvarchar(255)
					@Nhaxuatban =N'lan',
                    @NamXuatBan = 2010,   -- int
                    @SoLuongHienCo = 1 -- int
SELECT * FROM dbo.Sach
GO
SELECT * FROM dbo.Sach

-- cập nhật sách
GO
CREATE PROCEDURE UpdateSach
    @MaSach INT,
    @TenSach NVARCHAR(255),
    @TacGia NVARCHAR(255),
	@Nhaxuatban NVARCHAR(255),
    @NamXuatBan INT,
    @SoLuongHienCo INT
AS
BEGIN
    UPDATE Sach
    SET TenSach = @TenSach,
        TacGia = @TacGia,
		Nhaxuatban = @Nhaxuatban,
        NamXuatBan = @NamXuatBan,
        SoLuongHienCo = @SoLuongHienCo
    WHERE MaSach = @MaSach
END
GO
EXEC dbo.UpdateSach @MaSach = 7,       -- int
                    @TenSach = N'Học hệ điều hành',    -- nvarchar(255)
                    @TacGia = N'Dien',     -- nvarchar(255)
                    @Nhaxuatban = N'Minh', -- nvarchar(255)
                    @NamXuatBan = 2012,   -- int
                    @SoLuongHienCo = 9 -- int
 
-- XÓA SÁCH
SELECT * FROM dbo.Sach
GO
SELECT * FROM dbo.Sach
GO

CREATE PROCEDURE DeleteSach
    @MaSach INT
AS
BEGIN
    DELETE FROM Sach
    WHERE MaSach = @MaSach
END
---
GO
--xóa
EXEC dbo.DeleteSach @MaSach = 7 -- int
SELECT * FROM dbo.Sach
GO
-- Tìm kiếm
CREATE PROCEDURE SearchSach
    @TenSach NVARCHAR(255)
AS
BEGIN
    SELECT *
    FROM Sach
    WHERE TenSach LIKE '%' + @TenSach + '%'
END
EXEC dbo.SearchSach @TenSach = N'H' -- nvarchar(255)
GO
-----------------------
--Viết thủ tục cho chức năng nhập thông tin InsertThongTinThanhVien
CREATE PROCEDURE InsertThongTinThanhVien
    @MaThe INT,
    @TenThanhVien NVARCHAR(255),
    @DiaChi NVARCHAR(255),
    @DienThoai INT,
    @Email NVARCHAR(255)
AS
BEGIN
    INSERT INTO TheThanhVien (MaThe, TenThanhVien, DiaChi, DienThoai, Email)
    VALUES (@MaThe, @TenThanhVien, @DiaChi, @DienThoai, @Email)
END
GO
EXEC dbo.InsertThongTinThanhVien @MaThe = 2100379,          -- int
                                 @TenThanhVien = N'Lê Văn Lĩnh', -- nvarchar(255)
                                 @DiaChi = N'Lai xá',       -- nvarchar(255)
                                 @DienThoai = 0987777777,      -- int
                                 @Email = N'linh@gmail.com'         -- nvarchar(255)
GO
--Thủ tục để cập nhật thông tin thành viên:
SELECT * FROM dbo.TheThanhVien
GO
CREATE PROCEDURE UpdateThongTinThanhVien
    @MaThe INT,
    @TenThanhVien NVARCHAR(255),
    @DiaChi NVARCHAR(255),
    @DienThoai INT,
    @Email NVARCHAR(255)
AS
BEGIN
    UPDATE TheThanhVien
    SET TenThanhVien = @TenThanhVien,
        DiaChi = @DiaChi,
        DienThoai = @DienThoai,
        Email = @Email
    WHERE MaThe = @MaThe
END
GO
EXEC dbo.UpdateThongTinThanhVien @MaThe = 2100379,          -- int
                                 @TenThanhVien = N'Nguyen thùy Dương', -- nvarchar(255)
                                 @DiaChi = N'Lai xa',       -- nvarchar(255)
                                 @DienThoai = 056545678,      -- int
                                 @Email = N'duong@gmail.com'         -- nvarchar(255)
GO
SELECT * FROM dbo.TheThanhVien
SELECT * FROM dbo.TheThanhVien
GO
--Thủ tục để xóa thông tin thành viên dựa trên ID:
CREATE PROCEDURE DeleteThongTinThanhVien
    @MaThe INT
AS
BEGIN
    DELETE FROM TheThanhVien
    WHERE MaThe = @MaThe
END
EXEC dbo.DeleteThongTinThanhVien @MaThe = 2100379 -- int
GO
CREATE PROCEDURE TimKiemThanhVien
    @TenThanhVien NVARCHAR(255)
AS
BEGIN
    SELECT * FROM TheThanhVien WHERE TenThanhVien LIKE '%' + @TenThanhVien + '%'
END
EXEC dbo.TimKiemThanhVien @TenThanhVien = N'L' -- nvarchar(255)
------------------------------
GO
--Thêm thông tin mượn sách (thủ tục nhập):
CREATE PROCEDURE ThemMuonSach
    @MaMuon INT,
    @MaSach INT,
    @MaThe INT,
    @NgayMuon DATE,
    @NgayHetHan DATE,
	@TenThanhVien NVARCHAR(255)
AS
BEGIN
    INSERT INTO MuonSach (MaMuon, MaSach, MaThe, NgayMuon, NgayHetHan,TenThanhVien)
    VALUES (@MaMuon, @MaSach, @MaThe, @NgayMuon, @NgayHetHan,@TenThanhVien)
END
EXEC dbo.ThemMuonSach @MaMuon = 9,               -- int
                      @MaSach = 01,               -- int
                      @MaThe = 2100535,                -- int
                      @NgayMuon = '2023-07-15',  -- date
                      @NgayHetHan = '2023-07-15', -- date
					  @TenThanhVien = N'Nguyen tiendat'
GO
SELECT * FROM dbo.MuonSach
GO
CREATE PROCEDURE CapNhatMuonSach
    @MaMuon INT,
    @MaSach INT,
    @MaThe INT,
    @NgayMuon DATE,
    @NgayHetHan DATE,
	@TenThanhVien  NVARCHAR(255)
AS
BEGIN
    UPDATE MuonSach
    SET MaSach = @MaSach, MaThe = @MaThe, NgayMuon = @NgayMuon, NgayHetHan = @NgayHetHan ,TenThanhVien = @TenThanhVien
    WHERE MaMuon = @MaMuon
END

EXEC dbo.CapNhatMuonSach @MaMuon = 9,                -- int
                         @MaSach = 1,                -- int
                         @MaThe = 2100535,                 -- int
                         @NgayMuon = '2023-07-15',   -- date
                         @NgayHetHan = '2023-07-15', -- date
                         @TenThanhVien = N'NGUYEn THI DUONG'         -- nvarchar(255)
GO
SELECT * FROM dbo.MuonSach
go

CREATE PROCEDURE XoaMuonSach
    @MaMuon INT
AS
BEGIN
    DELETE FROM MuonSach
    WHERE MaMuon = @MaMuon
END
EXEC dbo.XoaMuonSach @MaMuon = 9 -- int
go
CREATE PROCEDURE TimKiemMuonSach
    @MaMuon INT
AS
BEGIN
    SELECT *
    FROM MuonSach
    WHERE MaMuon = @MaMuon
END
EXEC TimKiemMuonSach @MaMuon = 1;

GO
-- 
CREATE PROCEDURE DangKyAdmin
    @TaiKhoan NVARCHAR(255),
    @Matkhau NVARCHAR(255),
    @emali NVARCHAR(255),
    @Hoten NVARCHAR(255),
    @GioiTinh NVARCHAR(10),
    @Diachi NVARCHAR(255),
	@sdt INT
AS
BEGIN
INSERT INTO Admins (TaiKhoan, Matkhau, emali, Hoten, GioiTinh, Diachi, std)
    VALUES (@TaiKhoan, @Matkhau, @emali, @Hoten, @GioiTinh, @Diachi,@sdt)
END
EXEC dbo.DangKyAdmin @TaiKhoan = N'tiendat', -- nvarchar(255)
                     @Matkhau = N'123',  -- nvarchar(255)
                     @emali = N'go@gamil.com',    -- nvarchar(255)
                     @Hoten = N'go',    -- nvarchar(255)
                     @GioiTinh = N'nu', -- nvarchar(10)
                     @Diachi = N'lai xa',   -- nvarchar(255)
                     @sdt = 0000000         -- int

GO
  SELECT * FROM dbo.Admins  
CREATE PROCEDURE CapNhatAdmin
    @ID INT,
    
    @Matkhau NVARCHAR(255),
    @emali NVARCHAR(255),
    @Hoten NVARCHAR(255),
    @GioiTinh NVARCHAR(10),
    @Diachi NVARCHAR(255),
    @std INT
	AS
	BEGIN
	UPDATE Admins
    SET Matkhau = @Matkhau,emali = @emali,Hoten = @Hoten,GioiTinh = @GioiTinh,Diachi = @Diachi,std = @std WHERE ID = @ID
	END
	GO

	EXEC dbo.CapNhatAdmin @ID = 5,         -- int
	                      @Matkhau = N'1111',  -- nvarchar(255)
	                      @emali = N'go@gmail.com',    -- nvarchar(255)
	                      @Hoten = N'go',    -- nvarchar(255)
	                      @GioiTinh = N'nu', -- nvarchar(10);
	                      @Diachi = N'',   -- nvarchar(255)
	                      @std = 000005         -- int
	
CREATE PROCEDURE DeleteAdmin
    @ID INT
AS
BEGIN
    DELETE FROM Admins
    WHERE ID = @ID
END
EXEC dbo.DeleteAdmin @ID = 0 -- int
GO
---Viết view hiển thị 1 bảng bất kỳ theo thông tin khóa ngoài. 
CREATE VIEW ViewMuonSach AS
SELECT M.MaMuon, S.TenSach, TV.TenThanhVien, M.NgayMuon, M.NgayHetHan
FROM MuonSach M
INNER JOIN Sach S ON M.MaSach = S.MaSach
INNER JOIN TheThanhVien TV ON M.MaThe = TV.MaThe
GO

SELECT * FROM ViewMuonSach
SELECT * FROM dbo.TheThanhVien
SELECT * FROM dbo.Sach
SELECT * FROM dbo.MuonSach
GO
-- Thống kê
CREATE PROCEDURE ThongKeSachTheoTacGia
AS
BEGIN
    SELECT S.TacGia, COUNT(*) AS SoLuongMuon  
    FROM Sach S 
    INNER JOIN MuonSach M ON S.MaSach = M.MaSach
    GROUP BY S.TacGia
END
--go 
--Xem kết quả Thống kê
EXEC ThongKeSachTheoTacGia
GO
CREATE PROCEDURE DangNhap
    @TaiKhoan NVARCHAR(255),
    @MatKhau NVARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Admins WHERE TaiKhoan = @TaiKhoan AND Matkhau = @MatKhau)
    BEGIN
        PRINT N'Đăng nhập thành công!'
    END
    ELSE
    BEGIN
        PRINT N'Sai tên tài khoản hoặc mật khẩu. Vui lòng kiểm tra lại.'
    END
END 

EXEC DangNhap @TaiKhoan = N'Tiendat2K', @MatKhau = N'1111'
GO
SELECT * FROM dbo.Admins
GO
CREATE PROCEDURE QuenMatKhau
    @Email NVARCHAR(255),
    @MatKhauMoi NVARCHAR(255)
AS
BEGIN
    -- Kiểm tra xem email có tồn tại trong bảng "Admins" hay không
    IF NOT EXISTS (SELECT 1 FROM Admins WHERE emali = @Email)
    BEGIN
        PRINT N'Dữ liệu không tồn tại. Vui lòng kiểm tra lại thông tin.'
        RETURN
    END
    -- Nếu email tồn tại, yêu cầu nhập mật khẩu mới và cập nhật mật khẩu
    UPDATE Admins
    SET MatKhau = @MatKhauMoi
    WHERE emali = @Email
    PRINT N'Cập nhật mật khẩu thành công!'
END
EXEC dbo.QuenMatKhau @Email = N'datanhtrai@gmail.com',     -- nvarchar(255)
                     @MatKhauMoi = N'Nguyentiendat12' -- nvarchar(255)