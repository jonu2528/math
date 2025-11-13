/**
 * Google AdSense Loader
 * โหลดและแสดงโฆษณาตาม config
 */

class AdsenseLoader {
    constructor(config) {
        this.config = config;
        this.loaded = false;
    }
    
    /**
     * โหลด Google AdSense script
     */
    loadScript() {
        if (this.loaded || !this.config.enabled) {
            return;
        }
        
        const script = document.createElement('script');
        script.async = true;
        script.src = `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=${this.config.clientId}`;
        script.crossOrigin = 'anonymous';
        document.head.appendChild(script);
        
        this.loaded = true;
    }
    
    /**
     * สร้างโฆษณาสำหรับตำแหน่งที่กำหนด
     * @param {string} position - ตำแหน่งโฆษณา (topBanner, sidebarTop, etc.)
     * @returns {string} HTML code สำหรับโฆษณา
     */
    createAd(position) {
        if (!this.config.enabled) {
            return this.createPlaceholder(position);
        }
        
        const slotConfig = this.config.slots[position];
        if (!slotConfig) {
            return this.createPlaceholder(position);
        }
        
        // สร้าง HTML สำหรับโฆษณา
        let html = '<ins class="adsbygoogle"';
        html += ' style="display:block"';
        html += ` data-ad-client="${this.config.clientId}"`;
        html += ` data-ad-slot="${slotConfig.slot}"`;
        
        if (slotConfig.format) {
            html += ` data-ad-format="${slotConfig.format}"`;
        }
        
        if (slotConfig.layout) {
            html += ` data-ad-layout="${slotConfig.layout}"`;
        }
        
        if (slotConfig.responsive) {
            html += ' data-full-width-responsive="true"';
        }
        
        html += '></ins>';
        
        return html;
    }
    
    /**
     * สร้าง placeholder สำหรับโฆษณา
     * @param {string} position - ตำแหน่งโฆษณา
     * @returns {string} HTML code สำหรับ placeholder
     */
    createPlaceholder(position) {
        const text = this.config.placeholderText[position] || '[โฆษณา]';
        return `<div class="ad-placeholder"><p>${text}</p></div>`;
    }
    
    /**
     * แทรกโฆษณาในหน้าเว็บ
     */
    insertAds() {
        // หา elements ที่มี data-ad-position
        const adSpaces = document.querySelectorAll('[data-ad-position]');
        
        adSpaces.forEach(element => {
            const position = element.getAttribute('data-ad-position');
            const adHtml = this.createAd(position);
            element.innerHTML = adHtml;
        });
        
        // Push ads ถ้าเปิดใช้งาน AdSense
        if (this.config.enabled && window.adsbygoogle) {
            const ads = document.querySelectorAll('.adsbygoogle');
            ads.forEach(ad => {
                if (!ad.hasAttribute('data-adsbygoogle-status')) {
                    (adsbygoogle = window.adsbygoogle || []).push({});
                }
            });
        }
    }
    
    /**
     * เริ่มต้นการโหลดโฆษณา
     */
    init() {
        this.loadScript();
        
        // รอให้ DOM โหลดเสร็จก่อนแทรกโฆษณา
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.insertAds());
        } else {
            this.insertAds();
        }
    }
}

// สร้าง instance และเริ่มต้น
if (typeof AdsenseConfig !== 'undefined') {
    const adsenseLoader = new AdsenseLoader(AdsenseConfig);
    adsenseLoader.init();
}

// Export for use in other files
if (typeof module !== 'undefined' && module.exports) {
    module.exports = AdsenseLoader;
}
