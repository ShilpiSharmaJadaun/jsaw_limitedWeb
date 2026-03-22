'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "f4a4ca3a95467df0c086338f2e9106ce",
"version.json": "fc77e6af408daca869bde77a958220b7",
"index.html": "2acdc5754bfe602cabad0d2d13a8603f",
"/": "2acdc5754bfe602cabad0d2d13a8603f",
"main.dart.js": "7fb95769eb93331fabb579bf6f1fcd5e",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "9f2e34fa5b1a5826d3b429a9805750b0",
"assets/AssetManifest.json": "546a9c3ad8fcd688f0a06dc5082cb105",
"assets/NOTICES": "a0b949d63498d25b83efb028c163efe5",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "df62a70bbb7ff869afec7dff425d3204",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "0a391017a0731d804a609b6f9eed2454",
"assets/fonts/MaterialIcons-Regular.otf": "eb6528e2a25c9b287efb43476f9d0587",
"assets/assets/images/jindal-saw-logo.png": "2f972e6fc9a6915f30406c23a487160d",
"assets/assets/images/category.png": "90a21e92f7b35f53d8a6968f08a47a16",
"assets/assets/images/observation.png": "11b4ec6109d911ec8246809dd9484ccd",
"assets/assets/images/plant.png": "a190d75b48551628b10c63f29818f727",
"assets/assets/images/jindal-saw-logo-removebg-preview.png": "085d1b04948504f74268c7ba4faf0eae",
"assets/assets/images/dashboard.png": "abc8c70844deb95fa6c05db129dcd8f2",
"assets/assets/images/pendingticket.png": "5b9897392b7097ba84f5e1541fa4d119",
"assets/assets/images/compareimage.png": "51d9ad24586e3da62bb2ed625480c399",
"assets/assets/images/employee-report.png": "b0129d05319c644918cb83110d86f3de",
"assets/assets/images/safetyportal.png": "31df27818de71770c6dcfda07a599ac4",
"assets/assets/images/suggestions.png": "fbc8c66bed58fe380a304bb5bbefbae4",
"assets/assets/images/approved.png": "2f30f0c3b1d7536720c1dc2116554c59",
"assets/assets/images/icons8-insta-48.png": "875597c968ee64e7cf5afbdec5f95278",
"assets/assets/images/calendar-3.png": "d585b6e855185a9e862151a62efedf1b",
"assets/assets/images/ticket.png": "1dff128f9ab1a131079e8353cb409475",
"assets/assets/images/hazard.png": "c48990003208418b3ad4ab343973eb4d",
"assets/assets/images/safety.png": "fa8cd03649e6a739e5394fbe04330048",
"assets/assets/images/changepassword.png": "98e34de4167a1659cc4a757b17aef6be",
"assets/assets/images/icons8-linkedin-48.png": "d2b6c44104204eb1644c41e0382b9656",
"assets/assets/images/complince.png": "5ae1e7c878d1155d5c27e5b7047f25e6",
"assets/assets/images/responsibility.png": "7bcaf481ee8f06f550bd979c105d61f4",
"assets/assets/images/raise_observation.png": "5198f1b8026760f86d2bc7e5e94a5c50",
"assets/assets/images/graph.png": "45b391d7d34b10ea85970ffc289903ca",
"assets/assets/images/uniqueid.png": "0b19f6554c8080eef5c630681f8b491b",
"assets/assets/images/raisedby.png": "aa0aa8b69de3f47b1ddc64dcda5e1463",
"assets/assets/images/ticketimage.jpg": "fe7898d9566be7f65165d29827b8678c",
"assets/assets/images/worker.png": "7eea728d33388a0fc917e5c5491e312d",
"assets/assets/images/createcompany.png": "e15ed4d11b75feee217d7d17a8790698",
"assets/assets/images/date.png": "b2c6098c212e8e922e2366c51d517869",
"assets/assets/images/adhyamLogo.png": "e6e707183cac36c195d095ee7af14d63",
"assets/assets/images/instagramcolor.png": "0b6b3c8d2c74fc2e0be8f5d940ec1e14",
"assets/assets/images/peopleimage.jpg": "0f835e7f9e843332480d675051ea97ad",
"assets/assets/images/safetyai.jpg": "26b4b60d2835eb3148488e2eb2f4a95a",
"assets/assets/images/profile.jpg": "349a38eb928f99f15992c0bbbad54d6b",
"assets/assets/images/location.png": "937b4194e547a1decc3e81a38e7e33d8",
"assets/assets/images/tagetdate.png": "458cdb0a2a2e294f685f8d2751072a15",
"assets/assets/images/ticketcomplete.png": "413986afda019f3b4ad02f9f43a3b30e",
"assets/assets/images/writeUs.png": "bd98ee414550e5be6186ac7d3db31ab0",
"assets/assets/images/cancelticket.png": "0b0363c462340a71f7b8ad38d6fb2dd2",
"assets/assets/images/excelicon.png": "727de60754cedcf0e0e3c2e4819d0ad2",
"assets/assets/images/icons8-facebook-48.png": "ceda85dc6354796fd08c69a2032d2b29",
"assets/assets/images/facebook.png": "24de0499bfe09d83eb302a3958c37a5b",
"assets/assets/images/icons8-youtube-48.png": "ca52040004058032766383ad85952220",
"assets/assets/lottie/loading.json": "9b7d2f64714a76dbdd3b98b40b6a2170",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
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
