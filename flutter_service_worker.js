'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "7877db4dc42911db52eeaf51e98fc0c4",
"assets/assets/images/ember-72.png": "37fad92bb22d09dbad824c813467f000",
"assets/assets/images/ember_ul-7.png": "61996353390edf7b11d1752053bc68ab",
"assets/assets/images/ember-64.png": "6eec58da17641a353ef70f83376e31ed",
"assets/assets/images/ember-14.png": "838b3f62c15ffeb27b076471938a1398",
"assets/assets/images/ember-75.png": "b0feab0f96b386b370566c5489d84f2c",
"assets/assets/images/ember-41.png": "7654e66806687652bfe50b7a6ed58637",
"assets/assets/images/ember-77.png": "e2104d474857f73c36d79222de496b83",
"assets/assets/images/logo.png": "dbf641e7558ceec5891adebfaa7ae56f",
"assets/assets/images/ember-68.png": "25733e20f7b840ee7d8dc9991df275ec",
"assets/assets/images/ember-71.png": "ae8243f0d79a0c597b0f352feb4817d9",
"assets/assets/images/ember-1.png": "e643e6b4fa9396b3d80027c07600b288",
"assets/assets/images/ember-100.png": "18c088aa72ca1543fb07d7d91411421e",
"assets/assets/images/ember-52.png": "104054239c90ea425e795491d0992be0",
"assets/assets/images/claw3.png": "5d2b3191d53b9b652f67ab3e4ccc9db7",
"assets/assets/images/ember-88.png": "0fadc8490531ce8beda17a95a2b47a51",
"assets/assets/images/ember-30.png": "7335969bf133def32be60fb2ed147cf7",
"assets/assets/images/ember-89.png": "f98197113a4ae78b8212717fe55e384b",
"assets/assets/images/ember-24.png": "de8e565a6b2f169bb1e2cb322a8995fd",
"assets/assets/images/ember-69.png": "91e4a066f3306faf220c729b5a2295cd",
"assets/assets/images/ember-16.png": "fc8d7cb615b13a0038a4cb8424df7be9",
"assets/assets/images/ember_ul-4.png": "7ebb8fd8aff9dfe146f766a614db8526",
"assets/assets/images/futoszalag.png": "23ec11fc2ef95c6bff5015d1b6219413",
"assets/assets/images/ember-44.png": "1a5a0da84a69419b750d81872831d7a0",
"assets/assets/images/ember-3.png": "23d13ff69849b61164a4a260c95050e7",
"assets/assets/images/ember-73.png": "0be92768baeec18a1d143ac828b97949",
"assets/assets/images/ember-18.png": "20c6bcafbf67c9fc16630b1e8416c0e4",
"assets/assets/images/ember-37.png": "d615b97b13c301710941da81622a2ec9",
"assets/assets/images/ember-40.png": "567dd029b604bcda5cd7e7531bdb921d",
"assets/assets/images/ember_ul-8.png": "1c5e74e265f3d9de61df0128e4966093",
"assets/assets/images/ember_ul-1.png": "3d008aee657b9a23e6bf74d652dc81db",
"assets/assets/images/ember-85.png": "6f61fb5bbe4519860bcca4dc032a2dcf",
"assets/assets/images/ember-55.png": "c38cdaae64ad604e11948f99caf92526",
"assets/assets/images/ember-27.png": "2c401b0dc2c8c6309a2e2fbb3847306e",
"assets/assets/images/ember-25.png": "7ebb8fd8aff9dfe146f766a614db8526",
"assets/assets/images/ember-76.png": "61996353390edf7b11d1752053bc68ab",
"assets/assets/images/ember-80.png": "e8e1e5db946e741f46d265d6ddf33f63",
"assets/assets/images/ember-48.png": "3fa3bfb6d40b02d7bfbe2435757810d4",
"assets/assets/images/ember-97.png": "1abdb61635f7449dbc8ee2827ad0abf0",
"assets/assets/images/ember-33.png": "900437f0ebe0152fea8ae9a47b9ea6ac",
"assets/assets/images/ember-8.png": "e247614c836326fe504655e8092be31e",
"assets/assets/images/ember-54.png": "c3f2530dfe3ea328b4a640d81ab0c71e",
"assets/assets/images/ember_jegy-3.png": "9de526c2583022a40d7f51d705327a1c",
"assets/assets/images/ember-7.png": "f21f3da9f0307b2107df9af501741f7b",
"assets/assets/images/ember-47.png": "345a3a3783a172c091623769ce6a16ce",
"assets/assets/images/ember-29.png": "beef2c006ccf440a75576c63a81256d0",
"assets/assets/images/ember-51.png": "31c839d6f9451f2221c20236f2db4a81",
"assets/assets/images/ember-26.png": "02b2872f98d11d983642d07177e84239",
"assets/assets/images/ember-39.png": "ce123d9831dbde5e8bf1ca1b6e60c218",
"assets/assets/images/ember-21.png": "1c0088af60f6bd67dab33a1971c3dd34",
"assets/assets/images/ember_ul-6.png": "8945770c60753d4bac3e6170d10de07f",
"assets/assets/images/ember_ul-2.png": "18c088aa72ca1543fb07d7d91411421e",
"assets/assets/images/ember_jegy-4.png": "020bc98c9953b34746c6240c62f9965e",
"assets/assets/images/ember_jegy-5.png": "963a7832761f029d8ca321b99bddc33a",
"assets/assets/images/claw4.png": "7dee53e5fc4d1a2f4fb273066c3d1125",
"assets/assets/images/ember-59.png": "9f04fd9d359f280d6fed09417e293577",
"assets/assets/images/ember-9.png": "6ad27cf681835c705ca256654e8adf96",
"assets/assets/images/ember-38.png": "f8430845aa6786418a1f62b8eea02e69",
"assets/assets/images/ember-70.png": "876ced3fa8bb22cc78f4314484845b4b",
"assets/assets/images/ember-15.png": "6fa255c588e541ea64cf0bd2ddb5e1da",
"assets/assets/images/ember-36.png": "8b229831bb314b9b358c58295386ca8c",
"assets/assets/images/ember-94.png": "1971740b4234ceb9cb5b01d2f1431147",
"assets/assets/images/claw.png": "92419c66288f939461283734698889c4",
"assets/assets/images/ember_ul-9.png": "7feb257535603597b53a3ec75490cacc",
"assets/assets/images/ember-99.png": "e0dd708bb3eba854fdbda021efb89c49",
"assets/assets/images/ember-53.png": "5895bbb46cb6a5852f5bf7b6115fa412",
"assets/assets/images/ember-13.png": "020bc98c9953b34746c6240c62f9965e",
"assets/assets/images/ember-87.png": "17e3558dff190524608a495cf3447d78",
"assets/assets/images/ember-34.png": "618557a1065b0a76d186d9dc3a5b46f1",
"assets/assets/images/ember-28.png": "51d48ac26fa675a1f69bceb002d80b56",
"assets/assets/images/ember-42.png": "0ae30c209ae8b2f9ea1d85a014c3aa9a",
"assets/assets/images/ember_ul-3.png": "900437f0ebe0152fea8ae9a47b9ea6ac",
"assets/assets/images/claw2.png": "f7389d3f26f839a644aa5dad694b7f7e",
"assets/assets/images/ember-35.png": "396bfe28d1d8017b6087b2fd3789b41c",
"assets/assets/images/ember-81.png": "48a0392683b3fb05289afb625ddf26d1",
"assets/assets/images/ember-19.png": "30621c0da36b727e1dd5b118a11d6fb4",
"assets/assets/images/ember-45.png": "5ea64a84873553b81786ac43e7d54c85",
"assets/assets/images/ember-63.png": "45336d318db231b23d6da83704411f9d",
"assets/assets/images/ember-10.png": "3d008aee657b9a23e6bf74d652dc81db",
"assets/assets/images/ember-67.png": "8f13c73e0e17ee17011df7c50ac894ee",
"assets/assets/images/ember-56.png": "ad73c5cfea53248b4321277d5f0b91f6",
"assets/assets/images/ember-98.png": "038bc0f12ec19a4e9c198a482fa4554d",
"assets/assets/images/ember-91.png": "a1b47bf035535af06da817931ff80ecb",
"assets/assets/images/ember_jegy-6.png": "48107db7a9873946157d4dc0887e1f97",
"assets/assets/images/ember-84.png": "cc327eae230b43d3e1aabb3dc0c0446f",
"assets/assets/images/ember-22.png": "b8f207a70006181f46a14d21d77bfae2",
"assets/assets/images/ember-74.png": "8945770c60753d4bac3e6170d10de07f",
"assets/assets/images/ember-96.png": "bb18522aa6cb9725ad4c36e1a86f73ef",
"assets/assets/images/ember-57.png": "43f04037d50d461bdfcc4abe77ea1eb5",
"assets/assets/images/ember-79.png": "4f5b0e763cb349ee12d3d4002744df7e",
"assets/assets/images/ember-58.png": "9b84aaa5d7ba2af72707579d40b173c4",
"assets/assets/images/ember-65.png": "59ff3b8630b96beccf2d083e7b5a9c0d",
"assets/assets/images/ember-60.png": "ccb70a7891207f2b7038076bdd5f25f9",
"assets/assets/images/ember-46.png": "823ff00b3f8bb3c0597666fb1f0ec0ed",
"assets/assets/images/ember-90.png": "1c5e74e265f3d9de61df0128e4966093",
"assets/assets/images/ember-6.png": "9de526c2583022a40d7f51d705327a1c",
"assets/assets/images/ember-78.png": "963a7832761f029d8ca321b99bddc33a",
"assets/assets/images/crane.png": "78b640e0b6f9f11039b920c1cb20d83a",
"assets/assets/images/ember-2.png": "2525e80c15286cfd4d1bc454ea03be1b",
"assets/assets/images/elek.png": "7877db4dc42911db52eeaf51e98fc0c4",
"assets/assets/images/ember-92.png": "de3cc6d9f628531275c2f2f3baeb88ca",
"assets/assets/images/ember-62.png": "46a3999f04d308fcbe1b53b1a71b45c2",
"assets/assets/images/ember-43.png": "cb18ea30e8ea2169e9737e1f2d7b956e",
"assets/assets/images/ember_ul-5.png": "9f04fd9d359f280d6fed09417e293577",
"assets/assets/images/claw1.png": "36e53adca7ccf758aa3108789cb3f9c5",
"assets/assets/images/ember_jegy-2.png": "d615b97b13c301710941da81622a2ec9",
"assets/assets/images/hatter-02.png": "f82d84887a73f1cc49046d1685484cc7",
"assets/assets/images/ember-61.png": "83dfe4710e6c5638ceae9f0135df0a44",
"assets/assets/images/elek2.png": "bc70e7c5c8148d9fd38dda8844ad46d1",
"assets/assets/images/ember-83.png": "5f99c0a54b0804cd8537c2b5df211f3e",
"assets/assets/images/ember-23.png": "51e896ac3e27fa7c82cfa1c74ead3077",
"assets/assets/images/ember-93.png": "ad2ec01d9db210fc2a55789c96064da6",
"assets/assets/images/ember-66.png": "2000b219181d9cd3c7772839f79dd7f6",
"assets/assets/images/ember-20.png": "5cf872103770052a2f660394bc5c8580",
"assets/assets/images/ember-5.png": "592c2d23ff1120ae15fef0d5facafa0f",
"assets/assets/images/ember-11.png": "d157de504069563e5de553c747fc2dfa",
"assets/assets/images/ember-4.png": "82eef9e82d6f5631c105ec28ff75f9d1",
"assets/assets/images/ember-17.png": "8d4e1c3abf82c31d4fd55ba68624874a",
"assets/assets/images/ember-32.png": "72020c4079841648bd2c644f70dd9b70",
"assets/assets/images/ember-82.png": "7feb257535603597b53a3ec75490cacc",
"assets/assets/images/ember-86.png": "c7c628da54047864d4b9ce4642eff700",
"assets/assets/images/ember_jegy-1.png": "31c839d6f9451f2221c20236f2db4a81",
"assets/assets/images/ember-95.png": "601c3804d76775608fb789f9decadf0d",
"assets/assets/images/ember-12.png": "389c35d5569de20de59bededc501648b",
"assets/assets/images/ember-49.png": "35d3d6757eca2f3a8c831c66ff761d7e",
"assets/assets/images/ember-31.png": "ea307a320abc11dad2d99fc4f3705ef2",
"assets/assets/langs/en.json": "6b3cc4b14a12424f1a57f93638b1ef3c",
"assets/assets/langs/hu.json": "142a404ee4ea5c1c18b789f9773afc4f",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "85adb6a7bd23e818847d7e7c8ed02f52",
"assets/FontManifest.json": "a5bb8ca5e9ca93854e28f317e41ebc2d",
"assets/packages/flutter_auth_buttons/fonts/Roboto-Medium.ttf": "d08840599e05db7345652d3d417574a9",
"assets/packages/flutter_auth_buttons/graphics/google-logo.png": "6937ba6a7d2de8aa07701225859ae402",
"assets/packages/flutter_auth_buttons/graphics/flogo-HexRBG-Wht-100.png": "5037e86e017c472bb7f66d991a97d57a",
"assets/packages/flutter_auth_buttons/graphics/ms-symbollockup_mssymbol_19.png": "0c29638c7558632a1a5f053d344405ba",
"assets/packages/flutter_auth_buttons/graphics/Twitter_Logo_Blue.png": "fef946b8bba756359e2a1e87ccd915ea",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "d21f791b837673851dd14f7c132ef32e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "bdd8d75eb9e6832ccd3117e06c51f0d3",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "3ca122272cfac33efb09d0717efde2fa",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "9a62a954b81a1ad45a58b9bcea89b50b",
"assets/AssetManifest.json": "cb01ef1458b62f55e81b84967c18b1f3",
"main.dart.js": "1718d15ffa5b630716b90ea92c3764b3",
"version.json": "614c0217bede38d00951cdbb2a7ba12f",
"index.html": "159f955ef4907fcc0ee93b688ec71af2",
"/": "159f955ef4907fcc0ee93b688ec71af2"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
