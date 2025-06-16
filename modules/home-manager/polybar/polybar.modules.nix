{
  imports = [
    #./modules/alsa.nix
    ./modules/backlight.nix
    ./modules/battery.nix
    ./modules/bluetooth.nix
    # ./modules/cpu.nix
    ./modules/date.nix
    ./modules/filesystem.nix
    ./modules/i3.nix
    #./modules/keyboard.nix
    #./modules/memory.nix
    #./modules/mpd.nix
    # ./modules/network.nix
    ./modules/pulseaudio.nix
    #./modules/temperature.nix
    #./modules/title.nix
    ./modules/separator.nix
    ./modules/vpn.nix
    ./modules/wired-network.nix
    ./modules/wireless-network.nix
  ];
}