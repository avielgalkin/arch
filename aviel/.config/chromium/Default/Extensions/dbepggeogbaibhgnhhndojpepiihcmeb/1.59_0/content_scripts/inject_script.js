// Generated by CoffeeScript 1.9.3
(function() {
  var fetchFileContents, i, injectScripts, len, script, scriptEl;

  injectScripts = ["pages/addEventListener_hook.js"];

  fetchFileContents = function(extensionFileName) {
    var req;
    req = new XMLHttpRequest();
    req.open("GET", chrome.runtime.getURL(extensionFileName), false);
    req.send();
    return req.responseText;
  };

  for (i = 0, len = injectScripts.length; i < len; i++) {
    script = injectScripts[i];
    scriptEl = document.createElement("script");
    scriptEl.innerHTML = fetchFileContents(script);
    document.documentElement.insertBefore(scriptEl, document.documentElement.firstElementChild);
  }

}).call(this);
