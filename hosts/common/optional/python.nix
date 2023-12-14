{ inputs, outputs, pkgs, ... }: {
  
  environment.systemPackages = 
    let
      # Install python packages here
      my-python-packages = ps: with ps; [
        pip
        setuptools
        flake8
        pandas
        #requests
        sqlalchemy
        plotly
        dash
        streamlit
        # other python packages
        matplotlib
        tabulate
        
      ];

    in with pkgs; [
      # This installs python 3 with all the packages listed above
      (python311.withPackages my-python-packages)
    ];
}

