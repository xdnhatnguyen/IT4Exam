# 🎓 IT4Exam - Hệ Thống Ôn Thi Học Kỳ FIT HCMUS

Nền tảng tổng hợp đề thi thử nghiệm, ngân hàng trắc nghiệm có lời giải chi tiết, tóm tắt lý thuyết trọng tâm và tài liệu học tập dành cho sinh viên Khoa Công nghệ Thông tin - Trường Đại học Khoa học Tự nhiên, ĐHQG-HCM (Lớp 25CTT3).

🌐 **Trang web chính thức trên GitHub Pages:** [https://xdnhatnguyen.github.io/IT4Exam/](https://xdnhatnguyen.github.io/IT4Exam/)

---

## 📅 Lịch Thi Giữa Kỳ Học Kỳ I (25CTT3)

| Mã MH | Tên môn học | Ngày thi | Giờ thi | Thời gian | CBGD | Phòng | Trạng thái |
| :--- | :--- | :---: | :---: | :---: | :--- | :---: | :---: |
| **PHY00002** | Vật lý đại cương 2 (Điện từ - Quang) | 16/11/2026 | 16g00 | 60' | Nguyễn Nhật Kim Ngân | LT | 🔴 Hôm nay |
| **MTH00044** | Xác suất thống kê | 18/11/2026 | 14g45 | 60' | Thái Phúc Hưng | LT | ⏳ Sắp tới |
| **CSC10008** | **Mạng máy tính** | **19/11/2026** | **13g30** | **60'** | **Huỳnh Thụy Bảo Trân** | **LT** | 🚀 **Đang mở ôn thi** |
| **MTH00050** | Toán học tổ hợp | 20/11/2026 | 10g15 | 60' | Bùi Văn Thạch | LT | ⏳ Sắp tới |

---

## 🌐 Môn Mạng Máy Tính (CSC10008)

👉 **Truy cập hệ thống luyện thi MMT:** [https://xdnhatnguyen.github.io/IT4Exam/mmt/](https://xdnhatnguyen.github.io/IT4Exam/mmt/)

- **Form đề thi:** **57 câu / 40 phút** (Đếm ngược thời gian thực, tự động thu bài khi hết giờ).
- **Ngân hàng câu hỏi:** 185 câu trắc nghiệm bao quát từ Đề thi chính thức 2024–2025 (70 câu), Đề dự đoán 2025–2026 (50 câu), Chuyên đề Subnetting Quiz Moodle & Slide 02 (25 câu), Chuyên đề Lý thuyết 5 slide (40 câu).
- **Tính năng nổi bật:**
  - Tự động lưu đáp án vào `localStorage` theo thời gian thực (không lo mất bài khi tải lại trang).
  - Bộ lọc câu hỏi thông minh sau khi nộp bài: Xem riêng các câu **SAI** kèm lời giải chi tiết và mẹo ghi nhớ.
  - Bảng điều hướng câu hỏi trực quan (palette), đánh dấu câu khó ⭐.
- **Tài liệu & Tóm tắt PDF đính kèm:**
  - `MMT.pdf`: Tài liệu tóm tắt kinh điển của anh **Nguyễn Phúc Hoàng (nphoang.itus)** - Cựu sinh viên FIT HCMUS.

---

## 💻 Calculus 1 & Thực Hành Matlab

Thư mục [`Calculus1_Matlab/`](Calculus1_Matlab/) chứa toàn bộ các script Matlab tính toán đạo hàm, tích phân, giải tích số và các bài kiểm tra thực hành.

---

## 🛠️ Cấu trúc Kho lưu trữ

```text
IT4Exam/
├── index.html                   # Cổng chính: Lịch thi và danh mục môn học
├── README.md                    # Giới thiệu tổng quan
├── .gitignore                   # Loại trừ các tài liệu bảo mật
├── Calculus1_Matlab/            # Toàn bộ mã nguồn thực hành Matlab
│   ├── README.md
│   ├── Test_13Oct.m
│   ├── info.txt
│   ├── nopbai.m
│   ├── test_8Dec.asv
│   ├── test_8Dec.m
│   ├── test_8Dec_2.m
│   └── test_8Dec_daoHamTichPhan.m
└── mmt/                         # Phân hệ Mạng máy tính
    ├── index.html               # Web thi trắc nghiệm tương tác Form 57 câu/40'
    └── docs/                    # Kho tài liệu PDF MMT
        └── MMT.pdf              # (Tác giả: Nguyễn Phúc Hoàng - nphoang.itus)
```
