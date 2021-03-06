// Generated by CoffeeScript 1.11.0
(function() {
  var Vomnibar, root;

  Vomnibar = {
    vomnibarUI: null,
    extractOptionsFromRegistryEntry: function(registryEntry, callback) {
      return typeof callback === "function" ? callback(extend({}, registryEntry.options)) : void 0;
    },
    activate: function(sourceFrameId, registryEntry) {
      return this.extractOptionsFromRegistryEntry(registryEntry, (function(_this) {
        return function(options) {
          return _this.open(sourceFrameId, extend(options, {
            completer: "omni"
          }));
        };
      })(this));
    },
    activateInNewTab: function(sourceFrameId, registryEntry) {
      return this.extractOptionsFromRegistryEntry(registryEntry, (function(_this) {
        return function(options) {
          return _this.open(sourceFrameId, extend(options, {
            completer: "omni",
            newTab: true
          }));
        };
      })(this));
    },
    activateTabSelection: function(sourceFrameId) {
      return this.open(sourceFrameId, {
        completer: "tabs",
        selectFirst: true
      });
    },
    activateBookmarks: function(sourceFrameId) {
      return this.open(sourceFrameId, {
        completer: "bookmarks",
        selectFirst: true
      });
    },
    activateBookmarksInNewTab: function(sourceFrameId) {
      return this.open(sourceFrameId, {
        completer: "bookmarks",
        selectFirst: true,
        newTab: true
      });
    },
    activateEditUrl: function(sourceFrameId) {
      return this.open(sourceFrameId, {
        completer: "omni",
        selectFirst: false,
        query: window.location.href
      });
    },
    activateEditUrlInNewTab: function(sourceFrameId) {
      return this.open(sourceFrameId, {
        completer: "omni",
        selectFirst: false,
        query: window.location.href,
        newTab: true
      });
    },
    init: function() {
      return this.vomnibarUI != null ? this.vomnibarUI : this.vomnibarUI = new UIComponent("pages/vomnibar.html", "vomnibarFrame", function() {});
    },
    open: function(sourceFrameId, options) {
      if (this.vomnibarUI != null) {
        HelpDialog.abort();
        return this.vomnibarUI.activate(extend(options, {
          name: "activate",
          sourceFrameId: sourceFrameId,
          focus: true
        }));
      }
    }
  };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.Vomnibar = Vomnibar;

}).call(this);
