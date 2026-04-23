-- 1. Phân tích 2 giải pháp
-- Cách 1: Dùng ALTER TABLE MODIFY
-- Thay đổi trực tiếp kiểu dữ liệu của cột Phone.

-- Ưu điểm:
-- Nhanh, ngắn gọn.
-- Ít câu lệnh → dễ thực thi.

-- Nhược điểm:
-- Nguy cơ mất dữ liệu nếu kiểu cũ không tương thích.
-- Không kiểm soát được quá trình chuyển đổi.
-- Không an toàn với dữ liệu lớn / hệ thống đang chạy.

-- Cách 2: Tạo cột mới + migrate dữ liệu
-- Tạo cột mới → copy dữ liệu → xóa cột cũ → đổi tên.

-- Ưu điểm:
-- An toàn hơn (có thể kiểm tra dữ liệu trước khi xóa).
-- Kiểm soát được việc chuyển đổi dữ liệu.
-- Phù hợp hệ thống lớn.

-- Nhược điểm:
-- Nhiều bước, phức tạp hơn.
-- Tốn thời gian hơn.

-- 2. Lựa chọn giải pháp
-- Chọn Cách 2 vì:
-- An toàn hơn với dữ liệu.
-- Phù hợp hệ thống thực tế (production).
-- Có thể rollback nếu lỗi.

-- 3. Câu lệnh SQL cuối cùng
ALTER TABLE USERS ADD Phone_new VARCHAR(15);

UPDATE USERS 
SET Phone_new = CAST(Phone AS CHAR);

ALTER TABLE USERS DROP COLUMN Phone;

ALTER TABLE USERS 
CHANGE Phone_new Phone VARCHAR(15);

-- 5. Kết luận ngắn gọn
-- Cách 1: nhanh nhưng rủi ro.
-- Cách 2: chậm hơn nhưng an toàn -> nên dùng trong thực tế.