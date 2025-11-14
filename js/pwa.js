/**
 * PWA Registration Script
 * Registers service worker and handles PWA events
 */

// Register service worker
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('/service-worker.js')
            .then((registration) => {
                console.log('✅ Service Worker registered successfully:', registration.scope);
                
                // Check for updates
                registration.addEventListener('updatefound', () => {
                    const newWorker = registration.installing;
                    console.log('🔄 Service Worker update found');
                    
                    newWorker.addEventListener('statechange', () => {
                        if (newWorker.state === 'installed' && navigator.serviceWorker.controller) {
                            // New service worker available
                            showUpdateNotification();
                        }
                    });
                });
            })
            .catch((error) => {
                console.error('❌ Service Worker registration failed:', error);
            });
        
        // Handle controller change
        navigator.serviceWorker.addEventListener('controllerchange', () => {
            console.log('🔄 Service Worker controller changed');
            window.location.reload();
        });
    });
}

// Show update notification
function showUpdateNotification() {
    const notification = document.createElement('div');
    notification.className = 'pwa-update-notification';
    notification.innerHTML = `
        <div class="pwa-update-content">
            <p>🎉 มีเวอร์ชันใหม่พร้อมใช้งาน!</p>
            <div class="pwa-update-buttons">
                <button onclick="updateApp()" class="btn-update">อัพเดตเลย</button>
                <button onclick="dismissUpdate()" class="btn-dismiss">ภายหลัง</button>
            </div>
        </div>
    `;
    document.body.appendChild(notification);
    
    // Auto show with animation
    setTimeout(() => {
        notification.classList.add('show');
    }, 100);
}

// Update app
window.updateApp = function() {
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.getRegistration().then((reg) => {
            if (reg && reg.waiting) {
                reg.waiting.postMessage({ type: 'SKIP_WAITING' });
            }
        });
    }
    dismissUpdate();
};

// Dismiss update notification
window.dismissUpdate = function() {
    const notification = document.querySelector('.pwa-update-notification');
    if (notification) {
        notification.classList.remove('show');
        setTimeout(() => {
            notification.remove();
        }, 300);
    }
};

// Add to home screen prompt
let deferredPrompt;

window.addEventListener('beforeinstallprompt', (e) => {
    console.log('💾 PWA install prompt available');
    
    // Prevent the mini-infobar from appearing
    e.preventDefault();
    
    // Stash the event so it can be triggered later
    deferredPrompt = e;
    
    // Show custom install button
    showInstallButton();
});

// Show install button
function showInstallButton() {
    const installButton = document.createElement('button');
    installButton.className = 'pwa-install-button';
    installButton.innerHTML = '📱 ติดตั้งแอป';
    installButton.onclick = () => {
        if (deferredPrompt) {
            // Show the install prompt
            deferredPrompt.prompt();
            
            // Wait for the user to respond to the prompt
            deferredPrompt.userChoice.then((choiceResult) => {
                if (choiceResult.outcome === 'accepted') {
                    console.log('✅ User accepted the install prompt');
                } else {
                    console.log('❌ User dismissed the install prompt');
                }
                deferredPrompt = null;
                installButton.remove();
            });
        }
    };
    
    // Add to page after delay
    setTimeout(() => {
        document.body.appendChild(installButton);
        setTimeout(() => {
            installButton.classList.add('show');
        }, 100);
    }, 3000); // Show after 3 seconds
}

// Handle app installed
window.addEventListener('appinstalled', () => {
    console.log('✅ PWA installed successfully');
    deferredPrompt = null;
    
    // Remove install button if exists
    const installButton = document.querySelector('.pwa-install-button');
    if (installButton) {
        installButton.remove();
    }
    
    // Show success message
    showSuccessMessage('แอปติดตั้งสำเร็จ! 🎉');
});

// Show success message
function showSuccessMessage(message) {
    const toast = document.createElement('div');
    toast.className = 'pwa-toast';
    toast.textContent = message;
    document.body.appendChild(toast);
    
    setTimeout(() => {
        toast.classList.add('show');
    }, 100);
    
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => {
            toast.remove();
        }, 300);
    }, 3000);
}

// Check if running as PWA
function isPWA() {
    return window.matchMedia('(display-mode: standalone)').matches || 
           window.navigator.standalone || 
           document.referrer.includes('android-app://');
}

if (isPWA()) {
    console.log('🚀 Running as PWA');
    document.body.classList.add('pwa-mode');
} else {
    console.log('🌐 Running in browser');
}

// Add PWA styles
const pwaStyles = document.createElement('style');
pwaStyles.textContent = `
    .pwa-update-notification {
        position: fixed;
        bottom: -100px;
        left: 50%;
        transform: translateX(-50%);
        background: white;
        box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        border-radius: 10px;
        padding: 20px;
        z-index: 10000;
        transition: all 0.3s ease;
        max-width: 400px;
        width: 90%;
    }
    
    .pwa-update-notification.show {
        bottom: 20px;
    }
    
    .pwa-update-content p {
        margin: 0 0 15px 0;
        font-weight: 600;
        color: #333;
    }
    
    .pwa-update-buttons {
        display: flex;
        gap: 10px;
    }
    
    .btn-update, .btn-dismiss {
        flex: 1;
        padding: 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-update {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
    }
    
    .btn-update:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(102, 126, 234, 0.4);
    }
    
    .btn-dismiss {
        background: #e0e0e0;
        color: #666;
    }
    
    .btn-dismiss:hover {
        background: #d0d0d0;
    }
    
    .pwa-install-button {
        position: fixed;
        bottom: -60px;
        right: 20px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        padding: 12px 20px;
        border-radius: 25px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        z-index: 9999;
        transition: all 0.3s ease;
    }
    
    .pwa-install-button.show {
        bottom: 20px;
    }
    
    .pwa-install-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
    }
    
    .pwa-toast {
        position: fixed;
        top: -60px;
        left: 50%;
        transform: translateX(-50%);
        background: #4caf50;
        color: white;
        padding: 15px 30px;
        border-radius: 5px;
        font-weight: 600;
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        z-index: 10001;
        transition: all 0.3s ease;
    }
    
    .pwa-toast.show {
        top: 20px;
    }
    
    /* PWA mode adjustments */
    body.pwa-mode {
        padding-top: env(safe-area-inset-top);
        padding-bottom: env(safe-area-inset-bottom);
    }
`;
document.head.appendChild(pwaStyles);

console.log('📱 PWA script loaded');
