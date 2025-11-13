#!/bin/bash

# ข้อมูลบทเรียนของแต่ละชั้น

# ม.2
declare -a M2_CHAPTERS=(
    "จำนวนตรรกยะ:Rational Numbers:1.1 ความหมายของจำนวนตรรกยะ|1.2 การเปรียบเทียบจำนวนตรรกยะ|1.3 การบวกลบจำนวนตรรกยะ|1.4 การคูณหารจำนวนตรรกยะ|1.5 การดำเนินการผสม|1.6 โจทย์ปัญหา"
    "เลขยกกำลัง:Exponents:2.1 ความหมายของเลขยกกำลัง|2.2 กฎการคูณและหารเลขยกกำลัง|2.3 เลขยกกำลังที่เป็นศูนย์และลบ|2.4 รากที่สอง|2.5 การประมาณค่า|2.6 โจทย์ปัญหา"
    "พหุนาม:Polynomials:3.1 นิพจน์พีชคณิต|3.2 การบวกลบพหุนาม|3.3 การคูณพหุนาม|3.4 การแยกตัวประกอบ|3.5 ห.ร.ม. และ ค.ร.น. ของพหุนาม|3.6 การหารพหุนาม"
    "สมการและอสมการ:Equations:4.1 สมการเชิงเส้นตัวแปรเดียว|4.2 การแก้โจทย์ปัญหา|4.3 อสมการเชิงเส้น|4.4 สมการที่มีวงเล็บ|4.5 สมการเศษส่วน|4.6 ประยุกต์สมการ"
    "เรขาคณิต:Geometry:5.1 เส้นขนานและมุม|5.2 รูปสามเหลี่ยมและมุม|5.3 รูปสี่เหลี่ยม|5.4 พื้นที่รูปหลายเหลี่ยม|5.5 ทฤษฎีบทพีทาโกรัส|5.6 ปริมาตร"
    "ข้อมูลและกราฟ:Data:6.1 การเก็บรวบรวมข้อมูล|6.2 ตารางแจกแจงความถี่|6.3 กราฟแท่งและกราฟเส้น|6.4 กราฟวงกลม|6.5 ค่ากลาง|6.6 การแปลความหมายข้อมูล"
)

# ม.3
declare -a M3_CHAPTERS=(
    "จำนวนจริง:Real Numbers:1.1 ความหมายของจำนวนจริง|1.2 จำนวนอตรรกยะ|1.3 การดำเนินการจำนวนจริง|1.4 รากที่สามและรากที่ n|1.5 เลขยกกำลังเศษส่วน|1.6 การประมาณค่า"
    "พหุนามและสมการ:Polynomials:2.1 การคูณพหุนาม|2.2 ผลคูณพิเศษ|2.3 การแยกตัวประกอบ|2.4 สมการกำลังสอง|2.5 การแก้สมการกำลังสอง|2.6 โจทย์ปัญหา"
    "ระบบสมการ:Systems:3.1 ระบบสมการเชิงเส้น|3.2 วิธีการแทนค่า|3.3 วิธีการกำจัดตัวแปร|3.4 การแก้โจทย์ปัญหา|3.5 กราฟของสมการเชิงเส้น|3.6 จุดตัดของกราฟ"
    "ฟังก์ชัน:Functions:4.1 ความหมายของฟังก์ชัน|4.2 กราฟของฟังก์ชัน|4.3 ฟังก์ชันเชิงเส้น|4.4 ความชัน|4.5 สมการเส้นตรง|4.6 การประยุกต์"
    "เรขาคณิต:Geometry:5.1 สามเหลี่ยมคล้าย|5.2 อัตราส่วนและสัดส่วน|5.3 ทฤษฎีบทวงกลม|5.4 พื้นที่ผิวและปริมาตร|5.5 การแปลง|5.6 ความสมมาตร"
    "สถิติและความน่าจะเป็น:Statistics:6.1 การนำเสนอข้อมูล|6.2 การกระจายของข้อมูล|6.3 ส่วนเบี่ยงเบนมาตรฐาน|6.4 ความน่าจะเป็น|6.5 เหตุการณ์ร่วม|6.6 การทดลองและตัวอย่าง"
)

# ม.4
declare -a M4_CHAPTERS=(
    "เซตและตรรกศาสตร์:Sets:1.1 ความหมายของเซต|1.2 การดำเนินการของเซต|1.3 กฎของเซต|1.4 ประพจน์|1.5 ตารางค่าความจริง|1.6 การให้เหตุผล"
    "ฟังก์ชันและกราฟ:Functions:2.1 ฟังก์ชันและความสัมพันธ์|2.2 ประเภทของฟังก์ชัน|2.3 กราฟฟังก์ชัน|2.4 ฟังก์ชันกำลังสอง|2.5 ฟังก์ชันค่าสัมบูรณ์|2.6 การแปลงกราฟ"
    "พหุนาม:Polynomials:3.1 พหุนามดีกรีสูง|3.2 ทฤษฎีบทเศษเหลือ|3.3 สมการพหุนาม|3.4 อสมการ|3.5 ความไม่เท่า|3.6 โจทย์ปัญหา"
    "ลำดับและอนุกรม:Sequences:4.1 ลำดับ|4.2 อนุกรม|4.3 ลำดับเลขคณิต|4.4 อนุกรมเลขคณิต|4.5 ลำดับเรขาคณิต|4.6 อนุกรมเรขาคณิต"
    "เรขาคณิตวิเคราะห์:Geometry:5.1 ระบบพิกัด|5.2 ระยะทางระหว่างจุด|5.3 จุดกึ่งกลาง|5.4 สมการเส้นตรง|5.5 เส้นขนานและเส้นตั้งฉาก|5.6 วงกลม"
    "ตรีโกณมิติ:Trigonometry:6.1 อัตราส่วนตรีโกณมิติ|6.2 การหาค่าอัตราส่วน|6.3 การแก้สามเหลี่ยมมุมฉาก|6.4 มุมในตำแหน่งมาตรฐาน|6.5 กราฟฟังก์ชันตรีโกณมิติ|6.6 เอกลักษณ์ตรีโกณมิติ"
)

# ม.5  
declare -a M5_CHAPTERS=(
    "ตรีโกณมิติ:Trigonometry:1.1 ฟังก์ชันตรีโกณมิติ|1.2 เอกลักษณ์ตรีโกณมิติ|1.3 สมการตรีโกณมิติ|1.4 กฎของไซน์|1.5 กฎของโคไซน์|1.6 การแก้สามเหลี่ยม"
    "เมทริกซ์:Matrices:2.1 ความหมายของเมทริกซ์|2.2 การบวกลบเมทริกซ์|2.3 การคูณเมทริกซ์|2.4 เมทริกซ์ผกผัน|2.5 ดีเทอร์มิแนนต์|2.6 การแก้ระบบสมการ"
    "เวกเตอร์:Vectors:3.1 ความหมายของเวกเตอร์|3.2 การบวกลบเวกเตอร์|3.3 ผลคูณสเกลาร์|3.4 ผลคูณจุด|3.5 ผลคูณไขว้|3.6 การประยุกต์เวกเตอร์"
    "การนับและความน่าจะเป็น:Probability:4.1 หลักการนับ|4.2 การเรียงสับเปลี่ยน|4.3 การจัดหมู่|4.4 ความน่าจะเป็นเบื้องต้น|4.5 ทฤษฎีบทความน่าจะเป็น|4.6 ความน่าจะเป็นแบบมีเงื่อนไข"
    "ลิมิตและความต่อเนื่อง:Limits:5.1 ลิมิตของฟังก์ชัน|5.2 กฎการหาลิมิต|5.3 ลิมิตที่อนันต์|5.4 ลิมิตเมื่อ x เข้าใกล้อนันต์|5.5 ความต่อเนื่อง|5.6 ทฤษฎีบทค่ากลาง"
    "อนุพันธ์:Derivatives:6.1 ความหมายของอนุพันธ์|6.2 กฎการหาอนุพันธ์|6.3 กฎลูกโซ่|6.4 อนุพันธ์อันดับสูง|6.5 การประยุกต์อนุพันธ์|6.6 ปัญหาค่าสูงสุดต่ำสุด"
)

# ม.6
declare -a M6_CHAPTERS=(
    "อนุพันธ์ขั้นสูง:Derivatives:1.1 อนุพันธ์ของฟังก์ชันตรีโกณมิติ|1.2 อนุพันธ์ของฟังก์ชันเอกซ์โพเนนเชียล|1.3 อนุพันธ์ของฟังก์ชันลอการิทึม|1.4 การหาอนุพันธ์โดยนัย|1.5 อัตราการเปลี่ยนแปลง|1.6 การประมาณค่า"
    "ปริพันธ์:Integration:2.1 ปริพันธ์ไม่จำกัดเขต|2.2 กฎการหาปริพันธ์|2.3 เทคนิคการหาปริพันธ์|2.4 ปริพันธ์จำกัดเขต|2.5 ทฤษฎีบทพื้นฐานของแคลคูลัส|2.6 การหาพื้นที่"
    "สมการเชิงอนุพันธ์:Differential:3.1 ความหมายของสมการเชิงอนุพันธ์|3.2 สมการอันดับหนึ่ง|3.3 การแยกตัวแปร|3.4 สมการเชิงเส้นอันดับหนึ่ง|3.5 สมการอันดับสอง|3.6 การประยุกต์"
    "จำนวนเชิงซ้อน:Complex:4.1 ความหมายของจำนวนเชิงซ้อน|4.2 การดำเนินการจำนวนเชิงซ้อน|4.3 รูปเรขาคณิต|4.4 รูปเชิงขั้ว|4.5 ทฤษฎีบทเดอมัวฟร์|4.6 รากที่ n"
    "สถิติประยุกต์:Statistics:5.1 การสุ่มตัวอย่าง|5.2 การแจกแจงความน่าจะเป็น|5.3 การแจกแจงปกติ|5.4 การประมาณค่า|5.5 การทดสอบสมมติฐาน|5.6 การวิเคราะห์การถดถอย"
    "เรขาคณิตวิเคราะห์:Conics:6.1 พาราโบลา|6.2 วงรี|6.3 ไฮเพอร์โบลา|6.4 สมการทั่วไปของคอนิก|6.5 การแปลงพิกัด|6.6 การประยุกต์"
)

# Function สร้างไฟล์ TOC
create_toc_html() {
    local grade=$1
    local grade_num=$2
    shift 2
    local chapters=("$@")
    
    local filename="m${grade_num}.html"
    
    cat > "$filename" << 'EOF'
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>คณิตศาสตร์ GRADE_NAME - สารบัญ</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
    <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
    <script>
        MathJax = {
            tex: {
                inlineMath: [['$', '$'], ['\\(', '\\)']],
                displayMath: [['$$', '$$'], ['\\[', '\\]']]
            }
        };
    </script>
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
                    <li><a href="index.html">หน้าแรก</a></li>
                    <li><a href="m1.html">ม.1</a></li>
                    <li><a href="m2.html">ม.2</a></li>
                    <li><a href="m3.html">ม.3</a></li>
                    <li><a href="m4.html">ม.4</a></li>
                    <li><a href="m5.html">ม.5</a></li>
                    <li><a href="m6.html">ม.6</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="ad-container ad-top" data-ad-position="topBanner"></div>

    <div class="container">
        <div class="breadcrumb">
            <a href="index.html">หน้าแรก</a>
            <span>›</span>
            <span>GRADE_NAME</span>
        </div>
    </div>

    <main class="container">
        <div class="content-wrapper">
            <aside class="sidebar-left">
                <div class="ad-space" data-ad-position="sidebarTop"></div>
            </aside>

            <section class="main-content">
                <h1 style="color: #667eea; margin-bottom: 20px;">คณิตศาสตร์ GRADE_NAME</h1>

                <div class="intro-section">
                    <h2>เกี่ยวกับคณิตศาสตร์ GRADE_NAME</h2>
                    <p>คณิตศาสตร์ชั้น GRADE_NAME INTRO_TEXT</p>
                </div>

                <div class="ad-space" data-ad-position="inArticle"></div>

                <!-- สารบัญ -->
                <section class="toc-section" id="table-of-contents">
                    <h2>📚 สารบัญเนื้อหา</h2>

                    <div class="toc-grid">
CHAPTERS_CONTENT
                    </div>
                </section>
            </section>

            <aside class="sidebar-right">
                <div class="ad-space" data-ad-position="sidebarMiddle"></div>
            </aside>
        </div>
    </main>

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
                        <li><a href="m1.html">ม.1</a></li>
                        <li><a href="m2.html">ม.2</a></li>
                        <li><a href="m3.html">ม.3</a></li>
                        <li><a href="m4.html">ม.4</a></li>
                        <li><a href="m5.html">ม.5</a></li>
                        <li><a href="m6.html">ม.6</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 คณิตศาสตร์มัธยม. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="js/script.js"></script>
    <script src="js/adsense-config.js"></script>
    <script src="js/adsense-loader.js"></script>
</body>
</html>
EOF

    # Replace placeholders
    sed -i "s/GRADE_NAME/มัธยมศึกษาปีที่ ${grade_num}/g" "$filename"
    sed -i "s/class=\"active\"/class=\"\"/g" "$filename"
    sed -i "s|<a href=\"m${grade_num}.html\">|<a href=\"m${grade_num}.html\" class=\"active\">|" "$filename"
    
    # สร้าง HTML สำหรับแต่ละบท
    local chapters_html=""
    local i=1
    for chapter in "${chapters[@]}"; do
        IFS=':' read -ra PARTS <<< "$chapter"
        local title="${PARTS[0]}"
        local subtitle="${PARTS[1]}"
        local topics="${PARTS[2]}"
        
        # แปลง topics เป็น li
        local topics_html=""
        IFS='|' read -ra TOPIC_LIST <<< "$topics"
        for topic in "${TOPIC_LIST[@]}"; do
            topics_html+="                                    <li>$topic</li>\n"
        done
        
        chapters_html+="                        <!-- บทที่ ${i} -->\n"
        chapters_html+="                        <div class=\"toc-card\">\n"
        chapters_html+="                            <div class=\"toc-card-header\">\n"
        chapters_html+="                                <h3>บทที่ ${i}</h3>\n"
        chapters_html+="                                <h4>${title}</h4>\n"
        chapters_html+="                            </div>\n"
        chapters_html+="                            <div class=\"toc-card-body\">\n"
        chapters_html+="                                <ul class=\"toc-list\">\n"
        chapters_html+="$topics_html"
        chapters_html+="                                </ul>\n"
        chapters_html+="                                <a href=\"m${grade_num}/chapter${i}.html\" class=\"btn-chapter\">เรียนบทที่ ${i}</a>\n"
        chapters_html+="                            </div>\n"
        chapters_html+="                        </div>\n\n"
        
        ((i++))
    done
    
    # แทนที่ CHAPTERS_CONTENT
    echo -e "$chapters_html" > /tmp/chapters.txt
    sed -i "/CHAPTERS_CONTENT/r /tmp/chapters.txt" "$filename"
    sed -i "/CHAPTERS_CONTENT/d" "$filename"
    
    # ใส่ intro text ตามชั้นปี
    case $grade_num in
        2) sed -i "s/INTRO_TEXT/เป็นการต่อยอดจาก ม.1 ครอบคลุมจำนวนตรรกยะ เลขยกกำลัง พหุนาม และสมการขั้นสูง/g" "$filename" ;;
        3) sed -i "s/INTRO_TEXT/เริ่มเรียนรู้จำนวนจริง ระบบสมการ ฟังก์ชัน และเรขาคณิตขั้นสูง/g" "$filename" ;;
        4) sed -i "s/INTRO_TEXT/ครอบคลุมเซต ฟังก์ชัน ลำดับและอนุกรม เรขาคณิตวิเคราะห์ และตรีโกณมิติ/g" "$filename" ;;
        5) sed -i "s/INTRO_TEXT/เริ่มต้นแคลคูลัส เรียนรู้ตรีโกณมิติ เมทริกซ์ เวกเตอร์ และลิมิต/g" "$filename" ;;
        6) sed -i "s/INTRO_TEXT/แคลคูลัสขั้นสูง อนุพันธ์ ปริพันธ์ จำนวนเชิงซ้อน และคอนิก/g" "$filename" ;;
    esac
    
    echo "✅ Created $filename"
}

# สร้างไฟล์ TOC ทั้งหมด
echo "📝 Creating TOC pages..."
create_toc_html "ม.2" 2 "${M2_CHAPTERS[@]}"
create_toc_html "ม.3" 3 "${M3_CHAPTERS[@]}"
create_toc_html "ม.4" 4 "${M4_CHAPTERS[@]}"
create_toc_html "ม.5" 5 "${M5_CHAPTERS[@]}"
create_toc_html "ม.6" 6 "${M6_CHAPTERS[@]}"

echo "✅ All TOC pages created!"
