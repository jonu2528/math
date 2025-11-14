#!/bin/bash

echo "🔍 Checking for errors..."
echo ""

# 1. Check for broken links
echo "1️⃣ Checking internal links..."
errors=0

# Check all HTML files
for file in *.html m*/*.html; do
    if [ -f "$file" ]; then
        # Check for broken CSS links
        if grep -q 'href="css/style.css"' "$file" || grep -q 'href="../css/style.css"' "$file"; then
            : # OK
        else
            echo "  ⚠️  Warning: $file may have incorrect CSS link"
            ((errors++))
        fi
        
        # Check for broken JS links
        if grep -q 'src="js/script.js"' "$file" || grep -q 'src="../js/script.js"' "$file"; then
            : # OK
        else
            echo "  ⚠️  Warning: $file may have incorrect JS link"
        fi
    fi
done

# 2. Check CSS file exists
echo ""
echo "2️⃣ Checking CSS file..."
if [ -f "css/style.css" ]; then
    echo "  ✅ css/style.css exists"
else
    echo "  ❌ css/style.css NOT FOUND!"
    ((errors++))
fi

# 3. Check JS files exist
echo ""
echo "3️⃣ Checking JavaScript files..."
for js_file in js/script.js js/adsense-config.js js/adsense-loader.js; do
    if [ -f "$js_file" ]; then
        echo "  ✅ $js_file exists"
    else
        echo "  ❌ $js_file NOT FOUND!"
        ((errors++))
    fi
done

# 4. Check for undefined CSS classes
echo ""
echo "4️⃣ Checking important CSS classes..."
required_classes=(
    "navbar"
    "nav-container"
    "logo"
    "main-nav"
    "nav-menu"
    "breadcrumb"
    "content-wrapper"
    "sidebar-left"
    "sidebar-right"
    "main-content"
    "chapter-intro"
    "section-nav"
    "definition"
    "example"
    "exercise-section"
    "toggle-answer"
    "answer"
    "back-to-section"
    "chapter-nav"
    "ad-space"
    "footer-container"
)

if [ -f "css/style.css" ]; then
    for class in "${required_classes[@]}"; do
        if grep -q "\.$class" css/style.css || grep -q "\.$class\s" css/style.css; then
            : # Found
        else
            echo "  ⚠️  CSS class .$class might be missing"
        fi
    done
    echo "  ✅ CSS classes check complete"
fi

# 5. Check JavaScript functions
echo ""
echo "5️⃣ Checking JavaScript functions..."
if [ -f "js/script.js" ]; then
    required_functions=(
        "toggleAnswer"
    )
    
    for func in "${required_functions[@]}"; do
        if grep -q "function $func" js/script.js || grep -q "$func\s*=" js/script.js; then
            echo "  ✅ Function $func found"
        else
            echo "  ⚠️  Function $func might be missing"
        fi
    done
fi

# 6. Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $errors -eq 0 ]; then
    echo "✅ No critical errors found!"
else
    echo "⚠️  Found $errors potential issues"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
