{ lib, config, pkgs, callPackage, inputs, pkgs-unstable, ... }:

let
  #  unstable = import <nixos-unstable> {
  #    config.allowUnfree = true;
  #  };

  #  pkgs = import <nixpkgs> { };
  #  # docx2python_dmo = pkgs.python310Packages.callPackage ../packages/docx2python/default.nix {};
<<<<<<< HEAD

  unstable-packages = with pkgs-unstable; [
    
  ];
=======
>>>>>>> flake-conversion
in 
{

  environment.systemPackages = with pkgs; [
    # (let
    #   python = let
    #     packageOverrides = self: super: {
    #       docx2python = super.docx2python.overridePythonAttrs(old: rec {
    #         version = "2.11.0";

    #         # Pypi does not contain tests
    #         src = super.fetchFromGitHub {
    #           #owner = "ShayHill";
    #           #repo = pname;
    #           inherit owner;
    #           inherit repo;
    #           rev = "35734cfb92162027a2810a5e6a3c70abfee77f8e";
    #           sha256 = "sha256-dM2qzBukAXs1NvU/LbEgLGpXgaT+N4Y7Yq5pT1LMm1o="; 
    #         };
    #       });
    #     };
    #   in pkgs.python310.override {inherit packageOverrides; self = python;};

    # in python.withPackages(ps: with ps; [

    (python312.withPackages(ps: with ps; [
      mistune_2_0
      pylint
      pip
      pip-tools
     # poetry
      virtualenv
      autopep8                        
      ipykernel
      dnspython                                                                  
      black    
      beautifulsoup4
      requests
      urllib3
      pandas                                                                                         
      black-macchiato                                                                                   
      yapf  
      loguru
      rich
      docx2txt
      #jupyterlab
      #jupyterlab_launcher
      pyflakes
      python-docx                                                                                            
      pdfminer
      jedi
      bandit
      flake8
      pycodestyle
      pydocstyle
      pylama
      #docx2python
      #docx2python
      isort
     # pytest
      # unittest2
      virtualenvwrapper
      #python-ctags3
      python-dateutil
      mypy
      watchdog
      Wand
      ocrmypdf
      img2pdf
      pycurl  
      progressbar
      colorama
      types-colorama
      setuptools
      requests                                                                                      
      notify2 # required by rapidphotodownloader
     ]                                                                                          
    ))                                                                                             
];

} 
