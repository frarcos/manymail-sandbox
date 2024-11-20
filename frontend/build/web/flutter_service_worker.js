'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "f832c3d528699482451e6aee6c95eec8",
"assets/AssetManifest.bin.json": "056300d04db78213152e7da08cd197ea",
"assets/AssetManifest.json": "95049117174dde8bea5902d5f4d2b79e",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-Black.ttf": "4cff70e430fb4667ec3e6725e055f8ec",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-BlackItalic.ttf": "1d755f6d3a8c0b5ed94247426859e427",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-Bold.ttf": "48bbc99d88e5c99a2bc2780f28c137e3",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-BoldItalic.ttf": "59aee15fc3d0ac11a5280818c7ce6d72",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-ExtraBold.ttf": "4902e830ee5797b9a61ccc74b339eed3",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-ExtraBoldItalic.ttf": "8f4c098fbc45469f32d24230dfd7895c",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-ExtraLight.ttf": "18be20ca8d219993704166a765fce6f2",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-ExtraLightItalic.ttf": "d60459b288d6b58ad661a959faab6f61",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-Italic.ttf": "52f09ed3ec190ea686cd01f30a700248",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-Light.ttf": "4880b6055406c3d07487cbcf665f4d39",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-LightItalic.ttf": "51e22ee36cfb5db389b1f30ea89a026e",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-Medium.ttf": "1ac40fd79ee227d1457f552b22828aa3",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-MediumItalic.ttf": "8638b4e3b0db3590882816ce93b5c757",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-Regular.ttf": "ec23619ef59c67e6a69719e8f0780a7e",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-SemiBold.ttf": "205935f41af371be49ba31b51187e36f",
"assets/assets/fonts/Be_Vietnam_Pro/BeVietnamPro-SemiBoldItalic.ttf": "86e97692e8fb20c606170bfcb6fbcb82",
"assets/assets/fonts/Inter/static/Inter-Black.ttf": "118c5868c7cc1370fcf5a1fc2f569883",
"assets/assets/fonts/Inter/static/Inter-Bold.ttf": "ba74cc325d5f67d0efbeda51616352db",
"assets/assets/fonts/Inter/static/Inter-ExtraBold.ttf": "72ac147c98056996b2a31e95a56d6e66",
"assets/assets/fonts/Inter/static/Inter-ExtraLight.ttf": "7a177fa21fece72dfaa5639d8f1c114a",
"assets/assets/fonts/Inter/static/Inter-Light.ttf": "a3fe4e0f9fdf3119c62a34b1937640dd",
"assets/assets/fonts/Inter/static/Inter-Medium.ttf": "cad1054327a25f42f2447d1829596bfe",
"assets/assets/fonts/Inter/static/Inter-Regular.ttf": "ea5879884a95551632e9eb1bba5b2128",
"assets/assets/fonts/Inter/static/Inter-SemiBold.ttf": "465266b2b986e33ef7e395f4df87b300",
"assets/assets/fonts/Inter/static/Inter-Thin.ttf": "4558ff85abeab91af24c86aab81509a7",
"assets/assets/images/logos/logo.png": "d6c71b41b66188ebd275649cb1ca7fff",
"assets/assets/translations/en.json": "78262dd80a6eb1139941e94de0183028",
"assets/assets/translations/it.json": "78262dd80a6eb1139941e94de0183028",
"assets/FontManifest.json": "dd76348d691cb9297e6e3fd6debf9f16",
"assets/fonts/MaterialIcons-Regular.otf": "83d2872a2e3d85ff96b715dafeabf87c",
"assets/NOTICES": "6ee32830b1128bf65a063a9902cf89c5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "391ff5f9f24097f4f6e4406690a06243",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "dfed25ac2b07de3f33093d5dbf32ec28",
"icons/android-icon-144x144.png": "29b7923d6c061a26f1cdbed7965f5459",
"icons/android-icon-192x192.png": "342aedd54b9d61706302f8fef4ba6bf0",
"icons/android-icon-36x36.png": "b0a4c29a4239617e88cf81c74fc2af0d",
"icons/android-icon-48x48.png": "8b813e00f092aa2cbe3e89319afa4a62",
"icons/android-icon-72x72.png": "63782cfd3cb10b6a5c0153f9746203b8",
"icons/android-icon-96x96.png": "8ddbbcdec6780e46446ad30c45c51955",
"icons/apple-icon-114x114.png": "441e105c07353a6ac89466d36bba29c8",
"icons/apple-icon-120x120.png": "cb2a9b343a988644834ba4380d0b77d2",
"icons/apple-icon-144x144.png": "29b7923d6c061a26f1cdbed7965f5459",
"icons/apple-icon-152x152.png": "f3579894713ef1f3432b6cea26841de2",
"icons/apple-icon-180x180.png": "985ef9cb172605e8336249d365cfc7ae",
"icons/apple-icon-57x57.png": "36c003476669fc66ad685fbb81f12dc4",
"icons/apple-icon-60x60.png": "87b857f6c02576eb336717d112cd423d",
"icons/apple-icon-72x72.png": "63782cfd3cb10b6a5c0153f9746203b8",
"icons/apple-icon-76x76.png": "61ae12743d72243a9bb95849e9d66365",
"icons/apple-icon-precomposed.png": "44ecd5cfa22e293fb458061daa35e038",
"icons/apple-icon.png": "44ecd5cfa22e293fb458061daa35e038",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/favicon-16x16.png": "ec322765fa493cdb30f403a4eb50556f",
"icons/favicon-32x32.png": "30a7f731d8da9015ba62fd15c474929f",
"icons/favicon-96x96.png": "8ddbbcdec6780e46446ad30c45c51955",
"icons/favicon.ico": "82611f8c7c3115fdf9ce6b3b06e56611",
"icons/ms-icon-144x144.png": "29b7923d6c061a26f1cdbed7965f5459",
"icons/ms-icon-150x150.png": "2a0754d2022da58b75ed07d26154c198",
"icons/ms-icon-310x310.png": "d33b71a08d60a644815765c2860c7bcc",
"icons/ms-icon-70x70.png": "4d35eb1b906b4b9d934235801eb63791",
"index.html": "cf170056d024663d6ee0347ad96531f0",
"/": "cf170056d024663d6ee0347ad96531f0",
"main.dart.js": "8e28c430229e3ea70b7a98ec4ea2e5b5",
"manifest.json": "c12ea7ff69b88b126885cf7cc6ac5b53",
"version.json": "3d24ab74c8c81380d4ef236af119f5df"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
  for (var resourceKey of Object.keys(RESOURCES)) {
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
