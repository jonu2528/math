# การตั้งค่า Google AdSense

## ภาพรวม
โปรเจกต์นี้ได้แยกการตั้งค่า AdSense ออกมาเป็นไฟล์เดียว เพื่อความสะดวกในการจัดการและแก้ไข

## ไฟล์ที่เกี่ยวข้อง

### 1. `js/adsense-config.js`
ไฟล์หลักสำหรับตั้งค่า AdSense ทั้งหมด

**สิ่งที่ต้องแก้ไข:**
```javascript
// แทนที่ Client ID ของคุณ
clientId: 'ca-pub-XXXXXXXXXXXXXXXXX',

// แทนที่ Slot IDs สำหรับตำแหน่งต่างๆ
slots: {
    topBanner: {
        slot: '1234567890',  // <- แก้ตรงนี้
        ...
    },
    ...
}
```

### 2. `js/adsense-loader.js`
ไฟล์สำหรับโหลดและแสดงโฆษณา (ไม่ต้องแก้ไข)

## วิธีการตั้งค่า

### ขั้นตอนที่ 1: รับ Client ID จาก Google AdSense
1. เข้าสู่ระบบ [Google AdSense](https://www.google.com/adsense/)
2. ไปที่ เมนู **Account** → **Settings**
3. คัดลอก **Publisher ID** (รูปแบบ: ca-pub-XXXXXXXXXXXXXXXX)
4. นำไปแทนที่ใน `js/adsense-config.js` บรรทัด `clientId`

### ขั้นตอนที่ 2: สร้าง Ad Units และรับ Slot IDs
1. ไปที่ **Ads** → **Overview** → **By ad unit**
2. คลิก **New ad unit**
3. เลือกประเภทโฆษณา:
   - **Display ads** สำหรับ topBanner, sidebarTop, etc.
   - **In-article ads** สำหรับ inArticle
4. ตั้งชื่อและกำหนดขนาดตามตำแหน่ง:
   - topBanner: Horizontal (728x90 หรือ Auto)
   - sidebarTop/Bottom: Rectangle (300x250)
   - sidebarMiddle: Vertical (300x600)
5. คัดลอก **data-ad-slot** ID และนำไปแทนที่ในไฟล์ config

### ขั้นตอนที่ 3: อัพเดตไฟล์ config
แก้ไขไฟล์ `js/adsense-config.js`:

```javascript
const AdsenseConfig = {
    enabled: true,  // เปลี่ยนเป็น true เมื่อพร้อมใช้งาน
    clientId: 'ca-pub-1234567890123456',  // ใส่ Client ID ของคุณ
    slots: {
        topBanner: {
            slot: '1234567890',  // ใส่ Slot ID ของคุณ
            ...
        },
        // ...แก้ไข Slot อื่นๆ ด้วย
    }
};
```

## การใช้งานในไฟล์ HTML

### วิธีที่ 1: ใช้ data attribute (แนะนำ)
```html
<!-- เพิ่ม scripts ก่อน </body> -->
<script src="js/adsense-config.js"></script>
<script src="js/adsense-loader.js"></script>

<!-- ใช้ data-ad-position เพื่อระบุตำแหน่งโฆษณา -->
<div class="ad-space" data-ad-position="sidebarTop"></div>
<div class="ad-space" data-ad-position="sidebarMiddle"></div>
```

### วิธีที่ 2: ใส่โค้ดโฆษณาด้วยตนเอง
```html
<div class="ad-space">
    <ins class="adsbygoogle"
         style="display:block"
         data-ad-client="ca-pub-XXXXXXXXXXXXXXXXX"
         data-ad-slot="1234567890"
         data-ad-format="auto"
         data-full-width-responsive="true"></ins>
</div>
<script>
    (adsbygoogle = window.adsbygoogle || []).push({});
</script>
```

## ตำแหน่งโฆษณาที่กำหนดไว้

| ตำแหน่ง | ขนาดที่แนะนำ | คำอธิบาย |
|---------|-------------|----------|
| `topBanner` | 728x90, 320x50 | แบนเนอร์ด้านบน |
| `sidebarTop` | 300x250 | ไซด์บาร์ด้านบน |
| `sidebarMiddle` | 300x600 | ไซด์บาร์ตรงกลาง |
| `sidebarBottom` | 300x250 | ไซด์บาร์ด้านล่าง |
| `inArticle` | Responsive | โฆษณาในบทความ |
| `bottomBanner` | Auto | แบนเนอร์ท้ายหน้า |

## โหมดทดสอบ

หากตั้งค่า `enabled: false` ในไฟล์ config จะแสดง placeholder แทนโฆษณาจริง:
```javascript
const AdsenseConfig = {
    enabled: false,  // โหมดทดสอบ - แสดง placeholder
    ...
};
```

## การตรวจสอบ

1. เปิดหน้าเว็บในเบราว์เซอร์
2. กด F12 เปิด Developer Tools
3. ตรวจสอบ Console หาข้อผิดพลาด
4. ตรวจสอบ Network tab ว่ามีการโหลด `adsbygoogle.js` หรือไม่

## หมายเหตุ

- โฆษณาจะไม่แสดงทันทีในช่วงแรก Google AdSense ต้องใช้เวลาตรวจสอบเว็บไซต์
- ต้องมีเนื้อหาเพียงพอและเว็บไซต์ต้องผ่านนโยบายของ AdSense
- ไม่ควรคลิกโฆษณาของตนเอง จะถูกระงับบัญชี

## การแก้ปัญหา

### โฆษณาไม่แสดง
1. ตรวจสอบว่า `enabled: true`
2. ตรวจสอบ Client ID และ Slot ID ถูกต้อง
3. ตรวจสอบว่าเว็บไซต์ได้รับอนุมัติจาก AdSense แล้ว
4. ตรวจสอบ Console มีข้อผิดพลาดหรือไม่

### แสดง Placeholder แทนโฆษณา
- ตรวจสอบว่า `enabled: true` ในไฟล์ config
- ล้าง cache ของเบราว์เซอร์

## ติดต่อ

หากมีปัญหาหรือข้อสงสัย กรุณาตรวจสอบ:
- [Google AdSense Help Center](https://support.google.com/adsense/)
- [AdSense Community](https://support.google.com/adsense/community)
