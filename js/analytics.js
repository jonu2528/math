// Google Analytics Configuration
// แทนที่ 'G-XXXXXXXXXX' ด้วย Measurement ID ของคุณ

(function() {
    // ตรวจสอบว่ามี gtag อยู่แล้วหรือไม่
    if (window.gtag) {
        return;
    }

    // สร้าง script tag สำหรับ Google Analytics
    const GA_MEASUREMENT_ID = 'G-XXXXXXXXXX'; // แทนที่ด้วย Measurement ID ของคุณ

    // โหลด gtag.js
    const gtagScript = document.createElement('script');
    gtagScript.async = true;
    gtagScript.src = `https://www.googletagmanager.com/gtag/js?id=${GA_MEASUREMENT_ID}`;
    document.head.appendChild(gtagScript);

    // กำหนดค่า dataLayer และ gtag
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', GA_MEASUREMENT_ID, {
        'send_page_view': true,
        'anonymize_ip': true
    });

    // ทำให้ gtag พร้อมใช้งานทั่วทั้งเว็บ
    window.gtag = gtag;

    console.log('Google Analytics initialized with ID:', GA_MEASUREMENT_ID);
})();
