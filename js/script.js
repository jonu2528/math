// Mobile Menu Toggle
document.addEventListener('DOMContentLoaded', function() {
    const menuToggle = document.querySelector('.mobile-menu-toggle');
    const navMenu = document.querySelector('.nav-menu');

    if (menuToggle) {
        menuToggle.addEventListener('click', function() {
            navMenu.classList.toggle('active');
        });
    }

    // Close mobile menu when clicking outside
    document.addEventListener('click', function(event) {
        const isClickInsideNav = navMenu.contains(event.target);
        const isClickOnToggle = menuToggle.contains(event.target);

        if (!isClickInsideNav && !isClickOnToggle && navMenu.classList.contains('active')) {
            navMenu.classList.remove('active');
        }
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Add active class to current page in navigation
    const currentLocation = window.location.pathname.split('/').pop() || 'index.html';
    const navLinks = document.querySelectorAll('.nav-menu a');

    navLinks.forEach(link => {
        const linkPath = link.getAttribute('href');
        if (linkPath === currentLocation) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });

    // Exercise toggle functionality
    const exerciseToggles = document.querySelectorAll('.exercise-toggle');
    exerciseToggles.forEach(toggle => {
        toggle.addEventListener('click', function() {
            const answer = this.nextElementSibling;
            if (answer && answer.classList.contains('exercise-answer')) {
                answer.classList.toggle('show');
                this.textContent = answer.classList.contains('show') ? 'ซ่อนเฉลย' : 'แสดงเฉลย';
            }
        });
    });

    // Add animation on scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('fade-in');
            }
        });
    }, observerOptions);

    document.querySelectorAll('.grade-card, .feature-item, .tip-item').forEach(el => {
        observer.observe(el);
    });

    // Back to top button
    const backToTopButton = document.createElement('button');
    backToTopButton.innerHTML = '↑';
    backToTopButton.className = 'back-to-top';
    backToTopButton.style.cssText = `
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        font-size: 24px;
        cursor: pointer;
        display: none;
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        z-index: 999;
        transition: all 0.3s ease;
    `;
    document.body.appendChild(backToTopButton);

    window.addEventListener('scroll', function() {
        if (window.pageYOffset > 300) {
            backToTopButton.style.display = 'block';
        } else {
            backToTopButton.style.display = 'none';
        }
    });

    backToTopButton.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });

    // Add hover effect to back to top button
    backToTopButton.addEventListener('mouseenter', function() {
        this.style.transform = 'scale(1.1)';
    });

    backToTopButton.addEventListener('mouseleave', function() {
        this.style.transform = 'scale(1)';
    });

    // Print button functionality (if exists)
    const printButtons = document.querySelectorAll('.print-btn');
    printButtons.forEach(btn => {
        btn.addEventListener('click', function() {
            window.print();
        });
    });

    // Search functionality (if search box exists)
    const searchInput = document.querySelector('.search-input');
    if (searchInput) {
        searchInput.addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const searchableItems = document.querySelectorAll('.searchable');

            searchableItems.forEach(item => {
                const text = item.textContent.toLowerCase();
                if (text.includes(searchTerm)) {
                    item.style.display = '';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    }
});

// Add fade-in animation CSS
const style = document.createElement('style');
style.textContent = `
    .fade-in {
        animation: fadeIn 0.6s ease-in;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .exercise-answer {
        display: none;
        margin-top: 15px;
        padding: 15px;
        background: #e8f5e9;
        border-left: 4px solid #4caf50;
        border-radius: 5px;
    }

    .exercise-answer.show {
        display: block;
        animation: slideDown 0.3s ease-out;
    }

    @keyframes slideDown {
        from {
            opacity: 0;
            max-height: 0;
        }
        to {
            opacity: 1;
            max-height: 500px;
        }
    }

    .exercise-toggle {
        background: #667eea;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 10px;
        transition: all 0.3s ease;
    }

    .exercise-toggle:hover {
        background: #764ba2;
        transform: translateY(-2px);
    }
`;
document.head.appendChild(style);
