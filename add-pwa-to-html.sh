#!/bin/bash

echo "📱 Adding PWA support to HTML files..."

# Function เพิ่ม PWA meta tags และ scripts
add_pwa_support() {
    local file=$1
    
    # Check if PWA support already added
    if grep -q 'manifest.json' "$file"; then
        echo "  ⏭️  $file already has PWA support"
        return
    fi
    
    echo "  📝 Adding PWA to: $file"
    
    # หา path prefix
    local prefix=""
    if [[ $file == m*/* ]]; then
        prefix="../"
    fi
    
    # Add PWA meta tags after viewport tag
    sed -i '/<meta name="viewport"/a\
    <meta name="theme-color" content="#667eea">\
    <meta name="apple-mobile-web-app-capable" content="yes">\
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">\
    <meta name="apple-mobile-web-app-title" content="คณิตมัธยม">\
    <link rel="apple-touch-icon" href="'$prefix'icons/icon-192x192.svg">\
    <link rel="manifest" href="'$prefix'manifest.json">' "$file"
    
    # Add PWA script before closing body tag
    sed -i 's|</body>|    <script src="'$prefix'js/pwa.js"></script>\n</body>|g' "$file"
    
    echo "    ✅ PWA support added to $file"
}

# อัพเดตไฟล์หลัก
echo "📄 Updating main pages..."
for file in index.html m1.html m2.html m3.html m4.html m5.html m6.html; do
    if [ -f "$file" ]; then
        add_pwa_support "$file"
    fi
done

# อัพเดตไฟล์ chapters
echo ""
echo "📚 Updating chapter pages..."
for grade in {1..6}; do
    for chapter in {1..6}; do
        file="m${grade}/chapter${chapter}.html"
        if [ -f "$file" ]; then
            add_pwa_support "$file"
        fi
    done
done

echo ""
echo "✅ PWA support added to all HTML files!"
