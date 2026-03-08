const notificationContainer = document.getElementById("notification-container");
const soundToggle = document.getElementById("sound-toggle");
const soundToggleIcon = document.getElementById("sound-toggle-icon");
const notificationSound = document.getElementById("notificationSound");

const validPositions = {
    "top-right": true,
    "top-left": true,
    "top-center": true,
    "bottom-right": true,
    "bottom-left": true,
    "bottom-center": true,
    center: true
};

const icons = {
    success: "fa-solid fa-check",
    error: "fa-solid fa-xmark",
    warning: "fa-solid fa-triangle-exclamation",
    info: "fa-solid fa-circle-info",
    custom: "fa-solid fa-bell"
};

const colors = {
    success: "#22c55e",
    error: "#ef4444",
    warning: "#f59e0b",
    info: "#3b82f6",
    custom: "#64748b"
};

let soundEnabled = true;

function isFiveMRuntime() {
    if (typeof GetParentResourceName === "function") {
        return true;
    }

    return window.location.hostname.startsWith("cfx-nui-");
}

function getPosition(position) {
    return validPositions[position] ? position : "top-right";
}

function getIcon(type, customIcon) {
    return customIcon || icons[type] || icons.custom;
}

function getColor(type, customColor) {
    return customColor || colors[type] || colors.custom;
}

function getDuration(duration) {
    const value = Number(duration);

    if (!Number.isFinite(value)) {
        return 5000;
    }

    return Math.max(500, Math.floor(value));
}

function setPosition(position) {
    notificationContainer.className = `notification-container ${getPosition(position)}`;
}

function updateSoundButton() {
    soundToggle.hidden = isFiveMRuntime();
    soundToggle.classList.toggle("sound-off", !soundEnabled);
    soundToggleIcon.className = soundEnabled ? "fa-solid fa-volume-up" : "fa-solid fa-volume-off";
}

function playSound() {
    if (!soundEnabled || !notificationSound) {
        return;
    }

    notificationSound.currentTime = 0;
    notificationSound.volume = 0.25;
    notificationSound.play().catch(() => {});
}

function removeNotification(element) {
    if (!element) {
        return;
    }

    element.classList.add("notification-removing");

    window.setTimeout(() => {
        element.remove();
    }, 200);
}

function createNotification(data) {
    const notification = document.createElement("div");
    notification.className = `notification ${data.type}${data.rtl ? " rtl" : ""}`;
    notification.style.setProperty("--c", getColor(data.type, data.customColor));
    notification.setAttribute("dir", data.rtl ? "rtl" : "ltr");
    notification.setAttribute("role", "alert");

    notification.innerHTML = `
        <div class="notification-icon">
            <i class="${getIcon(data.type, data.customIcon)}"></i>
        </div>
        <div class="notification-content">
            <h3 class="notification-title"></h3>
            <p class="notification-message"></p>
        </div>
        <div class="notification-progress">
            <div class="progress-bar"></div>
        </div>
    `;

    notification.querySelector(".notification-title").textContent = data.title || "Notification";
    notification.querySelector(".notification-message").textContent = data.description;
    notification.querySelector(".progress-bar").style.animationDuration = `${data.duration}ms`;

    notification.addEventListener("click", () => removeNotification(notification));

    return notification;
}

function showNotification(data) {
    if (!data.description) {
        return;
    }

    const notification = createNotification({
        type: data.type || "info",
        title: data.title || "Notification",
        description: data.description,
        duration: getDuration(data.duration),
        rtl: Boolean(data.rtl),
        customColor: data.customColor,
        customIcon: data.customIcon
    });

    setPosition(data.position);
    notificationContainer.prepend(notification);
    playSound();

    window.setTimeout(() => {
        removeNotification(notification);
    }, getDuration(data.duration));
}

window.addEventListener("message", (event) => {
    if (event.data.action === "showNotification") {
        showNotification(event.data);
    }

    if (event.data.action === "showCustomNotification") {
        showNotification({
            type: "custom",
            title: event.data.title,
            description: event.data.description,
            duration: event.data.duration,
            rtl: event.data.rtl,
            position: event.data.position,
            customColor: event.data.customColor,
            customIcon: event.data.customIcon
        });
    }
});

soundToggle.addEventListener("click", () => {
    soundEnabled = !soundEnabled;
    localStorage.setItem("pelegNotify_sound", soundEnabled);
    updateSoundButton();
});

soundEnabled = localStorage.getItem("pelegNotify_sound") !== "false";
updateSoundButton();
