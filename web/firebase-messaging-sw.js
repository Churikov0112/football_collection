importScripts('https://www.gstatic.com/firebasejs/11.0.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/11.0.0/firebase-analytics-compat.js');
importScripts('https://www.gstatic.com/firebasejs/11.0.0/firebase-messaging-compat.js');

firebase.initializeApp({
    // эту часть берём из файла firebase_options.dart из переменной static const FirebaseOptions web
    apiKey: 'AIzaSyDxO05saK_q0o5dkvUZYJRQkfhCL4pXzy4',
    appId: '1:590271846043:web:55bec345a0cc9b4291583e',
    messagingSenderId: '590271846043',
    projectId: 'football-collection-c7c28',
    authDomain: 'football-collection-c7c28.firebaseapp.com',
    storageBucket: 'football-collection-c7c28.firebasestorage.app',
    measurementId: 'G-PC62WVQQGM',

});

messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});