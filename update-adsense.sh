#!/bin/bash

# Script สำหรับอัพเดตไฟล์ HTML ให้ใช้ AdSense config

echo "🔧 กำลังอัพเดตไฟล์ HTML เพื่อใช้ AdSense config..."

# Function เพื่อเพิ่ม AdSense scripts ในไฟล์ HTML
add_adsense_scripts() {
    local file=$1
    
    # ตรวจสอบว่ามี adsense-config.js อยู่แล้วหรือไม่
    if grep -q "adsense-config.js" "$file"; then
        echo "  ⏭️  $file มี AdSense config อยู่แล้ว"
        return
    fi
    
    # หาตำแหน่งที่จะแทรก scripts (ก่อน </body>)
    if grep -q "</body>" "$file"; then
        # เพิ่ม scripts ก่อน </body>
        sed -i 's|</body>|    <script src="../js/adsense-config.js"></script>\n    <script src="../js/adsense-loader.js"></script>\n</body>|g' "$file"
        
        # สำหรับไฟล์ในโฟลเดอร์หลัก ให้ใช้ path ที่ถูกต้อง
        sed -i 's|src="../js/|src="js/|g' "$file" 2>/dev/null || true
        
        echo "  ✅ อัพเดต $file สำเร็จ"
    fi
}

# อัพเดตไฟล์หลัก
echo "📄 อัพเดตไฟล์หลัก..."
for file in index.html m*.html; do
    if [ -f "$file" ]; then
        add_adsense_scripts "$file"
    fi
done

# อัพเดตไฟล์ใน m1/
echo "📁 อัพเดตไฟล์ใน m1/..."
for file in m1/*.html; do
    if [ -f "$file" ]; then
        add_adsense_scripts "$file"
    fi
done

echo "✅ เสร็จสิ้น!"
