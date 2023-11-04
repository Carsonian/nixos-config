{ inputs, outputs, pkgs, ... }: {
  
  environment.systemPackages = 
    let
      # Install python packages here
      my-python-packages = ps: with ps; [
        pip
        flake8
        pandas
        #requests
        # other python packages
        matplotlib
        tabulate
        
      ];

    in with pkgs; [
      # This installs python 3 with all the packages listed above
      (python311.withPackages my-python-packages)
    ];
}

