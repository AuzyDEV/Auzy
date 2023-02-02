importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: 'AIzaSyCSPHw3MnOVfrtjdKJ8uI3pl31zBA9S1hs',
    appId: '1:45119442318:web:f19bd353c63958906068df',
    messagingSenderId: '45119442318',
    projectId: 'myfirstapp-72a20',
    authDomain: 'myfirstapp-72a20.firebaseapp.com',
    databaseURL: 'https://myfirstapp-72a20-default-rtdb.firebaseio.com',
    storageBucket: 'myfirstapp-72a20.appspot.com',
    measurementId: 'G-03WL4L4ST5',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});