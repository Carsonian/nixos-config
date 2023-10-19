{ inputs, outputs, pkgs, ... }: {
  
  environment.systemPackages = 
    let
      # Install python packages here
      my-python-packages = ps: with ps; [
        pandas
        #requests
          # other python packages
      ];

    in with pkgs; [
      # This installs python 3 with all the packages listed above
      (python3.withPackages my-python-packages)
    ];
}

