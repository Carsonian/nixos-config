#{ inputs, outputs, lib, config, pkgs, ... }: {
{ pkgs, ...}: {

  # Also add manually...
  # For proper sizing on laptop: layout.css.devPixelsPerPx 1.2
  # For ublock origin to block google signin popups: accounts.google.com/gsi/*
  programs.firefox = {
    enable = true;
    profiles.carson = {
      name = "carson";
      isDefault = true;
      settings = {
        # Good resource: https://arkenfox.github.io/gui/
        # Don't warn for about:config changes
        "browser.aboutConfig.showWarning" = false;

        # Start page
        "browser.startup.page" = 0;
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.showRecentSaves" = false;
        "browser.newtabpage.activity-stream.discoverystream.recentSaves.enabled" = false;

        # Annoyances
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shopping.experience2023.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "browser.startup.homepage_override.mstone" = "ignore";

        # Search bar
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.trending.featureGate" = false;

        # Passwords 
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;

        # Set dark theme
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        
        # Set region
        "browser.search.region" = "en-CA";
        "distribution.searchplugins.defaultLocale" = "en-CA";
        "general.useragent.locale" = "en-CA";

        # Https only mode
        "dom.security.https_only_mode" = true;

        # Set Enhanced tracking protection to strict
        "browser.contentblocking.category" = "strict";
        
        # Tracking protections
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;

        # Safe Browsing
        "browser.safebrowsing.malware.enabled" = true;
        "browser.safebrowsing.phishing.enabled" = true;
        "browser.safebrowsing.downloads.enabled" = true;
      };
      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          # Custom search engines
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "My NixOS" = {
            urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@mn" ];
          };

          # Remove bad search options
          "Bing".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "Amazon".metaData.hidden = true;
        };
      };
    };
  };
}
