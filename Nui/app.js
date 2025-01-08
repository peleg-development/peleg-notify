new Vue({
    el: "#app",
    data: {
        notifications: [] 
    },
    methods: {
        showNotification(type, title, message, duration = 5000, darkMode = false) {
            const id = Date.now(); 
            this.notifications.push({ id, type, title, message, duration, darkMode });

            this.playSound();

            setTimeout(() => {
                this.removeNotification(id);
            }, duration);
        },
        removeNotification(id) {
            this.notifications = this.notifications.filter(notification => notification.id !== id);
        },
        getIcon(type) {
            const icons = {
                success: "fas fa-check-circle",
                error: "fas fa-times-circle",
                warning: "fas fa-exclamation-triangle",
                info: "fas fa-info-circle"
            };
            return icons[type] || "fas fa-bell";
        },
        playSound() {
            const sound = document.getElementById("notificationSound");
            if (sound) {
                sound.currentTime = 0; 
                sound.play();
            }
        }
    },
    mounted() {
        window.addEventListener("message", (event) => {
            if (event.data.action === "showNotification") {
                const { type, title, description, duration, darkMode } = event.data;
                this.showNotification(type, title, description, duration, darkMode);
            }
        });
    }
});
