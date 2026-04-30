{ lib, config, pkgs, callPackage, inputs, ... }:

let
  #  unstable = import <nixos-unstable> {
  #    config.allowUnfree = true;
  #  };

  #  pkgs = import <nixpkgs> { };
  #  # docx2python_dmo = pkgs.python310Packages.callPackage ../packages/docx2python/default.nix {};
in 
{

  environment.systemPackages = with pkgs; [


    (python312.withPackages(ps: with ps; [
      # mistune     # Sane Markdown parser with useful plugins and renderers
      prospector    # Tool to analyse Python code and output information about errors, potential problems, convention violations and complexity
      pylint        # Bug and style checker for Python
      pip
      pipenv        # Python Development Workflow for Humans
      direnv        # Shell extension that manages your environment
      pip-tools     # Keeps your pinned dependencies fresh
      # poetry       # Python dependency management and packaging made easy
      # virtualenv      # Tool to create isolated Python environments
      # virtualenvwrapper   # Enhancements to virtualenv
      # autopep8      # Tool that automatically formats Python code to conform to the PEP 8 style guide                  
      # ipykernel     # IPython Kernel for Jupyter
      dnspython       # DNS toolkit for Python                                                           
      # black         # Uncompromising Python code formatter
      beautifulsoup4   # HTML and XML parser
      requests        # HTTP library for Python
      urllib3         # Powerful, user-friendly HTTP client for Python
      pandas           # Powerful data structures for data analysis, time series, and statistics                                                                                   
      # black-macchiato  # This is a small utility built on top of the black Python code formatter to enable formatting of partial files                                                                        
      # yapf          # Yet Another Python Formatter  
      loguru          # Python logging made (stupidly) simple
      rich            # Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal
      docx2txt
      #jupyterlab
      #jupyterlab_launcher
      # pyflakes        # Simple program which checks Python source files for errors
      python-docx                                                                                            
      pdfminer-six
      jedi              # Autocompletion tool for Python that can be used for text editors
      # bandit            # Security oriented static analyser for python code
      flake8
      # pycodestyle
      # pydocstyle
      # pylama            # Code audit tool for python
      #docx2python
      # isort             # Python utility / library to sort Python imports
     # pytest
      # unittest2
      #python-ctags3
      python-dateutil
      # mypy                # Optional static typing for Python
      watchdog
      # Wand                  # Ctypes-based simple MagickWand API binding for Python
      ocrmypdf
      img2pdf
      pycurl  
      progressbar
      colorama
      types-colorama
      setuptools
      notify2 # required by rapidphotodownloader
     ]                                                                                          
    ))                                                                                             
];

} 
