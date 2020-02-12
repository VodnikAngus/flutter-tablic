'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/main.dart.js": "51c45cd48d57c8e0cdafb9dc2bc375c0",
"/index.html": "8f6e81b3c718ff1448dc449f7a853ec7",
"/assets/LICENSE": "350dbd907c730c11900be93fe0eb0ac1",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"/assets/AssetManifest.json": "5f2171fed2c03ced1c2d33b67f932cec",
"/assets/assets/cards/black/3.png": "f46b115ac3e978ff2eda29ac311c6c09",
"/assets/assets/cards/black/A.png": "3732246212621eaf3f83cf8fc2b8cebd",
"/assets/assets/cards/black/9.png": "267c8120f1ff8954410de5eb42004c50",
"/assets/assets/cards/black/5.png": "278f4546a1280ea2a2be74173b223db0",
"/assets/assets/cards/black/10.png": "934e4b966b4f335b660b24d0a60ee8bf",
"/assets/assets/cards/black/8.png": "838d8ad8c0954bb654d74f5efa99a5fc",
"/assets/assets/cards/black/2.png": "6d94da271c30afee31f495352e1466d0",
"/assets/assets/cards/black/4.png": "b448ea1bae0450ab499c2204101264c6",
"/assets/assets/cards/black/6.png": "943be909bf74f5bd820ce30c57d8c0ed",
"/assets/assets/cards/black/J.png": "fd9f1df83d01a7ea3bf1bd4b8cf046ed",
"/assets/assets/cards/black/7.png": "973cb25e741e3cee08ee307f296478aa",
"/assets/assets/cards/black/K.png": "582a97b09b602129bed04c2f815b8e12",
"/assets/assets/cards/black/Q.png": "8b840df7cc3325933c1f6510cc67c8ab",
"/assets/assets/cards/diamonds.png": "8d00c620cf28772dee080d099fe493fd",
"/assets/assets/cards/spades.png": "18b19b73201c028cd689a3d73dd39fb3",
"/assets/assets/cards/hearts.png": "bc61c3d70c614553d955a87eef629e9b",
"/assets/assets/cards/red/3.png": "9c88e16d6a15da1d63b7b9c9e25aab04",
"/assets/assets/cards/red/A.png": "7040a032a13f258e8841b6138c961467",
"/assets/assets/cards/red/9.png": "6d16501788e5453f10b8068b72cc807f",
"/assets/assets/cards/red/5.png": "75c3e595c593ec2b4f112996ed0a4064",
"/assets/assets/cards/red/10.png": "37bdcd6f58bc4c00d5ad5c38e004ddbf",
"/assets/assets/cards/red/8.png": "993d24bcb111fd27e24ad4ac839f0ac1",
"/assets/assets/cards/red/2.png": "23beadc1d0da5eb7369dde651914b949",
"/assets/assets/cards/red/4.png": "3de58be4041ad3d423268933e9b369de",
"/assets/assets/cards/red/6.png": "5566597c1709ab79a79a1478a1fbec13",
"/assets/assets/cards/red/J.png": "e289528cbc16b73e74579fe1a8d2a83b",
"/assets/assets/cards/red/7.png": "8c16b4a1a6d603e60037e24310958807",
"/assets/assets/cards/red/K.png": "3154ae4b2ebbf0ab2b0f0124d6985919",
"/assets/assets/cards/red/Q.png": "6d58321e4d31b0c4e8f3bdb228e9ac4d",
"/assets/assets/cards/clubs.png": "e38ea32b716f32c1fdb097eca844725b",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/manifest.json": "48d14d827cbff784d89b2ebdbb0ffcb2",
"/favicon.png": "5dcef449791fa27946b3d35ad8803796"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
