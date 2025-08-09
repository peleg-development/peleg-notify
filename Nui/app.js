new Vue({
    el: "#app",
    data: {
        notifications: [],
        soundEnabled: true,
        position: 'top-right'
    },
    methods: {
        showNotification(type, title, message, duration = 4000, darkMode = false, rtl = false, options = {}) {
            const id = Date.now() + Math.random();
            const notification = {
                id,
                type,
                title,
                message,
                duration,
                darkMode,
                rtl,
                timestamp: Date.now(),
                customColor: options.customColor || null,
                customIcon: options.customIcon || null
            };
            
            this.notifications.unshift(notification);
            this.playNotificationSound(type);
            
            setTimeout(() => {
                this.removeNotification(id);
            }, duration);
        },

        removeNotification(id) {
            const index = this.notifications.findIndex(n => n.id === id);
            if (index > -1) {
                this.notifications.splice(index, 1);
            }
        },

        getIcon(type, customIcon) {
            if (type === 'custom' && customIcon) return customIcon;
            const icons = {
                success: "fas fa-check",
                error: "fa-solid fa-ban",
                warning: "fa-solid fa-circle-exclamation",
                info: "fas fa-info"
            };
            return icons[type] || "fas fa-bell";
        },

        playNotificationSound(type) {
            if (!this.soundEnabled) return;
            
            const sound = document.getElementById("notificationSound");
            if (sound) {
                sound.currentTime = 0;
                sound.volume = 0.3;
                sound.play().catch(() => {});
            }
        },

        toggleSound() {
            this.soundEnabled = !this.soundEnabled;
            localStorage.setItem('pelegNotify_sound', this.soundEnabled);
        },

        getTypeColor(type, customColor) {
            if (type === 'custom' && customColor) return customColor;
            const colors = {
                success: '#10b981',
                error: '#ef4444',
                warning: '#f59e0b',
                info: '#3b82f6'
            };
            return colors[type] || '#6b7280';
        }
    },
    
    mounted() {
        this.soundEnabled = localStorage.getItem('pelegNotify_sound') !== 'false';
        
        window.addEventListener("message", (event) => {
            if (event.data.action === "showNotification") {
                const { type, title, description, duration, darkMode, rtl } = event.data;
                this.showNotification(type, title, description, duration, darkMode, rtl);
            }
            if (event.data.action === "showCustomNotification") {
                const { title, description, duration, darkMode, rtl, customColor, customIcon } = event.data;
                this.showNotification('custom', title, description, duration, darkMode, rtl, { customColor, customIcon });
            }
        });

    }
});
