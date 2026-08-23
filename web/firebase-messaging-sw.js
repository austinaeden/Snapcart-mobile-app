// Firebase Messaging Service Worker
// Required for background push notifications on web

importScripts("https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey:            "AIzaSyCunmT8EdqyWqw8MN5q0xtqUMIndoTP7w0",
  authDomain:        "snapcart-mobile-app-2026-425ea.firebaseapp.com",
  projectId:         "snapcart-mobile-app-2026-425ea",
  storageBucket:     "snapcart-mobile-app-2026-425ea.firebasestorage.app",
  messagingSenderId: "911830445480",
  // TODO: Replace with your real Web App ID from Firebase Console
  // Project Settings → General → Your apps → Web app → App ID
  appId: "YOUR_WEB_APP_ID",
});

const messaging = firebase.messaging();

// Handle background messages
messaging.onBackgroundMessage(function (payload) {
  console.log("[firebase-messaging-sw.js] Received background message:", payload);

  const notificationTitle = payload.notification?.title || "SnapCart";
  const notificationOptions = {
    body: payload.notification?.body || "",
    icon: "/icons/Icon-192.png",
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
