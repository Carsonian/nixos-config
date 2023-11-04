{ inputs, outputs, pkgs, ... }: {

  # Enable metabase
  services.metabase.enable = true;

  # Set metabase plugins directory to ~/.metabase
  environment.sessionVariables = rec {
    MB_PLUGINS_DIR  = "$HOME/.metabase";
  };

  # Get metabase csv plugin from github and put in plugins dir
  home.file."/.metabase/csv.metabase-driver.jar".source = 
    builtins.fetchGit {
      url = "https://github.com/Markenson/csv-metabase-driver/blob/master/release/csv.metabase-driver.jar";
      rev = "15c22f21a57b597abc4697ae5bcc3c3b41d74dd9";
    } + "/release/csv.metabase-driver.jar";
  
  
}
