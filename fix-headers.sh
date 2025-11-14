#!/bin/bash

echo "🔧 Fixing header structure in all chapter files..."

# Function แก้ไข header
fix_header() {
    local file=$1
    
    # ตรวจสอบว่ามี navbar แบบเก่าหรือไม่
    if grep -q '<nav class="navbar">' "$file"; then
        echo "  📝 Fixing: $file"
        
        # Create temporary file with correct header
        cat > /tmp/header_replacement.txt << 'HEADEREOF'
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
                    <li><a href="../m1.html">ม.1</a></li>
                    <li><a href="../m2.html">ม.2</a></li>
                    <li><a href="../m3.html">ม.3</a></li>
                    <li><a href="../m4.html">ม.4</a></li>
                    <li><a href="../m5.html">ม.5</a></li>
                    <li><a href="../m6.html">ม.6</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="breadcrumb">
HEADEREOF

        # Replace old header with new one
        sed -i '/<body>/,/<div class="breadcrumb">/c\
<body>\
    <header>\
        <div class="container">\
            <div class="logo">\
                <h1>📐 คณิตศาสตร์มัธยม</h1>\
                <p class="tagline">เรียนรู้คณิตศาสตร์ ม.1-6 อย่างละเอียดและเข้าใจง่าย</p>\
            </div>\
            <nav class="main-nav">\
                <button class="mobile-menu-toggle">☰</button>\
                <ul class="nav-menu">\
                    <li><a href="../index.html">หน้าแรก</a></li>\
                    <li><a href="../m1.html">ม.1</a></li>\
                    <li><a href="../m2.html">ม.2</a></li>\
                    <li><a href="../m3.html">ม.3</a></li>\
                    <li><a href="../m4.html">ม.4</a></li>\
                    <li><a href="../m5.html">ม.5</a></li>\
                    <li><a href="../m6.html">ม.6</a></li>\
                </ul>\
            </nav>\
        </div>\
    </header>\
\
    <div class="container">\
        <div class="breadcrumb">' "$file"
        
        # แก้ breadcrumb format
        sed -i 's|<a href="\.\./index\.html">หน้าแรก</a> &gt;|<a href="../index.html">หน้าแรก</a>\n            <span>›</span>|g' "$file"
        sed -i 's|<a href="\.\./m\([0-9]\)\.html">ม\.\1</a> &gt;|<a href="../m\1.html">ม.\1</a>\n            <span>›</span>|g' "$file"
        
        # เปลี่ยน content-wrapper structure
        sed -i 's|<div class="content-wrapper">|<div class="ad-container ad-top" data-ad-position="topBanner"></div>\n\n    <main class="container">\n        <div class="content-wrapper">\n            <aside class="sidebar-left">\n                <div class="ad-space" data-ad-position="sidebarTop"></div>\n            </aside>\n\n            <section class="main-content">|g' "$file"
        
        # แก้ article tag
        sed -i 's|<article class="chapter-content">||g' "$file"
        
        # แก้ sidebar
        sed -i 's|<aside class="sidebar">|</section>\n\n            <aside class="sidebar-right">|g' "$file"
        
        # แก้ closing tags
        sed -i 's|</article>||g' "$file"
        
        echo "    ✅ Fixed: $file"
    fi
}

# แก้ไขทุกไฟล์
for grade in {2..6}; do
    echo "📁 Fixing M.${grade} chapters..."
    for chapter in {1..6}; do
        file="m${grade}/chapter${chapter}.html"
        if [ -f "$file" ]; then
            fix_header "$file"
        fi
    done
done

echo "✅ All headers fixed!"
