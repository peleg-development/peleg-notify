new Vue({
    el: '#app',
    data: {
        notifications: [],
        notificationId: 0,
        isDarkMode: false,
        isSoundEnabled: true,
        duration: 5000 // 5 seconds
    },
    methods: {
        showNotification(type, title, message) {
            const id = this.notificationId++;
            const notification = {
                id,
                type,
                title,
                message
            };
            
            this.notifications.push(notification);

            if (this.isSoundEnabled) {
                this.playSound(type);
            }

            setTimeout(() => {
                this.removeNotification(id);
            }, this.duration);
        },

        removeNotification(id) {
            const index = this.notifications.findIndex(n => n.id === id);
            if (index !== -1) {
                this.notifications.splice(index, 1);
            }
        },

        getIcon(type) {
            const icons = {
                success: 'fas fa-check-circle',
                error: 'fas fa-times-circle',
                warning: 'fas fa-exclamation-circle',
                info: 'fas fa-info-circle'
            };
            return icons[type] || icons.info;
        },

        playSound(type) {
            const audio = document.getElementById(`${type}Sound`);
            if (audio) {
                audio.currentTime = 0;
                audio.play().catch(e => console.log('Sound play failed:', e));
            }
        }
    },
    
    watch: {
        isDarkMode(newValue) {
            localStorage.setItem('isDarkMode', newValue);
            document.body.classList.toggle('dark-mode', newValue);
        },
        isSoundEnabled(newValue) {
            localStorage.setItem('isSoundEnabled', newValue);
        }
    },
    
    mounted() {
        this.isDarkMode = localStorage.getItem('isDarkMode') === 'true';
        this.isSoundEnabled = localStorage.getItem('isSoundEnabled') !== 'false';
        document.body.classList.toggle('dark-mode', this.isDarkMode);
    }
});