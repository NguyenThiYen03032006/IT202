CREATE DATABASE mini_project_ss08;
USE mini_project_ss08;

-- Xóa bảng nếu đã tồn tại (để chạy lại nhiều lần)
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;

-- Bảng khách hàng
CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(100),
    phone VARCHAR(20)
);

-- Bảng phòng
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(50),
    price_per_day DECIMAL(10,0)
);

-- Bảng đặt phòng
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

INSERT INTO guests (guest_name, phone) VALUES
('Nguyễn Văn An', '0901111111'),
('Trần Thị Bình', '0902222222'),
('Lê Văn Cường', '0903333333'),
('Phạm Thị Dung', '0904444444'),
('Hoàng Văn Em', '0905555555');

INSERT INTO rooms (room_type, price_per_day) VALUES
('Standard', 500000),
('Standard', 500000),
('Deluxe', 800000),
('Deluxe', 800000),
('VIP', 1500000),
('VIP', 2000000);

INSERT INTO bookings (guest_id, room_id, check_in, check_out) VALUES
(1, 1, '2024-01-10', '2024-01-12'), -- 2 ngày
(1, 3, '2024-03-05', '2024-03-10'), -- 5 ngày
(2, 2, '2024-02-01', '2024-02-03'), -- 2 ngày
(2, 5, '2024-04-15', '2024-04-18'), -- 3 ngày
(3, 4, '2023-12-20', '2023-12-25'), -- 5 ngày
(3, 6, '2024-05-01', '2024-05-06'), -- 5 ngày
(4, 1, '2024-06-10', '2024-06-11'); -- 1 ngày

-- Phan 1

-- liet ke ten khach va sdt cua tat ca khach
select guest_name as ten_khach, phone as sdt
from guests;

-- liet ke cac loai phong khac nhau trong khach san
select distinct room_type as loai_phong
from rooms;

-- hien thi loai phong va gia thue theo ngay, sx theo gia tang dan
select distinct room_type as loai_phong, price_per_day as gia_thue_theo_ngay
from rooms
order by price_per_day desc;

-- hien thi cac loai phong co gia thue > 1.000.000
select distinct room_type as loai_phong, price_per_day as gia_thue_theo_ngay
from rooms
where price_per_day > 1000000;

-- liet ke cac lan dat vong dien ra trong nam 2024
select *
from bookings
where year(check_in)=2024;

-- cho bt so luong phong cua tung loai phong
select room_type as loai_phong, count(room_type)
from rooms
group by room_type;


-- Phan 2

-- liet ke danh sach cac lan dat phong, hien thi ten kh,loai phong,ngay nhan(check_in)
select g.guest_name, r.room_type,b.check_in
from bookings b
join guests g on g.guest_id=b.guest_id
join rooms r on r.room_id=b.room_id;

-- cho biet moi khach hang dat phong bao nhieu lan
select g.guest_name as ten_khach,count(b.check_in) as so_lan_dat_phong
from bookings b
join guests g on g.guest_id=b.guest_id
group by g.guest_id;

-- tinh doanh thu cua moi phong
select 
b.room_id,
r.price_per_day as so_tien_moi_ngay,
datediff(b.check_out,b.check_in) as so_ngay,
r.price_per_day*datediff(b.check_out,b.check_in) as tong_tien
from bookings b
join rooms r on r.room_id=b.room_id;

-- hien thi tong doanh thu cua tung loai phong
select 
r.room_type,
r.price_per_day as so_tien_moi_ngay,
sum(r.price_per_day*datediff(b.check_out,b.check_in)) as tong_tien
from bookings b
join rooms r on r.room_id=b.room_id
group by r.room_id;

-- tim nhung khach hang da dat phong tu 2 lan tro len
select g.guest_name as ten_khach,count(b.check_in) as so_lan_dat_phong
from bookings b
join guests g on g.guest_id=b.guest_id
group by g.guest_id
having count(b.check_in)>=2;

-- tim loai phong co so luot dat phong nhieu nhat
select 
r.room_type,
count(*) as so_lan_dat_phong
from bookings b
join rooms r on r.room_id = b.room_id
group by r.room_type
having count(*) = (
    select max(t.so_lan)
    from (
        select count(*) as so_lan
        from bookings b2
        join rooms r2 on r2.room_id = b2.room_id
        group by r2.room_type
    ) t
);
















