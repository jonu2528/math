#!/bin/bash

# Function สร้าง chapter file ที่แก้ไขแล้ว
generate_chapter_fixed() {
    local grade=$1
    local ch_num=$2
    local title=$3
    local subtitle=$4
    local topics=$5
    
    local filepath="m${grade}/chapter${ch_num}.html"
    
    # แยก topics
    IFS='|' read -ra TOPIC_LIST <<< "$topics"
    
    # สร้าง active class สำหรับ nav
    local nav_m1=""
    local nav_m2=""
    local nav_m3=""
    local nav_m4=""
    local nav_m5=""
    local nav_m6=""
    
    case $grade in
        1) nav_m1=' class="active"' ;;
        2) nav_m2=' class="active"' ;;
        3) nav_m3=' class="active"' ;;
        4) nav_m4=' class="active"' ;;
        5) nav_m5=' class="active"' ;;
        6) nav_m6=' class="active"' ;;
    esac
    
    # สร้างไฟล์
    cat > "$filepath" << HTMLEOF
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="บทที่ ${ch_num}: ${title} - คณิตศาสตร์ ม.${grade}">
    <title>บทที่ ${ch_num}: ${title} | คณิตศาสตร์ ม.${grade}</title>
    <link rel="stylesheet" href="../css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <!-- MathJax Configuration -->
    <script>
        MathJax = {
            tex: {
                inlineMath: [['\$', '\$'], ['\\\\(', '\\\\)']],
                displayMath: [['\$\$', '\$\$'], ['\\\\[', '\\\\]']]
            }
        };
    </script>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
    <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
</head>
<body>
    <header>
        <div class="container">
            <div class="logo">
                <h1>📐 คณิตศาสตร์มัธยม</h1>
                <p class="tagline">เรียนรู้คณิตศาสตร์ ม.1-6 อย่างละเอียดและเข้าใจง่าย</p>
            </div>
            <nav class="main-nav">
                <button class="mobile-menu-toggle">☰</button>
                <ul class="nav-menu">
                    <li><a href="../index.html">หน้าแรก</a></li>
                    <li><a href="../m1.html"${nav_m1}>ม.1</a></li>
                    <li><a href="../m2.html"${nav_m2}>ม.2</a></li>
                    <li><a href="../m3.html"${nav_m3}>ม.3</a></li>
                    <li><a href="../m4.html"${nav_m4}>ม.4</a></li>
                    <li><a href="../m5.html"${nav_m5}>ม.5</a></li>
                    <li><a href="../m6.html"${nav_m6}>ม.6</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="ad-container ad-top" data-ad-position="topBanner"></div>

    <div class="container">
        <div class="breadcrumb">
            <a href="../index.html">หน้าแรก</a>
            <span>›</span>
            <a href="../m${grade}.html">ม.${grade}</a>
            <span>›</span>
            <span>บทที่ ${ch_num}: ${title}</span>
        </div>
    </div>

    <main class="container">
        <div class="content-wrapper">
            <aside class="sidebar-left">
                <div class="ad-space" data-ad-position="sidebarTop"></div>
            </aside>

            <section class="main-content">
                <h1>บทที่ ${ch_num}: ${title}</h1>
                
                <div class="chapter-intro">
                    <p>บทนี้จะเรียนรู้เกี่ยวกับ ${title} ซึ่งเป็นเนื้อหาสำคัญในคณิตศาสตร์ ม.${grade}</p>
                </div>

                <!-- Section Navigation -->
                <div class="section-nav">
                    <h3>สารบัญ</h3>
                    <ul>
HTMLEOF

    # เพิ่ม section navigation
    local sec_num=1
    for topic in "${TOPIC_LIST[@]}"; do
        echo "                        <li><a href=\"#section${sec_num}\">${topic}</a></li>" >> "$filepath"
        ((sec_num++))
    done
    
    cat >> "$filepath" << 'HTMLEOF2'
                        <li><a href="#exercises">แบบฝึกหัด</a></li>
                    </ul>
                </div>

HTMLEOF2

    # สร้าง Sections Content
    sec_num=1
    for topic in "${TOPIC_LIST[@]}"; do
        cat >> "$filepath" << SECTIONEOF
                <!-- Section ${ch_num}.${sec_num} -->
                <section id="section${sec_num}">
                    <h2>${topic}</h2>
                    
                    <div class="definition">
                        <h4>ความหมาย</h4>
                        <p>เนื้อหาในหัวข้อนี้จะอธิบายเกี่ยวกับ ${topic}</p>
                    </div>

                    <div class="example">
                        <h4>ตัวอย่างที่ $((sec_num * 2 - 1))</h4>
                        <p><strong>โจทย์:</strong> ตัวอย่างเกี่ยวกับ ${topic}</p>
                        <p><strong>วิธีทำ:</strong></p>
                        <p>\$\$\\text{สูตร} = a + b\$\$</p>
                    </div>

                    <div class="example">
                        <h4>ตัวอย่างที่ $((sec_num * 2))</h4>
                        <p><strong>โจทย์:</strong> อีกตัวอย่างหนึ่งเกี่ยวกับ ${topic}</p>
                        <p><strong>วิธีทำ:</strong></p>
                        <p>\$\$\\text{ผลลัพธ์} = c \\times d\$\$</p>
                    </div>

                    <a href="#" class="back-to-section">↑ กลับไปด้านบน</a>
                </section>

SECTIONEOF
        ((sec_num++))
    done
    
    # เพิ่ม Exercises
    cat >> "$filepath" << 'EXEOF'
                <!-- Exercises -->
                <section id="exercises">
                    <h2>แบบฝึกหัดบทที่ CHNUM</h2>
                    
EXEOF
    
    sed -i "s/CHNUM/${ch_num}/g" "$filepath"
    
    # สร้าง Exercises
    for i in {1..5}; do
        local q1=$((i*2-1))
        local q2=$((i*2))
        cat >> "$filepath" << EXEOF2
                    <div class="exercise-section">
                        <h3>ส่วนที่ ${i} (2 คะแนน)</h3>
                        <ol start="${q1}">
                            <li>โจทย์ข้อที่ ${q1}</li>
                            <li>โจทย์ข้อที่ ${q2}</li>
                        </ol>
                        <button class="toggle-answer" onclick="toggleAnswer('answer${i}')">แสดง/ซ่อนเฉลย</button>
                        <div id="answer${i}" class="answer" style="display: none;">
                            <h4>เฉลย ส่วนที่ ${i}:</h4>
                            <p><strong>${q1}.</strong> เฉลยข้อที่ ${q1}</p>
                            <p><strong>${q2}.</strong> เฉลยข้อที่ ${q2}</p>
                        </div>
                    </div>

EXEOF2
    done
    
    cat >> "$filepath" << 'EXEOF3'
                </section>

                <!-- Chapter Navigation -->
                <div class="chapter-nav">
EXEOF3

    # สร้าง Prev/Next navigation
    if [ "$ch_num" -gt 1 ]; then
        local prev_ch=$((ch_num - 1))
        echo "                    <a href=\"chapter${prev_ch}.html\" class=\"prev-chapter\">← บทที่ ${prev_ch}</a>" >> "$filepath"
    fi
    if [ "$ch_num" -lt 6 ]; then
        local next_ch=$((ch_num + 1))
        echo "                    <a href=\"chapter${next_ch}.html\" class=\"next-chapter\">บทที่ ${next_ch} →</a>" >> "$filepath"
    else
        echo "                    <a href=\"../m${grade}.html\" class=\"next-chapter\">กลับสู่หน้า ม.${grade} →</a>" >> "$filepath"
    fi
    
    cat >> "$filepath" << 'FOOTEREOF'
                </div>
            </section>

            <aside class="sidebar-right">
                <div class="ad-space" data-ad-position="sidebarMiddle"></div>
                
                <div class="related-topics">
                    <h3>บทเรียนที่เกี่ยวข้อง</h3>
                    <ul>
FOOTEREOF

    # สร้าง Related Links
    for j in {1..6}; do
        if [ "$j" -ne "$ch_num" ]; then
            echo "                        <li><a href=\"chapter${j}.html\">บทที่ ${j}</a></li>" >> "$filepath"
        fi
    done
    
    cat >> "$filepath" << 'ENDEOF'
                    </ul>
                </div>
                
                <div class="ad-space" data-ad-position="sidebarBottom"></div>
            </aside>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <div class="footer-container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>คณิตศาสตร์มัธยม</h3>
                    <p>เว็บไซต์รวมความรู้คณิตศาสตร์ ม.1-6 ครบทุกเนื้อหา</p>
                </div>
                <div class="footer-section">
                    <h3>หมวดหมู่</h3>
                    <ul>
                        <li><a href="../m1.html">ม.1</a></li>
                        <li><a href="../m2.html">ม.2</a></li>
                        <li><a href="../m3.html">ม.3</a></li>
                        <li><a href="../m4.html">ม.4</a></li>
                        <li><a href="../m5.html">ม.5</a></li>
                        <li><a href="../m6.html">ม.6</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>ติดต่อเรา</h3>
                    <p>อีเมล: info@mathlearning.com</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 คณิตศาสตร์มัธยม. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="../js/script.js"></script>
    <script src="../js/adsense-config.js"></script>
    <script src="../js/adsense-loader.js"></script>
</body>
</html>
ENDEOF
    
    echo "  ✅ Regenerated: ${filepath}"
}

echo "🚀 Regenerating chapters with fixed headers..."

# ม.2
echo "📘 Regenerating M.2 chapters..."
generate_chapter_fixed 2 1 "จำนวนตรรกยะ" "Rational Numbers" "1.1 ความหมายของจำนวนตรรกยะ|1.2 การเปรียบเทียบจำนวนตรรกยะ|1.3 การบวกลบจำนวนตรรกยะ|1.4 การคูณหารจำนวนตรรกยะ|1.5 การดำเนินการผสม|1.6 โจทย์ปัญหา"
generate_chapter_fixed 2 2 "เลขยกกำลัง" "Exponents" "2.1 ความหมายของเลขยกกำลัง|2.2 กฎการคูณและหารเลขยกกำลัง|2.3 เลขยกกำลังที่เป็นศูนย์และลบ|2.4 รากที่สอง|2.5 การประมาณค่า|2.6 โจทย์ปัญหา"
generate_chapter_fixed 2 3 "พหุนาม" "Polynomials" "3.1 นิพจน์พีชคณิต|3.2 การบวกลบพหุนาม|3.3 การคูณพหุนาม|3.4 การแยกตัวประกอบ|3.5 ห.ร.ม. และ ค.ร.น. ของพหุนาม|3.6 การหารพหุนาม"
generate_chapter_fixed 2 4 "สมการและอสมการ" "Equations" "4.1 สมการเชิงเส้นตัวแปรเดียว|4.2 การแก้โจทย์ปัญหา|4.3 อสมการเชิงเส้น|4.4 สมการที่มีวงเล็บ|4.5 สมการเศษส่วน|4.6 ประยุกต์สมการ"
generate_chapter_fixed 2 5 "เรขาคณิต" "Geometry" "5.1 เส้นขนานและมุม|5.2 รูปสามเหลี่ยมและมุม|5.3 รูปสี่เหลี่ยม|5.4 พื้นที่รูปหลายเหลี่ยม|5.5 ทฤษฎีบทพีทาโกรัส|5.6 ปริมาตร"
generate_chapter_fixed 2 6 "ข้อมูลและกราฟ" "Data" "6.1 การเก็บรวบรวมข้อมูล|6.2 ตารางแจกแจงความถี่|6.3 กราฟแท่งและกราฟเส้น|6.4 กราฟวงกลม|6.5 ค่ากลาง|6.6 การแปลความหมายข้อมูล"

# ม.3
echo "📗 Regenerating M.3 chapters..."
generate_chapter_fixed 3 1 "จำนวนจริง" "Real Numbers" "1.1 ความหมายของจำนวนจริง|1.2 จำนวนอตรรกยะ|1.3 การดำเนินการจำนวนจริง|1.4 รากที่สามและรากที่ n|1.5 เลขยกกำลังเศษส่วน|1.6 การประมาณค่า"
generate_chapter_fixed 3 2 "พหุนามและสมการ" "Polynomials" "2.1 การคูณพหุนาม|2.2 ผลคูณพิเศษ|2.3 การแยกตัวประกอบ|2.4 สมการกำลังสอง|2.5 การแก้สมการกำลังสอง|2.6 โจทย์ปัญหา"
generate_chapter_fixed 3 3 "ระบบสมการ" "Systems" "3.1 ระบบสมการเชิงเส้น|3.2 วิธีการแทนค่า|3.3 วิธีการกำจัดตัวแปร|3.4 การแก้โจทย์ปัญหา|3.5 กราฟของสมการเชิงเส้น|3.6 จุดตัดของกราฟ"
generate_chapter_fixed 3 4 "ฟังก์ชัน" "Functions" "4.1 ความหมายของฟังก์ชัน|4.2 กราฟของฟังก์ชัน|4.3 ฟังก์ชันเชิงเส้น|4.4 ความชัน|4.5 สมการเส้นตรง|4.6 การประยุกต์"
generate_chapter_fixed 3 5 "เรขาคณิต" "Geometry" "5.1 สามเหลี่ยมคล้าย|5.2 อัตราส่วนและสัดส่วน|5.3 ทฤษฎีบทวงกลม|5.4 พื้นที่ผิวและปริมาตร|5.5 การแปลง|5.6 ความสมมาตร"
generate_chapter_fixed 3 6 "สถิติและความน่าจะเป็น" "Statistics" "6.1 การนำเสนอข้อมูล|6.2 การกระจายของข้อมูล|6.3 ส่วนเบี่ยงเบนมาตรฐาน|6.4 ความน่าจะเป็น|6.5 เหตุการณ์ร่วม|6.6 การทดลองและตัวอย่าง"

# ม.4  
echo "📙 Regenerating M.4 chapters..."
generate_chapter_fixed 4 1 "เซตและตรรกศาสตร์" "Sets" "1.1 ความหมายของเซต|1.2 การดำเนินการของเซต|1.3 กฎของเซต|1.4 ประพจน์|1.5 ตารางค่าความจริง|1.6 การให้เหตุผล"
generate_chapter_fixed 4 2 "ฟังก์ชันและกราฟ" "Functions" "2.1 ฟังก์ชันและความสัมพันธ์|2.2 ประเภทของฟังก์ชัน|2.3 กราฟฟังก์ชัน|2.4 ฟังก์ชันกำลังสอง|2.5 ฟังก์ชันค่าสัมบูรณ์|2.6 การแปลงกราฟ"
generate_chapter_fixed 4 3 "พหุนาม" "Polynomials" "3.1 พหุนามดีกรีสูง|3.2 ทฤษฎีบทเศษเหลือ|3.3 สมการพหุนาม|3.4 อสมการ|3.5 ความไม่เท่า|3.6 โจทย์ปัญหา"
generate_chapter_fixed 4 4 "ลำดับและอนุกรม" "Sequences" "4.1 ลำดับ|4.2 อนุกรม|4.3 ลำดับเลขคณิต|4.4 อนุกรมเลขคณิต|4.5 ลำดับเรขาคณิต|4.6 อนุกรมเรขาคณิต"
generate_chapter_fixed 4 5 "เรขาคณิตวิเคราะห์" "Geometry" "5.1 ระบบพิกัด|5.2 ระยะทางระหว่างจุด|5.3 จุดกึ่งกลาง|5.4 สมการเส้นตรง|5.5 เส้นขนานและเส้นตั้งฉาก|5.6 วงกลม"
generate_chapter_fixed 4 6 "ตรีโกณมิติ" "Trigonometry" "6.1 อัตราส่วนตรีโกณมิติ|6.2 การหาค่าอัตราส่วน|6.3 การแก้สามเหลี่ยมมุมฉาก|6.4 มุมในตำแหน่งมาตรฐาน|6.5 กราฟฟังก์ชันตรีโกณมิติ|6.6 เอกลักษณ์ตรีโกณมิติ"

# ม.5
echo "📕 Regenerating M.5 chapters..."
generate_chapter_fixed 5 1 "ตรีโกณมิติ" "Trigonometry" "1.1 ฟังก์ชันตรีโกณมิติ|1.2 เอกลักษณ์ตรีโกณมิติ|1.3 สมการตรีโกณมิติ|1.4 กฎของไซน์|1.5 กฎของโคไซน์|1.6 การแก้สามเหลี่ยม"
generate_chapter_fixed 5 2 "เมทริกซ์" "Matrices" "2.1 ความหมายของเมทริกซ์|2.2 การบวกลบเมทริกซ์|2.3 การคูณเมทริกซ์|2.4 เมทริกซ์ผกผัน|2.5 ดีเทอร์มิแนนต์|2.6 การแก้ระบบสมการ"
generate_chapter_fixed 5 3 "เวกเตอร์" "Vectors" "3.1 ความหมายของเวกเตอร์|3.2 การบวกลบเวกเตอร์|3.3 ผลคูณสเกลาร์|3.4 ผลคูณจุด|3.5 ผลคูณไขว้|3.6 การประยุกต์เวกเตอร์"
generate_chapter_fixed 5 4 "การนับและความน่าจะเป็น" "Probability" "4.1 หลักการนับ|4.2 การเรียงสับเปลี่ยน|4.3 การจัดหมู่|4.4 ความน่าจะเป็นเบื้องต้น|4.5 ทฤษฎีบทความน่าจะเป็น|4.6 ความน่าจะเป็นแบบมีเงื่อนไข"
generate_chapter_fixed 5 5 "ลิมิตและความต่อเนื่อง" "Limits" "5.1 ลิมิตของฟังก์ชัน|5.2 กฎการหาลิมิต|5.3 ลิมิตที่อนันต์|5.4 ลิมิตเมื่อ x เข้าใกล้อนันต์|5.5 ความต่อเนื่อง|5.6 ทฤษฎีบทค่ากลาง"
generate_chapter_fixed 5 6 "อนุพันธ์" "Derivatives" "6.1 ความหมายของอนุพันธ์|6.2 กฎการหาอนุพันธ์|6.3 กฎลูกโซ่|6.4 อนุพันธ์อันดับสูง|6.5 การประยุกต์อนุพันธ์|6.6 ปัญหาค่าสูงสุดต่ำสุด"

# ม.6
echo "📓 Regenerating M.6 chapters..."
generate_chapter_fixed 6 1 "อนุพันธ์ขั้นสูง" "Derivatives" "1.1 อนุพันธ์ของฟังก์ชันตรีโกณมิติ|1.2 อนุพันธ์ของฟังก์ชันเอกซ์โพเนนเชียล|1.3 อนุพันธ์ของฟังก์ชันลอการิทึม|1.4 การหาอนุพันธ์โดยนัย|1.5 อัตราการเปลี่ยนแปลง|1.6 การประมาณค่า"
generate_chapter_fixed 6 2 "ปริพันธ์" "Integration" "2.1 ปริพันธ์ไม่จำกัดเขต|2.2 กฎการหาปริพันธ์|2.3 เทคนิคการหาปริพันธ์|2.4 ปริพันธ์จำกัดเขต|2.5 ทฤษฎีบทพื้นฐานของแคลคูลัส|2.6 การหาพื้นที่"
generate_chapter_fixed 6 3 "สมการเชิงอนุพันธ์" "Differential" "3.1 ความหมายของสมการเชิงอนุพันธ์|3.2 สมการอันดับหนึ่ง|3.3 การแยกตัวแปร|3.4 สมการเชิงเส้นอันดับหนึ่ง|3.5 สมการอันดับสอง|3.6 การประยุกต์"
generate_chapter_fixed 6 4 "จำนวนเชิงซ้อน" "Complex" "4.1 ความหมายของจำนวนเชิงซ้อน|4.2 การดำเนินการจำนวนเชิงซ้อน|4.3 รูปเรขาคณิต|4.4 รูปเชิงขั้ว|4.5 ทฤษฎีบทเดอมัวฟร์|4.6 รากที่ n"
generate_chapter_fixed 6 5 "สถิติประยุกต์" "Statistics" "5.1 การสุ่มตัวอย่าง|5.2 การแจกแจงความน่าจะเป็น|5.3 การแจกแจงปกติ|5.4 การประมาณค่า|5.5 การทดสอบสมมติฐาน|5.6 การวิเคราะห์การถดถอย"
generate_chapter_fixed 6 6 "เรขาคณิตวิเคราะห์" "Conics" "6.1 พาราโบลา|6.2 วงรี|6.3 ไฮเพอร์โบลา|6.4 สมการทั่วไปของคอนิก|6.5 การแปลงพิกัด|6.6 การประยุกต์"

echo ""
echo "✅ All chapters regenerated successfully!"
echo "📊 Summary:"
echo "  - M.2: 6 chapters regenerated"
echo "  - M.3: 6 chapters regenerated"
echo "  - M.4: 6 chapters regenerated"
echo "  - M.5: 6 chapters regenerated"
echo "  - M.6: 6 chapters regenerated"
echo "  Total: 30 chapter files regenerated with fixed headers"
