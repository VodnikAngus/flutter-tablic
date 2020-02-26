'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/assets/assets/cards/hearts.png": "77728a1d52c3da49a5f5762485d98af7",
"/assets/assets/cards/diamonds.png": "3c6962c0cb7fea2d537c534acc536d91",
"/assets/assets/cards/black/3.png": "7ebbbe1477abbd5677b0cd52567a3131",
"/assets/assets/cards/black/4.png": "cc236a3e6fa908bf602c37c49faa8a2c",
"/assets/assets/cards/black/A.png": "a0516b454840869cb977a8bf60fa3370",
"/assets/assets/cards/black/10.png": "773fae283802a46634764652f5f8a562",
"/assets/assets/cards/black/6.png": "ce6a27856cba6fa6cf208d59a14781e1",
"/assets/assets/cards/black/8.png": "cd0d407187595a15c3317a80d0ba9aaa",
"/assets/assets/cards/black/7.png": "d72b345f3bf7c4936b24520ace64b9cf",
"/assets/assets/cards/black/9.png": "6cf81f1f0a8c6ded9b7777a618c2c69d",
"/assets/assets/cards/black/5.png": "3f404baba4fa1298f2113c250aeae4d5",
"/assets/assets/cards/black/K.png": "938c36c85e05fc0fde599fdfcadb2614",
"/assets/assets/cards/black/Q.png": "9ec99fdcda44210e453b5851fea93832",
"/assets/assets/cards/black/J.png": "08c4f99414da5043deee683a372d9351",
"/assets/assets/cards/black/2.png": "ec2113aacb728ed536f4a3777da4f172",
"/assets/assets/cards/spades.png": "5b9285e48782e7fb8e842daebafd4fae",
"/assets/assets/cards/clubs.png": "a86818063d86b325b6b82b90302f1f0b",
"/assets/assets/cards/red/3.png": "ff67785f577514cac81a5b6efba0fc04",
"/assets/assets/cards/red/4.png": "cd7410a9b6a2e23bd3d4f336c2851500",
"/assets/assets/cards/red/A.png": "44110954ab5853814f289eb7d69ddb1e",
"/assets/assets/cards/red/10.png": "df1177cb91287c5e145017454bbe2e01",
"/assets/assets/cards/red/6.png": "a419ddbeea3371c5837c10596a9ef571",
"/assets/assets/cards/red/8.png": "a2df150406870cfb80890a2923a57eab",
"/assets/assets/cards/red/7.png": "d3b7e9ec9bf6b5c255c5c70eefd414ca",
"/assets/assets/cards/red/9.png": "e2f6f6384646b3aa48f0612e078d86f8",
"/assets/assets/cards/red/5.png": "8d45e253b507562a1502437d94f38b79",
"/assets/assets/cards/red/K.png": "f36d412ad0e761f62034aac607e0ddd4",
"/assets/assets/cards/red/Q.png": "b39f29382e37511167f5d4a9399609c0",
"/assets/assets/cards/red/J.png": "418098874d81695050d9f017d98d1574",
"/assets/assets/cards/red/2.png": "c173b49b103f938eafc4680c62d81a6f",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/LICENSE": "35d1f0fc3475fa318e52e0e2efcb9c5e",
"/assets/AssetManifest.json": "5f2171fed2c03ced1c2d33b67f932cec",
"/assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"/index.html": "8f6e81b3c718ff1448dc449f7a853ec7",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/main.dart.js": "866329ba91e872624cfe96aba05df775",
"/manifest.json": "48d14d827cbff784d89b2ebdbb0ffcb2"
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
