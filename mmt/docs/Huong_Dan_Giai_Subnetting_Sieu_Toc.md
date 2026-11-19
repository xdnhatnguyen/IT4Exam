# Bí Kíp & Phương Pháp Giải Nhanh Chia Mạng Con Subnetting (FIT HCMUS)

> **Tài liệu tổng hợp trọng tâm ôn thi Mạng máy tính**  
> Dành cho sinh viên ôn thi giữa kỳ và cuối kỳ. Tổng hợp đầy đủ bảng nhị phân 8 bit, công thức bước nhảy ($\Delta$), kỹ thuật chia subnet đều, subnet không đều (VLSM), cùng lời giải chi tiết 100% trọn bộ 25 câu hỏi trắc nghiệm thực chiến.

---

## Phần 1: Bảng Tra Cứu Thần Tốc (Quick Reference Cheatsheet)

### 1.1. Bảng 8 bit nhị phân trong 1 Octet (Bắt buộc học thuộc)
Trong địa chỉ IPv4, Subnet mask luôn có các bit 1 liên tục từ trái qua phải. Khi mượn từ 1 đến 8 bit trong một octet, giá trị thập phân và **bước nhảy** tương ứng như sau:

| Số bit mượn ($n$) | Dạng nhị phân | Giá trị Subnet mask | Bước nhảy $\Delta$ ($256 - \text{Mask}$) | Số subnet ($2^n$) | Số host tối đa trong octet ($2^{8-n}-2$) |
| :---: | :---: | :---: | :---: | :---: | :---: |
| **1 bit** | `1000 0000` | **128** | **128** ($2^7$) | 2 | $128 - 2 = 126$ |
| **2 bit** | `1100 0000` | **192** | **64** ($2^6$) | 4 | $64 - 2 = 62$ |
| **3 bit** | `1110 0000` | **224** | **32** ($2^5$) | 8 | $32 - 2 = 30$ |
| **4 bit** | `1111 0000` | **240** | **16** ($2^4$) | 16 | $16 - 2 = 14$ |
| **5 bit** | `1111 1000` | **248** | **8** ($2^3$) | 32 | $8 - 2 = 6$ |
| **6 bit** | `1111 1100` | **252** | **4** ($2^2$) | 64 | $4 - 2 = 2$ (Point-to-Point) |
| **7 bit** | `1111 1110` | **254** | **2** ($2^1$) | 128 | $2 - 2 = 0$ (Không dùng) |
| **8 bit** | `1111 1111` | **255** | **1** ($2^0$) | 256 | Octet mạng trọn vẹn |

* **Mẹo nhớ dãy số mask:** $128 \xrightarrow{+64} 192 \xrightarrow{+32} 224 \xrightarrow{+16} 240 \xrightarrow{+8} 248 \xrightarrow{+4} 252 \xrightarrow{+2} 254 \xrightarrow{+1} 255$.
* **Mẹo tính bước nhảy:** $\Delta = 256 - \text{Giá trị mask tại octet đó} = 2^{\text{số bit 0 còn lại}}$.

---

### 1.2. Phân lớp Class A, B, C & Subnet Mask mặc định

| Lớp | Dải octet đầu | Subnet mask mặc định | Prefix | Cấu trúc NetID : HostID |
| :---: | :---: | :---: | :---: | :---: |
| **Lớp A** | **$1 \rightarrow 126$** | `255.0.0.0` | **/8** | 8 bit NetID : 24 bit HostID |
| **Lớp B** | **$128 \rightarrow 191$** | `255.255.0.0` | **/16** | 16 bit NetID : 16 bit HostID |
| **Lớp C** | **$192 \rightarrow 223$** | `255.255.255.0` | **/24** | 24 bit NetID : 8 bit HostID |

* **Địa chỉ đặc biệt cần nhớ:**
  * `127.0.0.0/8` (`127.0.0.1`): Dải Loopback kiểm tra card mạng nội bộ.
  * `224.0.0.0` – `239.255.255.255`: Lớp D (Multicast).
  * `240.0.0.0` – `255.255.255.255`: Lớp E (Dự phòng / Nghiên cứu).
  * `169.254.0.0/16`: Địa chỉ APIPA tự động gán khi máy tính không nhận được phản hồi từ DHCP server.
* **3 Dải Private IP (RFC 1918) không định tuyến trên Internet:**
  1. Lớp A: `10.0.0.0/8` (`10.0.0.0` – `10.255.255.255`)
  2. Lớp B: `172.16.0.0/12` (`172.16.0.0` – `172.31.255.255`)
  3. Lớp C: `192.168.0.0/16` (`192.168.0.0` – `192.168.255.255`)

---

### 1.3. Nhận diện "Octet biến động" theo tiền tố Prefix (/x)
Nhìn vào $/x$ để biết ngay octet nào đang bị chia cắt và tính toán trực tiếp trên octet đó:
* $/8 \le x < /16$: Biến động ở **Octet 2** (dạng `255.X.0.0`).
* $/16 \le x < /24$: Biến động ở **Octet 3** (dạng `255.255.X.0`).
* $/24 \le x \le /30$: Biến động ở **Octet 4** (dạng `255.255.255.X`).

---

## Phần 2: Phương Pháp 3 Bước Tìm Mọi Thứ Bằng Bước Nhảy ($\Delta$)

Mọi địa chỉ mạng (NetID) tại octet biến động đều là **bội số của bước nhảy $\Delta$**:
$$0, \quad \Delta, \quad 2\Delta, \quad 3\Delta, \quad 4\Delta, \quad \dots$$

### Quy trình giải nhanh 5 giây:
1. **Tìm octet biến động & bước nhảy $\Delta$**:  
   $$\Delta = 256 - \text{Giá trị mask tại octet đó}$$
2. **Tìm NetID**:  
   Lấy giá trị IP tại octet đó chia cho $\Delta$, lấy phần nguyên rồi nhân lại với $\Delta$:
   $$\text{NetID}_{\text{octet}} = \left\lfloor \frac{\text{IP}_{\text{octet}}}{\Delta} \right\rfloor \times \Delta$$
   *(Các octet bên trái giữ nguyên, các octet bên phải set về 0).*
3. **Tìm Broadcast**:  
   Bằng NetID của mạng kế tiếp trừ đi 1:
   $$\text{Broadcast}_{\text{octet}} = \text{NetID}_{\text{octet}} + \Delta - 1$$
   *(Các octet bên phải set về 255).*
4. **Dải IP khả dụng cấp cho host:**
   * IP đầu: $\text{NetID} + 1$
   * IP cuối: $\text{Broadcast} - 1$
   * Tổng số IP gán được: $2^h - 2$ (với $h = 32 - \text{prefix}$).

---

## Phần 3: Phương Pháp Chia Subnet Theo Nhu Cầu (VLSM)

Khi bài toán yêu cầu: *"Cho mạng X, hãy chia cho các phòng ban A, B, C... với số lượng host khác nhau"*:

* **Quy tắc 1 (Tối quan trọng):** Sắp xếp nhu cầu host theo thứ tự **giảm dần** (từ mạng cần nhiều host nhất đến ít host nhất).
* **Quy tắc 2:** Với mỗi mạng cần $H$ host, tìm số bit host $h$ nhỏ nhất thỏa mãn:  
  $$2^h - 2 \ge H$$
  * Tính prefix mới: $\text{Prefix} = 32 - h$.
  * Tính bước nhảy: $\Delta = 2^h$.
* **Quy tắc 3:** Lần lượt phân phối dải IP:
  * Mạng 1 bắt đầu từ $\text{NetID}_{\text{gốc}}$, subnet kế tiếp có $\text{NetID} = \text{NetID}_1 + \Delta_1$.
  * Mạng 2 bắt đầu từ $\text{NetID}$ mới, tiếp tục cộng dồn bước nhảy $\Delta_2$...

---

## Phần 4: Lời Giải Chi Tiết Trọn Bộ 25 Câu Trắc Nghiệm Subnetting

---

### Câu 1
**Đề bài:** Cho địa chỉ đường mạng: `142.18.10.0/23`, hãy cho biết số địa chỉ hợp lệ có thể dùng đánh địa chỉ cho host trong đường mạng này là:  
A. 512  
B. 510  
C. 254  
D. 1022  

* **Lời giải:**
  * Prefix $/23 \Rightarrow$ Số bit dành cho phần HostID là: $h = 32 - 23 = 9$ bit.
  * Số địa chỉ IP hợp lệ có thể cấp phát cho host:  
    $$\text{Số host} = 2^h - 2 = 2^9 - 2 = 512 - 2 = 510$$
* **Đáp án đúng:** **B (510)**.

---

### Câu 2
**Đề bài:** Địa chỉ mạng (NetID) tương ứng của địa chỉ IP `182.12.9.1` là:  
A. `182.0.0.0`  
B. `182.12.0.0`  
C. `182.12.9.0`  
D. `182.12.9.1`  

* **Lời giải:**
  * Octet đầu tiên là 182, nằm trong dải $128 \rightarrow 191 \Rightarrow$ IP thuộc **Lớp B**.
  * Lớp B có Subnet mask mặc định là `255.255.0.0` (/16), nghĩa là 2 octet đầu là NetID, 2 octet sau là HostID.
  * Để tìm địa chỉ mạng, giữ nguyên 2 octet đầu, đưa 2 octet sau về 0: `182.12.0.0`.
* **Đáp án đúng:** **B (`182.12.0.0`)**.

---

### Câu 3
**Đề bài:** Bạn có một địa chỉ lớp C, bạn cần 9 subnet và nhiều địa chỉ IP trên mỗi subnet, subnet mask nào trong các subnet sau sẽ được sử dụng?  
A. `255.255.255.224`  
B. `255.255.255.240`  
C. `255.255.255.248`  
D. `255.255.255.192`  

* **Lời giải:**
  * Cần chia thành $N = 9$ subnet.
  * Số bit mượn $n$ phải thỏa mãn: $2^n \ge 9$.
    * Với $n = 3 \Rightarrow 2^3 = 8 < 9$ (không đủ).
    * Với $n = 4 \Rightarrow 2^4 = 16 \ge 9$ (thỏa mãn, tối ưu nhất để còn lại nhiều bit host nhất).
  * Lớp C mặc định là `/24`. Mượn thêm 4 bit $\Rightarrow$ Prefix mới là $/28$.
  * 4 bit mượn ở octet 4: `1111 0000` tương ứng giá trị $240$.
  * $\Rightarrow$ Subnet mask: `255.255.255.240`.
* **Đáp án đúng:** **B (`255.255.255.240`)**.

---

### Câu 4
**Đề bài:** Số lượng máy tính tối đa (mỗi máy tính dùng 1 địa chỉ IP và không dùng các giá trị địa chỉ IP đặc biệt) có thể triển khai trong subnet có subnet mask tương ứng `255.255.255.192` là:  
A. 64  
B. 62  
C. 126  
D. 30  

* **Lời giải:**
  * Octet 4 có giá trị $192 = 11000000_2$ (mượn 2 bit, còn lại 6 bit cho host).
  * Số bit host $h = 6$.
  * Số lượng máy tính tối đa: $2^h - 2 = 2^6 - 2 = 64 - 2 = 62$.
* **Đáp án đúng:** **B (62)**.

---

### Câu 5
**Đề bài:** Cho subnet có tiền tố mạng là `192.168.10.32/27`. Địa chỉ IP nào sau đây KHÔNG thể gán cho một host trong subnet này?  
A. `192.168.10.33`  
B. `192.168.10.45`  
C. `192.168.10.62`  
D. `192.168.10.63`  

* **Lời giải:**
  * Prefix $/27 \Rightarrow$ Mượn 3 bit ở octet 4 $\Rightarrow$ Mask là `255.255.255.224`.
  * Bước nhảy $\Delta = 256 - 224 = 32$.
  * NetID: `192.168.10.32`.
  * Broadcast: $\text{NetID} + \Delta - 1 = 32 + 32 - 1 = 63 \Rightarrow$ `192.168.10.63`.
  * Dải IP khả dụng cho host: `192.168.10.33` $\rightarrow$ `192.168.10.62`.
  * `192.168.10.63` là địa chỉ Broadcast của mạng nên không thể gán cho host.
* **Đáp án đúng:** **D (`192.168.10.63`)**.

---

### Câu 6
**Đề bài:** Cho biết địa chỉ IP nào dưới đây nằm cùng một mạng con (subnet) với địa chỉ IP `162.19.8.1` (subnet mask `255.255.252.0`)?  
A. `162.19.12.1`  
B. `162.19.11.1`  
C. `162.19.7.254`  
D. `162.19.16.1`  

* **Lời giải:**
  * Subnet mask `255.255.252.0` có octet biến động là octet 3 (giá trị 252).
  * Bước nhảy $\Delta = 256 - 252 = 4$.
  * Octet 3 của IP là 8. Bội số của 4 gồm: $0, 4, \mathbf{8}, \mathbf{12}, \dots$
  * $\Rightarrow$ NetID: `162.19.8.0`.
  * $\Rightarrow$ Broadcast: octet $3 = 8 + 4 - 1 = 11$, octet $4 = 255 \Rightarrow$ `162.19.11.255`.
  * Dải IP cùng mạng: từ `162.19.8.1` đến `162.19.11.254`.
  * `162.19.11.1` có octet 3 bằng 11, nằm trong dải $\Rightarrow$ Cùng subnet.
* **Đáp án đúng:** **B (`162.19.11.1 (subnet mask 255.255.252.0)`)**.

---

### Câu 7
**Đề bài:** Địa chỉ nào sau đây có thể dùng để đánh địa chỉ cho máy tính (host)?  
A. `172.29.5.3/25`  
B. `192.168.1.63/26`  
C. `10.0.0.0/24`  
D. `192.168.2.255/24`  

* **Lời giải:**
  * Xét `172.29.5.3/25`: Prefix $/25 \Rightarrow$ Bước nhảy $\Delta = 256 - 128 = 128$.
    * NetID: `172.29.5.0`. Broadcast: `172.29.5.127`.
    * Dải host: `172.29.5.1` $\rightarrow$ `172.29.5.126`. Địa chỉ `172.29.5.3` là host hợp lệ!
  * Loại các câu khác:
    * `192.168.1.63/26` là Broadcast (NetID `192.168.1.0/26` có broadcast là `.63`).
    * `10.0.0.0/24` là NetID.
    * `192.168.2.255/24` là Broadcast.
* **Đáp án đúng:** **A (`172.29.5.3/25`)**.

---

### Câu 8
**Đề bài:** Một mạng con lớp C mượn 2 bit để chia Subnet thì Subnet Mask sẽ là:  
A. `255.255.255.128`  
B. `255.255.255.192`  
C. `255.255.255.224`  
D. `255.255.255.240`  

* **Lời giải:**
  * Lớp C mặc định `/24` (`255.255.255.0`).
  * Mượn 2 bit ở octet 4: `1100 0000` $= 128 + 64 = 192$.
  * $\Rightarrow$ Subnet Mask: `255.255.255.192`.
* **Đáp án đúng:** **B (`255.255.255.192`)**.

---

### Câu 9
**Đề bài:** Một mạng được giao dãy IP `112.12.0.0/24`. Quản trị mạng muốn tạo ra 3 subnet trong dãy đó. Số lượng IP host tối đa trong mỗi subnet được phép theo kỹ thuật VLSM là bao nhiêu?  
A. 62, 62, 62  
B. 126, 62, 62  
C. 126, 126, 62  
D. 254, 126, 62  

* **Lời giải:**
  * Mạng `/24` có tổng cộng 256 địa chỉ.
  * Chia theo VLSM tối ưu cho 3 mạng:
    * Mạng lớn nhất: mượn 1 bit ($/25$) chiếm 128 IP $\Rightarrow 128 - 2 = 126$ host.
    * Nửa còn lại (128 IP) chia đôi tiếp cho 2 mạng (mỗi mạng $/26$ chiếm 64 IP) $\Rightarrow 64 - 2 = 62$ host mỗi mạng.
  * $\Rightarrow$ Ba subnet có số host tối đa lần lượt là: 126, 62, 62.
* **Đáp án đúng:** **B (126, 62, 62)**.

---

### Câu 10
**Đề bài:** Đối với một địa chỉ IP thuộc lớp B nếu muốn sử dụng 3 bit để làm SubnetID thì nó sẽ có subnet mask tương ứng là:  
A. `255.255.192.0`  
B. `255.255.224.0`  
C. `255.255.240.0`  
D. `255.255.255.224`  

* **Lời giải:**
  * Lớp B mặc định là `/16` (`255.255.0.0`).
  * Mượn 3 bit ở octet 3: `1110 0000` tương ứng giá trị $224$.
  * $\Rightarrow$ Subnet mask mới: `255.255.224.0` (/19).
* **Đáp án đúng:** **B (`255.255.224.0`)**.

---

### Câu 11
**Đề bài:** Một tổ chức đăng ký một địa chỉ mạng lớp C: `199.166.31.0` từ ISP. Người quản trị mạng đã chia địa chỉ trên với subnet mask: `255.255.255.192`. Hỏi có bao nhiêu host được hỗ trợ trong mỗi mạng con?  
A. 30  
B. 62  
C. 64  
D. 126  

* **Lời giải:**
  * Mask `255.255.255.192` $\Rightarrow$ Octet 4 có 2 bit mượn, còn lại $h = 6$ bit host.
  * Số host hỗ trợ trong mỗi subnet: $2^6 - 2 = 64 - 2 = 62$.
* **Đáp án đúng:** **B (62)**.

---

### Câu 12
**Đề bài:** Địa chỉ nào là địa chỉ host nằm cùng subnet với địa chỉ `192.168.15.8/29`?  
A. `192.168.15.15`  
B. `192.168.15.14`  
C. `192.168.15.7`  
D. `192.168.15.16`  

* **Lời giải:**
  * Prefix $/29 \Rightarrow$ Mượn 5 bit ở octet 4 $\Rightarrow$ Mask `255.255.255.248`.
  * Bước nhảy $\Delta = 256 - 248 = 8$.
  * Octet 4 của IP là 8 $\Rightarrow$ NetID chính là `192.168.15.8`.
  * Broadcast: $8 + 8 - 1 = 15 \Rightarrow$ `192.168.15.15`.
  * Dải host hợp lệ: từ `192.168.15.9` đến `192.168.15.14`.
  * `192.168.15.14` là host hợp lệ cùng subnet.
* **Đáp án đúng:** **B (`192.168.15.14`)**.

---

### Câu 13
**Đề bài:** Cho địa chỉ IP: `172.29.56.43/28`, hãy cho biết địa chỉ mạng (Network ID) của địa chỉ này:  
A. `172.29.56.0`  
B. `172.29.56.32`  
C. `172.29.56.40`  
D. `172.29.56.48`  

* **Lời giải:**
  * Prefix $/28 \Rightarrow$ Mượn 4 bit ở octet 4 $\Rightarrow$ Mask `255.255.255.240`.
  * Bước nhảy $\Delta = 256 - 240 = 16$.
  * Xét octet 4 là 43. Các bội số của 16 gồm: $0, 16, \mathbf{32}, \mathbf{48}, \dots$
  * Số 43 nằm giữa 32 và 48 $\Rightarrow$ NetID octet 4 là **32**.
  * $\Rightarrow$ NetID: `172.29.56.32`.
* **Đáp án đúng:** **B (`172.29.56.32`)**.

---

### Câu 14
**Đề bài:** Cho địa chỉ IP `128.16.5.0`. Xác định lớp mạng và địa chỉ Broadcast mặc định của nó:  
A. Lớp A, địa chỉ broadcast `128.255.255.255`  
B. Lớp B, địa chỉ broadcast `128.16.255.255`  
C. Lớp C, địa chỉ broadcast `128.16.5.255`  
D. Lớp B, địa chỉ broadcast `128.16.5.255`  

* **Lời giải:**
  * Octet đầu là 128 $\Rightarrow$ IP thuộc **Lớp B** (128–191).
  * Lớp B có Subnet mask mặc định `/16`, tức 2 octet đầu là NetID (`128.16`), 2 octet sau là HostID.
  * Địa chỉ broadcast mặc định: giữ nguyên 2 octet đầu, bật 2 octet sau thành 255 $\Rightarrow$ `128.16.255.255`.
* **Đáp án đúng:** **B (Lớp B, địa chỉ broadcast `128.16.255.255`)**.

---

### Câu 15
**Đề bài:** Cho địa chỉ IP `172.100.112.4/19`. Hãy xác định địa chỉ đường mạng (Network ID) chứa địa chỉ này:  
A. `172.100.0.0`  
B. `172.100.96.0`  
C. `172.100.112.0`  
D. `172.100.64.0`  

* **Lời giải:**
  * Prefix $/19 = 16 + 3 \Rightarrow$ Octet biến động là **octet 3** với 3 bit mượn (`1110 0000` = 224).
  * Bước nhảy $\Delta = 256 - 224 = 32$.
  * Octet 3 của IP là 112:
    * Bội số của 32: $0, 32, 64, \mathbf{96}, \mathbf{128}, \dots$
    * $112 \div 32 = 3.5 \Rightarrow 3 \times 32 = 96$.
  * NetID octet 3 là 96, octet 4 xóa về 0 $\Rightarrow$ `172.100.96.0`.
* **Đáp án đúng:** **B (`172.100.96.0`)**.

---

### Câu 16
**Đề bài:** Cho địa chỉ IP `172.100.112.4/19`. Hãy cho biết số lượng địa chỉ IP hợp lệ có thể gán cho host và dải địa chỉ đó là:  
A. 4094 host, từ `172.100.96.1` đến `172.100.111.254`  
B. 8190 host, từ `172.100.96.1` đến `172.100.127.254`  
C. 8192 host, từ `172.100.96.0` đến `172.100.127.255`  
D. 2046 host, từ `172.100.96.1` đến `172.100.103.254`  

* **Lời giải:**
  * Số bit host $h = 32 - 19 = 13$ bit.
  * Số IP gán cho host: $2^{13} - 2 = 8192 - 2 = 8190$ host.
  * NetID: `172.100.96.0` $\Rightarrow$ IP đầu: `172.100.96.1`.
  * Broadcast: octet 3 $= 96 + 32 - 1 = 127 \Rightarrow$ `172.100.127.255` $\Rightarrow$ IP cuối: `172.100.127.254`.
* **Đáp án đúng:** **B (8190 host, từ `172.100.96.1` đến `172.100.127.254`)**.

---

### Câu 17
**Đề bài:** Cho địa chỉ `172.100.112.4/19`. Địa chỉ Broadcast của đường mạng chứa địa chỉ này là:  
A. `172.100.112.255`  
B. `172.100.127.255`  
C. `172.100.128.255`  
D. `172.100.255.255`  

* **Lời giải:**
  * NetID là `172.100.96.0`, bước nhảy $\Delta = 32$ tại octet 3.
  * Octet 3 của Broadcast $= 96 + 32 - 1 = 127$.
  * Octet 4 bật toàn bộ bit 1 thành 255.
  * $\Rightarrow$ Broadcast: `172.100.127.255`.
* **Đáp án đúng:** **B (`172.100.127.255`)**.

---

### Câu 18
**Đề bài:** Công ty B được cấp địa chỉ đường mạng `192.168.1.0/24`. Công ty muốn chia thành 5 subnet: 2 subnet có 60 PCs và 3 subnet có 30 PCs. Sử dụng kỹ thuật VLSM, Subnet Mask cho các subnet có 60 PCs và các subnet có 30 PCs lần lượt là:  
A. `255.255.255.192` (/26) và `255.255.255.224` (/27)  
B. `255.255.255.128` (/25) và `255.255.255.192` (/26)  
C. `255.255.255.224` (/27) và `255.255.255.240` (/28)  
D. `255.255.255.0` (/24) và `255.255.255.128` (/25)  

* **Lời giải:**
  * Subnet cần 60 PCs: $2^h - 2 \ge 60 \Rightarrow h = 6$ bit $\Rightarrow$ Prefix $= 32 - 6 = /26$ $\Rightarrow$ Mask `255.255.255.192`.
  * Subnet cần 30 PCs: $2^h - 2 \ge 30 \Rightarrow h = 5$ bit $\Rightarrow$ Prefix $= 32 - 5 = /27$ $\Rightarrow$ Mask `255.255.255.224`.
* **Đáp án đúng:** **A (`255.255.255.192 (/26) và 255.255.255.224 (/27)`)**.

---

### Câu 19
**Đề bài:** Công ty A được cấp địa chỉ mạng `172.29.0.0/16`. Công ty cần chia thành 10 subnet đều nhau, trong đó subnet lớn nhất cần chứa được 500 PCs. Subnet mask tối ưu cần sử dụng là:  
A. `255.255.240.0` (/20)  
B. `255.255.254.0` (/23)  
C. `255.255.255.0` (/24)  
D. `255.255.224.0` (/19)  

* **Lời giải:**
  * Chia thành 10 subnet đều nhau $\Rightarrow 2^n \ge 10 \Rightarrow n = 4$ bit mượn.
  * Mạng ban đầu là Lớp B `/16`. Mượn thêm 4 bit $\Rightarrow$ Prefix mới $= 16 + 4 = /20$.
  * 4 bit mượn tại octet 3: `1111 0000` $= 240 \Rightarrow$ Mask `255.255.240.0`.
  * Kiểm tra số host: $h = 32 - 20 = 12$ bit host $\Rightarrow 2^{12} - 2 = 4094$ host $\ge 500$ PCs (thỏa mãn yêu cầu).
* **Đáp án đúng:** **A (`255.255.240.0 (/20)`)**.

---

### Câu 20
**Đề bài:** Cho địa chỉ IP `10.150.80.65` với Subnet Mask `255.248.0.0`. Network ID và Broadcast của mạng này lần lượt là:  
A. `10.144.0.0` và `10.151.255.255`  
B. `10.150.0.0` và `10.150.255.255`  
C. `10.128.0.0` và `10.159.255.255`  
D. `10.148.0.0` và `10.155.255.255`  

* **Lời giải:**
  * Mask `255.248.0.0` có octet biến động là octet 2 (giá trị 248).
  * Bước nhảy $\Delta = 256 - 248 = 8$.
  * Octet 2 của IP là 150:
    * Bội số của 8: $150 \div 8 = 18.75 \Rightarrow 18 \times 8 = 144$.
  * NetID octet 2 là 144 $\Rightarrow$ `10.144.0.0`.
  * Broadcast: octet $2 = 144 + 8 - 1 = 151$, các octet sau là 255 $\Rightarrow$ `10.151.255.255`.
* **Đáp án đúng:** **A (`10.144.0.0 và 10.151.255.255`)**.

---

### Câu 21
**Đề bài:** Theo chuẩn RFC 1918, dải địa chỉ IP nào sau đây KHÔNG PHẢI là địa chỉ mạng riêng (Private IP Address)?  
A. `10.20.30.40`  
B. `172.25.100.1`  
C. `172.32.10.5`  
D. `192.168.1.1`  

* **Lời giải:**
  * Ba dải Private IP theo RFC 1918:
    1. `10.0.0.0` – `10.255.255.255`
    2. `172.16.0.0` – `172.31.255.255`
    3. `192.168.0.0` – `192.168.255.255`
  * `172.32.10.5` có octet 2 là 32, vượt ngoài dải 16–31 nên là địa chỉ Public Internet.
* **Đáp án đúng:** **C (`172.32.10.5`)**.

---

### Câu 22
**Đề bài:** Khi một máy tính cấu hình nhận IP động từ DHCP server nhưng không nhận được phản hồi, hệ điều hành tự gán địa chỉ IP dạng APIPA. Dải địa chỉ APIPA có dạng nào?  
A. `127.0.0.0/8`  
B. `169.254.0.0/16`  
C. `192.168.0.0/16`  
D. `10.0.0.0/8`  

* **Lời giải:**
  * Chuẩn IETF và hệ điều hành quy định dải địa chỉ APIPA (Automatic Private IP Addressing) là `169.254.0.0/16` (từ `169.254.0.1` đến `169.254.255.254`).
* **Đáp án đúng:** **B (`169.254.0.0/16`)**.

---

### Câu 23
**Đề bài:** Cần thiết lập đường truyền Point-to-Point giữa 2 Router kết nối trực tiếp. Subnet mask tiết kiệm địa chỉ IP nhất có thể sử dụng là:  
A. `255.255.255.248` (/29)  
B. `255.255.255.252` (/30)  
C. `255.255.255.254` (/31)  
D. `255.255.255.240` (/28)  

* **Lời giải:**
  * Đường Point-to-Point chỉ cần đúng 2 địa chỉ IP cho 2 đầu router.
  * $2^h - 2 \ge 2 \Rightarrow h = 2$ bit $\Rightarrow$ Prefix $= 32 - 2 = /30$.
  * Subnet mask: `255.255.255.252`.
  * Mỗi subnet $/30$ có đúng 4 IP: 1 NetID, 2 Host, 1 Broadcast (không lãng phí bất kỳ IP nào).
* **Đáp án đúng:** **B (`255.255.255.252 (/30)`)**.

---

### Câu 24
**Đề bài:** Một router nhận được một gói tin có địa chỉ IP đích là `192.168.5.138`. Bảng định tuyến có các mục sau: (1) `192.168.5.0/24`, (2) `192.168.5.128/26`, (3) `192.168.5.128/25`. Theo nguyên tắc Longest Prefix Match, router sẽ chuyển tiếp gói tin theo mục nào?  
A. Mục (1) `192.168.5.0/24`  
B. Mục (2) `192.168.5.128/26`  
C. Mục (3) `192.168.5.128/25`  
D. Bỏ gói tin vì xung đột mục định tuyến  

* **Lời giải:**
  * Kiểm tra xem IP `192.168.5.138` có khớp với các mục định tuyến không:
    * `/24`: dải 0–255 $\rightarrow$ khớp.
    * `/25`: dải 128–255 $\rightarrow$ khớp.
    * `/26`: bước nhảy 64, dải 128–191 $\rightarrow$ khớp (138 nằm trong khoảng 128–191).
  * Cả 3 mục đều khớp. Theo nguyên tắc **Longest Prefix Match** (khớp tiền tố dài nhất), mục có prefix dài nhất (/26 > /25 > /24) có độ chính xác cao nhất và được router chọn.
* **Đáp án đúng:** **B (Mục (2) `192.168.5.128/26`)**.

---

### Câu 25
**Đề bài:** Subnet mask nào sau đây là KHÔNG hợp lệ trong kiến trúc định tuyến IPv4?  
A. `255.255.255.0`  
B. `255.255.240.128`  
C. `255.255.254.0`  
D. `255.240.0.0`  

* **Lời giải:**
  * Quy tắc bất biến của Subnet Mask: Các bit 1 phải liên tục từ trái qua phải, sau bit 0 đầu tiên thì tuyệt đối không được xuất hiện thêm bất kỳ bit 1 nào.
  * Xét `255.255.240.128`:
    * Octet 3: $240 = 1111 0000_2$ (đã xuất hiện 4 bit 0).
    * Octet 4: $128 = 1000 0000_2$ (lại xuất hiện bit 1 sau các bit 0 $\Rightarrow$ **Vi phạm quy tắc**).
  * $\Rightarrow$ `255.255.240.128` là Subnet Mask không hợp lệ.
* **Đáp án đúng:** **B (`255.255.240.128`)**.
