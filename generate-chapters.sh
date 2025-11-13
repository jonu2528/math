#!/bin/bash

# Function สร้าง chapter file
generate_chapter() {
    local grade=$1
    local ch_num=$2
    local title=$3
    local subtitle=$4
    local topics=$5
    
    local filepath="m${grade}/chapter${ch_num}.html"
    
    # แยก topics
    IFS='|' read -ra TOPIC_LIST <<< "$topics"
    
    # สร้างไฟล์
    cat > "$filepath" << 'HTMLEOF'
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>บทที่ CH_NUM: TITLE - คณิตศาสตร์ ม.GRADE</title>
    <link rel="stylesheet" href="../css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <!-- MathJax Configuration -->
    <script>
        MathJax = {
            tex: {
                inlineMath: [['$', '$'], ['\\(', '\\)']],
                displayMath: [['$$', '$$'], ['\\[', '\\]']]
            }
        };
    </script>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
    <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="../index.html" class="logo">คณิตศาสตร์มัธยม</a>
            <ul class="nav-menu">
                <li><a href="../index.html">หน้าแรก</a></li>
                <li><a href="../m1.html">ม.1</a></li>
                <li><a href="../m2.html">ม.2</a></li>
                <li><a href="../m3.html">ม.3</a></li>
                <li><a href="../m4.html">ม.4</a></li>
                <li><a href="../m5.html">ม.5</a></li>
                <li><a href="../m6.html">ม.6</a></li>
            </ul>
            <div class="hamburger">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </nav>

    <!-- Chapter Content -->
    <div class="content-wrapper">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <a href="../index.html">หน้าแรก</a> &gt; 
            <a href="../mGRADE.html">ม.GRADE</a> &gt; 
            <span>บทที่ CH_NUM</span>
        </div>

        <article class="chapter-content">
            <h1>บทที่ CH_NUM: TITLE</h1>
            
            <div class="chapter-intro">
                <p>INTRO_TEXT</p>
            </div>

            <!-- Section Navigation -->
            <div class="section-nav">
                <h3>สารบัญ</h3>
                <ul>
SECTION_NAV
                    <li><a href="#exercises">แบบฝึกหัด</a></li>
                </ul>
            </div>

SECTIONS_CONTENT

            <!-- Exercises -->
            <section id="exercises">
                <h2>แบบฝึกหัดบทที่ CH_NUM</h2>
                
EXERCISES_CONTENT
            </section>

            <!-- Chapter Navigation -->
            <div class="chapter-nav">
PREV_NEXT_NAV
            </div>
        </article>

        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="ad-space" data-ad-position="sidebarTop"></div>
            
            <div class="related-topics">
                <h3>บทเรียนที่เกี่ยวข้อง</h3>
                <ul>
RELATED_LINKS
                </ul>
            </div>
            
            <div class="ad-space" data-ad-position="sidebarMiddle"></div>
        </aside>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h4>เกี่ยวกับเรา</h4>
                <p>เว็บไซต์ให้ความรู้คณิตศาสตร์ระดับมัธยมศึกษา</p>
            </div>
            <div class="footer-section">
                <h4>หมวดหมู่</h4>
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
                <h4>ติดต่อเรา</h4>
                <p>อีเมล: info@mathlearning.com</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 คณิตศาสตร์มัธยม. All rights reserved.</p>
        </div>
    </footer>

    <script src="../js/script.js"></script>
    <script src="../js/adsense-config.js"></script>
    <script src="../js/adsense-loader.js"></script>
</body>
</html>
HTMLEOF

    # Replace placeholders
    sed -i "s/GRADE/${grade}/g" "$filepath"
    sed -i "s/CH_NUM/${ch_num}/g" "$filepath"
    sed -i "s/TITLE/${title}/g" "$filepath"
    
    # สร้าง Section Navigation
    local section_nav=""
    local sec_num=1
    for topic in "${TOPIC_LIST[@]}"; do
        section_nav+="                    <li><a href=\"#section${sec_num}\">${topic}</a></li>\n"
        ((sec_num++))
    done
    echo -e "$section_nav" > /tmp/section_nav.txt
    sed -i "/SECTION_NAV/r /tmp/section_nav.txt" "$filepath"
    sed -i "/SECTION_NAV/d" "$filepath"
    
    # สร้าง Sections Content
    local sections_html=""
    sec_num=1
    for topic in "${TOPIC_LIST[@]}"; do
        sections_html+="            <!-- Section ${ch_num}.${sec_num} -->\n"
        sections_html+="            <section id=\"section${sec_num}\">\n"
        sections_html+="                <h2>${topic}</h2>\n"
        sections_html+="                \n"
        sections_html+="                <div class=\"definition\">\n"
        sections_html+="                    <h4>ความหมาย</h4>\n"
        sections_html+="                    <p>เนื้อหาในหัวข้อนี้จะอธิบายเกี่ยวกับ ${topic}</p>\n"
        sections_html+="                </div>\n\n"
        sections_html+="                <div class=\"example\">\n"
        sections_html+="                    <h4>ตัวอย่างที่ $((sec_num * 2 - 1))</h4>\n"
        sections_html+="                    <p><strong>โจทย์:</strong> ตัวอย่างเกี่ยวกับ ${topic}</p>\n"
        sections_html+="                    <p><strong>วิธีทำ:</strong></p>\n"
        sections_html+="                    <p>\$\$\\text{สูตร} = a + b\$\$</p>\n"
        sections_html+="                </div>\n\n"
        sections_html+="                <div class=\"example\">\n"
        sections_html+="                    <h4>ตัวอย่างที่ $((sec_num * 2))</h4>\n"
        sections_html+="                    <p><strong>โจทย์:</strong> อีกตัวอย่างหนึ่งเกี่ยวกับ ${topic}</p>\n"
        sections_html+="                    <p><strong>วิธีทำ:</strong></p>\n"
        sections_html+="                    <p>\$\$\\text{ผลลัพธ์} = c \\times d\$\$</p>\n"
        sections_html+="                </div>\n\n"
        sections_html+="                <a href=\"#\" class=\"back-to-section\">↑ กลับไปด้านบน</a>\n"
        sections_html+="            </section>\n\n"
        ((sec_num++))
    done
    echo -e "$sections_html" > /tmp/sections.txt
    sed -i "/SECTIONS_CONTENT/r /tmp/sections.txt" "$filepath"
    sed -i "/SECTIONS_CONTENT/d" "$filepath"
    
    # สร้าง Exercises
    local exercises_html=""
    for i in {1..5}; do
        local q1=$((i*2-1))
        local q2=$((i*2))
        exercises_html+="                <div class=\"exercise-section\">\n"
        exercises_html+="                    <h3>ส่วนที่ ${i} (2 คะแนน)</h3>\n"
        exercises_html+="                    <ol start=\"${q1}\">\n"
        exercises_html+="                        <li>โจทย์ข้อที่ ${q1}</li>\n"
        exercises_html+="                        <li>โจทย์ข้อที่ ${q2}</li>\n"
        exercises_html+="                    </ol>\n"
        exercises_html+="                    <button class=\"toggle-answer\" onclick=\"toggleAnswer('answer${i}')\">แสดง/ซ่อนเฉลย</button>\n"
        exercises_html+="                    <div id=\"answer${i}\" class=\"answer\" style=\"display: none;\">\n"
        exercises_html+="                        <h4>เฉลย ส่วนที่ ${i}:</h4>\n"
        exercises_html+="                        <p><strong>${q1}.</strong> เฉลยข้อที่ ${q1}</p>\n"
        exercises_html+="                        <p><strong>${q2}.</strong> เฉลยข้อที่ ${q2}</p>\n"
        exercises_html+="                    </div>\n"
        exercises_html+="                </div>\n\n"
    done
    echo -e "$exercises_html" > /tmp/exercises.txt
    sed -i "/EXERCISES_CONTENT/r /tmp/exercises.txt" "$filepath"
    sed -i "/EXERCISES_CONTENT/d" "$filepath"
    
    # สร้าง Prev/Next navigation
    local prev_next=""
    if [ "$ch_num" -gt 1 ]; then
        local prev_ch=$((ch_num - 1))
        prev_next+="                <a href=\"chapter${prev_ch}.html\" class=\"prev-chapter\">← บทที่ ${prev_ch}</a>\n"
    fi
    if [ "$ch_num" -lt 6 ]; then
        local next_ch=$((ch_num + 1))
        prev_next+="                <a href=\"chapter${next_ch}.html\" class=\"next-chapter\">บทที่ ${next_ch} →</a>\n"
    else
        prev_next+="                <a href=\"../m${grade}.html\" class=\"next-chapter\">กลับสู่หน้า ม.${grade} →</a>\n"
    fi
    echo -e "$prev_next" > /tmp/prev_next.txt
    sed -i "/PREV_NEXT_NAV/r /tmp/prev_next.txt" "$filepath"
    sed -i "/PREV_NEXT_NAV/d" "$filepath"
    
    # สร้าง Related Links
    local related=""
    for j in {1..6}; do
        if [ "$j" -ne "$ch_num" ]; then
            related+="                    <li><a href=\"chapter${j}.html\">บทที่ ${j}</a></li>\n"
        fi
    done
    echo -e "$related" > /tmp/related.txt
    sed -i "/RELATED_LINKS/r /tmp/related.txt" "$filepath"
    sed -i "/RELATED_LINKS/d" "$filepath"
    
    # ใส่ intro text
    local intro="บทนี้จะเรียนรู้เกี่ยวกับ ${title} ซึ่งเป็นเนื้อหาสำคัญในคณิตศาสตร์ ม.${grade}"
    sed -i "s|INTRO_TEXT|${intro}|g" "$filepath"
    
    echo "  ✅ Created ${filepath}"
}

# สร้างทุกบททุกชั้น
echo "🚀 Generating all chapters..."

# ข้อมูลบทเรียน (ตามที่กำหนดใน create-toc-pages.sh)
# ม.2
echo "📘 Creating M.2 chapters..."
generate_chapter 2 1 "จำนวนตรรกยะ" "Rational Numbers" "1.1 ความหมายของจำนวนตรรกยะ|1.2 การเปรียบเทียบจำนวนตรรกยะ|1.3 การบวกลบจำนวนตรรกยะ|1.4 การคูณหารจำนวนตรรกยะ|1.5 การดำเนินการผสม|1.6 โจทย์ปัญหา"
generate_chapter 2 2 "เลขยกกำลัง" "Exponents" "2.1 ความหมายของเลขยกกำลัง|2.2 กฎการคูณและหารเลขยกกำลัง|2.3 เลขยกกำลังที่เป็นศูนย์และลบ|2.4 รากที่สอง|2.5 การประมาณค่า|2.6 โจทย์ปัญหา"
generate_chapter 2 3 "พหุนาม" "Polynomials" "3.1 นิพจน์พีชคณิต|3.2 การบวกลบพหุนาม|3.3 การคูณพหุนาม|3.4 การแยกตัวประกอบ|3.5 ห.ร.ม. และ ค.ร.น. ของพหุนาม|3.6 การหารพหุนาม"
generate_chapter 2 4 "สมการและอสมการ" "Equations" "4.1 สมการเชิงเส้นตัวแปรเดียว|4.2 การแก้โจทย์ปัญหา|4.3 อสมการเชิงเส้น|4.4 สมการที่มีวงเล็บ|4.5 สมการเศษส่วน|4.6 ประยุกต์สมการ"
generate_chapter 2 5 "เรขาคณิต" "Geometry" "5.1 เส้นขนานและมุม|5.2 รูปสามเหลี่ยมและมุม|5.3 รูปสี่เหลี่ยม|5.4 พื้นที่รูปหลายเหลี่ยม|5.5 ทฤษฎีบทพีทาโกรัส|5.6 ปริมาตร"
generate_chapter 2 6 "ข้อมูลและกราฟ" "Data" "6.1 การเก็บรวบรวมข้อมูล|6.2 ตารางแจกแจงความถี่|6.3 กราฟแท่งและกราฟเส้น|6.4 กราฟวงกลม|6.5 ค่ากลาง|6.6 การแปลความหมายข้อมูล"

# ม.3
echo "📗 Creating M.3 chapters..."
generate_chapter 3 1 "จำนวนจริง" "Real Numbers" "1.1 ความหมายของจำนวนจริง|1.2 จำนวนอตรรกยะ|1.3 การดำเนินการจำนวนจริง|1.4 รากที่สามและรากที่ n|1.5 เลขยกกำลังเศษส่วน|1.6 การประมาณค่า"
generate_chapter 3 2 "พหุนามและสมการ" "Polynomials" "2.1 การคูณพหุนาม|2.2 ผลคูณพิเศษ|2.3 การแยกตัวประกอบ|2.4 สมการกำลังสอง|2.5 การแก้สมการกำลังสอง|2.6 โจทย์ปัญหา"
generate_chapter 3 3 "ระบบสมการ" "Systems" "3.1 ระบบสมการเชิงเส้น|3.2 วิธีการแทนค่า|3.3 วิธีการกำจัดตัวแปร|3.4 การแก้โจทย์ปัญหา|3.5 กราฟของสมการเชิงเส้น|3.6 จุดตัดของกราฟ"
generate_chapter 3 4 "ฟังก์ชัน" "Functions" "4.1 ความหมายของฟังก์ชัน|4.2 กราฟของฟังก์ชัน|4.3 ฟังก์ชันเชิงเส้น|4.4 ความชัน|4.5 สมการเส้นตรง|4.6 การประยุกต์"
generate_chapter 3 5 "เรขาคณิต" "Geometry" "5.1 สามเหลี่ยมคล้าย|5.2 อัตราส่วนและสัดส่วน|5.3 ทฤษฎีบทวงกลม|5.4 พื้นที่ผิวและปริมาตร|5.5 การแปลง|5.6 ความสมมาตร"
generate_chapter 3 6 "สถิติและความน่าจะเป็น" "Statistics" "6.1 การนำเสนอข้อมูล|6.2 การกระจายของข้อมูล|6.3 ส่วนเบี่ยงเบนมาตรฐาน|6.4 ความน่าจะเป็น|6.5 เหตุการณ์ร่วม|6.6 การทดลองและตัวอย่าง"

# ม.4  
echo "📙 Creating M.4 chapters..."
generate_chapter 4 1 "เซตและตรรกศาสตร์" "Sets" "1.1 ความหมายของเซต|1.2 การดำเนินการของเซต|1.3 กฎของเซต|1.4 ประพจน์|1.5 ตารางค่าความจริง|1.6 การให้เหตุผล"
generate_chapter 4 2 "ฟังก์ชันและกราฟ" "Functions" "2.1 ฟังก์ชันและความสัมพันธ์|2.2 ประเภทของฟังก์ชัน|2.3 กราฟฟังก์ชัน|2.4 ฟังก์ชันกำลังสอง|2.5 ฟังก์ชันค่าสัมบูรณ์|2.6 การแปลงกราฟ"
generate_chapter 4 3 "พหุนาม" "Polynomials" "3.1 พหุนามดีกรีสูง|3.2 ทฤษฎีบทเศษเหลือ|3.3 สมการพหุนาม|3.4 อสมการ|3.5 ความไม่เท่า|3.6 โจทย์ปัญหา"
generate_chapter 4 4 "ลำดับและอนุกรม" "Sequences" "4.1 ลำดับ|4.2 อนุกรม|4.3 ลำดับเลขคณิต|4.4 อนุกรมเลขคณิต|4.5 ลำดับเรขาคณิต|4.6 อนุกรมเรขาคณิต"
generate_chapter 4 5 "เรขาคณิตวิเคราะห์" "Geometry" "5.1 ระบบพิกัด|5.2 ระยะทางระหว่างจุด|5.3 จุดกึ่งกลาง|5.4 สมการเส้นตรง|5.5 เส้นขนานและเส้นตั้งฉาก|5.6 วงกลม"
generate_chapter 4 6 "ตรีโกณมิติ" "Trigonometry" "6.1 อัตราส่วนตรีโกณมิติ|6.2 การหาค่าอัตราส่วน|6.3 การแก้สามเหลี่ยมมุมฉาก|6.4 มุมในตำแหน่งมาตรฐาน|6.5 กราฟฟังก์ชันตรีโกณมิติ|6.6 เอกลักษณ์ตรีโกณมิติ"

# ม.5
echo "📕 Creating M.5 chapters..."
generate_chapter 5 1 "ตรีโกณมิติ" "Trigonometry" "1.1 ฟังก์ชันตรีโกณมิติ|1.2 เอกลักษณ์ตรีโกณมิติ|1.3 สมการตรีโกณมิติ|1.4 กฎของไซน์|1.5 กฎของโคไซน์|1.6 การแก้สามเหลี่ยม"
generate_chapter 5 2 "เมทริกซ์" "Matrices" "2.1 ความหมายของเมทริกซ์|2.2 การบวกลบเมทริกซ์|2.3 การคูณเมทริกซ์|2.4 เมทริกซ์ผกผัน|2.5 ดีเทอร์มิแนนต์|2.6 การแก้ระบบสมการ"
generate_chapter 5 3 "เวกเตอร์" "Vectors" "3.1 ความหมายของเวกเตอร์|3.2 การบวกลบเวกเตอร์|3.3 ผลคูณสเกลาร์|3.4 ผลคูณจุด|3.5 ผลคูณไขว้|3.6 การประยุกต์เวกเตอร์"
generate_chapter 5 4 "การนับและความน่าจะเป็น" "Probability" "4.1 หลักการนับ|4.2 การเรียงสับเปลี่ยน|4.3 การจัดหมู่|4.4 ความน่าจะเป็นเบื้องต้น|4.5 ทฤษฎีบทความน่าจะเป็น|4.6 ความน่าจะเป็นแบบมีเงื่อนไข"
generate_chapter 5 5 "ลิมิตและความต่อเนื่อง" "Limits" "5.1 ลิมิตของฟังก์ชัน|5.2 กฎการหาลิมิต|5.3 ลิมิตที่อนันต์|5.4 ลิมิตเมื่อ x เข้าใกล้อนันต์|5.5 ความต่อเนื่อง|5.6 ทฤษฎีบทค่ากลาง"
generate_chapter 5 6 "อนุพันธ์" "Derivatives" "6.1 ความหมายของอนุพันธ์|6.2 กฎการหาอนุพันธ์|6.3 กฎลูกโซ่|6.4 อนุพันธ์อันดับสูง|6.5 การประยุกต์อนุพันธ์|6.6 ปัญหาค่าสูงสุดต่ำสุด"

# ม.6
echo "📓 Creating M.6 chapters..."
generate_chapter 6 1 "อนุพันธ์ขั้นสูง" "Derivatives" "1.1 อนุพันธ์ของฟังก์ชันตรีโกณมิติ|1.2 อนุพันธ์ของฟังก์ชันเอกซ์โพเนนเชียล|1.3 อนุพันธ์ของฟังก์ชันลอการิทึม|1.4 การหาอนุพันธ์โดยนัย|1.5 อัตราการเปลี่ยนแปลง|1.6 การประมาณค่า"
generate_chapter 6 2 "ปริพันธ์" "Integration" "2.1 ปริพันธ์ไม่จำกัดเขต|2.2 กฎการหาปริพันธ์|2.3 เทคนิคการหาปริพันธ์|2.4 ปริพันธ์จำกัดเขต|2.5 ทฤษฎีบทพื้นฐานของแคลคูลัส|2.6 การหาพื้นที่"
generate_chapter 6 3 "สมการเชิงอนุพันธ์" "Differential" "3.1 ความหมายของสมการเชิงอนุพันธ์|3.2 สมการอันดับหนึ่ง|3.3 การแยกตัวแปร|3.4 สมการเชิงเส้นอันดับหนึ่ง|3.5 สมการอันดับสอง|3.6 การประยุกต์"
generate_chapter 6 4 "จำนวนเชิงซ้อน" "Complex" "4.1 ความหมายของจำนวนเชิงซ้อน|4.2 การดำเนินการจำนวนเชิงซ้อน|4.3 รูปเรขาคณิต|4.4 รูปเชิงขั้ว|4.5 ทฤษฎีบทเดอมัวฟร์|4.6 รากที่ n"
generate_chapter 6 5 "สถิติประยุกต์" "Statistics" "5.1 การสุ่มตัวอย่าง|5.2 การแจกแจงความน่าจะเป็น|5.3 การแจกแจงปกติ|5.4 การประมาณค่า|5.5 การทดสอบสมมติฐาน|5.6 การวิเคราะห์การถดถอย"
generate_chapter 6 6 "เรขาคณิตวิเคราะห์" "Conics" "6.1 พาราโบลา|6.2 วงรี|6.3 ไฮเพอร์โบลา|6.4 สมการทั่วไปของคอนิก|6.5 การแปลงพิกัด|6.6 การประยุกต์"

echo "✅ All chapters generated successfully!"
echo "📊 Summary:"
echo "  - M.2: 6 chapters"
echo "  - M.3: 6 chapters"
echo "  - M.4: 6 chapters"
echo "  - M.5: 6 chapters"
echo "  - M.6: 6 chapters"
echo "  Total: 30 chapter files created"
