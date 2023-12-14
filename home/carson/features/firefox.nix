{ pkgs, config, ...}:

{
  programs.firefox = {
    enable = true;
    profiles.carson = {
      bookmarks = [
        {
          name = "Nixpkgs";
          url = "https://search.nixos.org/packages";
        }
        {
          name = "My NixOS";
          url = "https://mynixos.com/";
        }
        {
          name = "GitHub";
          url = "https://github.com/";
        }
      ];
      extensions = with pkgs.inputs.firefox-addons; [
        ublock-origin
        bitwarden
      ];
      # add this for proper sizing on laptop
      # layout.css.devPixelsPerPx 1.2
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

        # Remove bing and google
        "Bing".metaData.hidden = true;
        "Google".metaData.hidden = true;
      };
    };
  };

  # Ublock setup
  home.file.".mozilla/managed-storage/uBlock0@raymondhill.net.json".text = builtins.toJSON {
    name = "uBlock0@raymondhill.net";
    description = "_";
    type = "storage";
    data = {
      adminSettings =
        { userFilters = ''accounts.google.com/gsi/*''; };
      userSettings = [
        [ "advancedUserEnabled" "true" ]
        [ "autoUpdate" "true" ]
        [ "colorBlindFriendly" "true" ]
        [ "contextMenuEnabled" "true" ]
        [ "dynamicFilteringEnabled" "false" ] ];
      toOverwrite = {
        filterLists = [
          # Builtins
          "user-filters"
          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-quick-fixes"
          "ublock-abuse"
          "ublock-unbreak"

          "easylist" # Ads
          
          "easyprivacy" # Privacy

          "ublock-annoyances"          
          
          "urlhaus-1" # Malware protection, security

          "plowe-0" # Multipurpose
          
          "adguard-cookiemonster"
          "ublock-cookies-adguard"
          "fanboy-cookiemonster"
          "ublock-cookies-easylist"
          "https://raw.githubusercontent.com/liamengland1/miscfilters/master/antipaywall.txt"
          "https://gitlab.com/magnolia1234/bypass-paywalls-clean-filters/-/raw/main/bpc-paywall-filter.txt"]; }; }; };
}
