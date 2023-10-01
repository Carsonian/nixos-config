{
  programs.firefox = {
  enable = true;
  profiles.carson = {
    bookmarks = { };
    extensions = with pkgs.inputs.firefox-addons; [
      ublock-origin
      bitwarden
    ];
    settings = {
      "browser.search.region" = "en-CA";
      "distribution.searchplugins.defaultLocale" = "en-CA";
      "general.useragent.locale" = "en-CA";
      "browser.download.panel.shown" = true;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.shell.defaultBrowserCheckCount" = 1;
      "browser.startup.homepage" = "https://start.duckduckgo.com";
      "dom.security.https_only_mode" = true;
      "identity.fxaccounts.enabled" = false;
      "privacy.trackingprotection.enabled" = true;
      "signon.rememberSignons" = false;

      # Actual settings
      "app.shield.optoutstudies.enabled" = false;
      "app.update.auto" = false;
      "browser.bookmarks.restore_default_bookmarks" = false;
      "browser.contentblocking.category" = "strict";
      "browser.ctrlTab.recentlyUsedOrder" = false;
      "browser.discovery.enabled" = false;
      "browser.laterrun.enabled" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" =
        false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" =
        false;
      "browser.newtabpage.activity-stream.feeds.snippets" = false;
      "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
      "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
      "browser.newtabpage.activity-stream.section.highlights.includePocket" =
        false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.pinned" = false;
      "browser.protections_panel.infoMessage.seen" = true;
      "browser.quitShortcut.disabled" = true;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.ssb.enabled" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.urlbar.placeholderName" = "DuckDuckGo";
      "browser.urlbar.suggest.openpage" = false;
      "datareporting.policy.dataSubmissionEnable" = false;
      "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
      "dom.security.https_only_mode" = true;
      "dom.security.https_only_mode_ever_enabled" = true;
      "extensions.getAddons.showPane" = false;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
      "extensions.pocket.enabled" = false;
      "identity.fxaccounts.enabled" = false;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
    };
  };
  search = {
    force = true;
    default = "DuckDuckGo";
    engines = {
      # Custom search engines
      {
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

        "NixOS Wiki" = {
          urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
          iconUpdateURL = "https://nixos.wiki/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [ "@nw" ];
        };

        # Remove bing and google
        "Bing".metaData.hidden = true;
        "Google".metaData.hidden = true;
      }
    };
  };

  # Doesn't work in home manager, make sure they are in the above settings
  extraPolicies = {
    CaptivePortal = false;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFirefoxAccounts = false;
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;
    OfferToSaveLoginsDefault = false;
    PasswordManagerEnabled = false;
    FirefoxHome = {
      Search = true;
      Pocket = false;
      Snippets = false;
      TopSites = false;
      Highlights = false;
    };
    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };
  };
