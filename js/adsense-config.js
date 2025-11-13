/**
 * Google AdSense Configuration
 * แก้ไขไฟล์นี้เพื่อตั้งค่า AdSense ของคุณ
 */

const AdsenseConfig = {
    // เปิด/ปิดการแสดงโฆษณา
    enabled: true,
    
    // Google AdSense Client ID
    // แทนที่ด้วย Client ID ของคุณ (เช่น ca-pub-1234567890123456)
    clientId: 'ca-pub-XXXXXXXXXXXXXXXXX',
    
    // Ad Slot IDs สำหรับตำแหน่งต่างๆ
    slots: {
        // โฆษณาแบนเนอร์บน (728x90 หรือ 320x50 สำหรับมือถือ)
        topBanner: {
            slot: '1234567890',
            format: 'auto',
            responsive: true
        },
        
        // โฆษณา Sidebar บน (300x250)
        sidebarTop: {
            slot: '2345678901',
            format: 'rectangle',
            responsive: true
        },
        
        // โฆษณา Sidebar กลาง (300x600)
        sidebarMiddle: {
            slot: '3456789012',
            format: 'vertical',
            responsive: true
        },
        
        // โฆษณา Sidebar ล่าง (300x250)
        sidebarBottom: {
            slot: '4567890123',
            format: 'rectangle',
            responsive: true
        },
        
        // โฆษณาในเนื้อหา (In-article)
        inArticle: {
            slot: '5678901234',
            format: 'fluid',
            layout: 'in-article'
        },
        
        // โฆษณาท้ายบท (300x250)
        bottomBanner: {
            slot: '6789012345',
            format: 'auto',
            responsive: true
        }
    },
    
    // ข้อความแสดงแทนโฆษณาในโหมดทดสอบ
    placeholderText: {
        topBanner: '[โฆษณาแบนเนอร์บน 728x90]',
        sidebarTop: '[โฆษณา 300x250]',
        sidebarMiddle: '[โฆษณา 300x600]',
        sidebarBottom: '[โฆษณา 300x250]',
        inArticle: '[โฆษณาในบทความ]',
        bottomBanner: '[โฆษณาแบนเนอร์ล่าง]'
    }
};

// Export config for use in other files
if (typeof module !== 'undefined' && module.exports) {
    module.exports = AdsenseConfig;
}
