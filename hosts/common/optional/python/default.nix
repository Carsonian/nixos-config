{ inputs, outputs, pkgs, ... }: {
  
  #   environment.systemPackages = with pkgs; [
  #     (python3.withPackages(ps: with ps; [ pandas requests]))
  #   ];
  # }


  # let
  #   my-python-packages = ps: with ps; [
  #     pandas
  #     requests
  #     # other python packages
  #   ];
  # in
  #   environment.systemPackages = [
  #     (pkgs.python3.withPackages my-python-packages)
  #   ];
  
  environment.systemPackages = 
    let
      my-python-packages = ps: with ps; [
        pandas
        #requests
        # other python packages
      ];

    in with pkgs; [
      (python3.withPackages my-python-packages)
    ];
}

