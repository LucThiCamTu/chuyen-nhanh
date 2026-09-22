-- Chọn cơ sở dữ liệu mẫu
USE classicmodels;

-- ================================================
-- 1. Tham số loại IN
-- Khái niệm: Nhận giá trị truyền từ bên ngoài vào Procedure để xử lý.
-- ================================================
DROP PROCEDURE IF EXISTS getCusById;

DELIMITER //

CREATE PROCEDURE getCusById (
    IN cusNum INT
)
BEGIN
    SELECT * FROM customers WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi Stored Procedure dạng IN
CALL getCusById(175);


-- ================================================
-- 2. Tham số loại OUT
-- Khái niệm: Lấy giá trị được tính toán từ bên trong Procedure ra bên ngoài.
-- ================================================
DROP PROCEDURE IF EXISTS GetCustomersCountByCity;

DELIMITER //

CREATE PROCEDURE GetCustomersCountByCity (
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi Stored Procedure dạng OUT (sử dụng biến Session @total)
CALL GetCustomersCountByCity('Lyon', @total);

-- Hiển thị kết quả ra màn hình
SELECT @total;


-- ================================================
-- 3. Tham số loại INOUT
-- Khái niệm: Kết hợp cả IN và OUT (vừa nhận giá trị ban đầu, vừa trả lại giá trị sau khi xử lý).
-- ================================================
DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER //

CREATE PROCEDURE SetCounter (
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Gọi Stored Procedure dạng INOUT
SET @counter = 1;
CALL SetCounter(@counter, 1); -- Tăng lên 2
CALL SetCounter(@counter, 1); -- Tăng lên 3
CALL SetCounter(@counter, 5); -- Tăng lên 8

-- Hiển thị kết quả cuối cùng
SELECT @counter;