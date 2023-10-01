{
  programs.firefox = {
  enable = true;
  profiles.misterio = {
    bookmarks = { };
    extensions = with pkgs.inputs.firefox-addons; [
      ublock-origin
      bitwarden
    ];
    settings = {
      "browser.disableResetPrompt" = true;
      "browser.download.panel.shown" = true;
      "browser.download.useDownloadDir" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.shell.defaultBrowserCheckCount" = 1;
      "browser.startup.homepage" = "https://start.duckduckgo.com";
      "dom.security.https_only_mode" = true;
      "identity.fxaccounts.enabled" = false;
      "privacy.trackingprotection.enabled" = true;
      "signon.rememberSignons" = false;
    };
  };
  search = {
    force = true;
    default = "Searx";}

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
