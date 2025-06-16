{ config, pkgs, ... }:

let
  kinesis-init-keyboard = pkgs.writeShellScriptBin "kinesis-init-keyboard" ''
 
    sleep 1
    KEYBOARD_MASTER_DEV_ID=$(xinput | grep -oP 'Virtual core keyboard\s+id=\K[0-9]+(?=.+master\s+keyboard)')
    KEYBOARD_KINESIS_DEV_ID=$(xinput | grep -oP 'Kinesis Freestyle Edge RGB Keyboard\s+id=\K[0-9]+(?=.+slave\s+keyboard)')

    if [[ -n ''${KEYBOARD_MASTER_DEV_ID} ]]; then
    	setxkbmap -device ''${KEYBOARD_MASTER_DEV_ID} -display ''$DISPLAY -symbols "pc+us(de_se_fi)+inet(evdev)+compose(caps-altgr)"
        notify-send "Keyboard Config" "Internal Keyboard layout changed..."
    fi
    #sleep 2
    if [[ -n ''${KEYBOARD_KINESIS_DEV_ID} ]]; then
    	setxkbmap -device ''${KEYBOARD_KINESIS_DEV_ID} -display ''$DISPLAY -symbols "pc+us(de_se_fi)+inet(evdev)+compose(caps-altgr)"
    	notify-send "USB Keyboard Config" "Kinesis Freestyle detected..."
    fi
  '';

in {
  environment.systemPackages = [ kinesis-init-keyboard ];
  services.udev.extraRules = ''
           SUBSYSTEM=="input", ATTRS{idVendor}=="29ea", ATTRS{idProduct}=="0102", SYMLINK+="kinesiskeyboard", TAG+="systemd"
  '';

  

  systemd.services.kinesis-layout = {
      # [Unit]
      description = "Change layout for Kinesis keyboard";
      after = [ "dev-kinesiskeyboard.device" ];
      bindsTo = [ "dev-kinesiskeyboard.device" ];
      requisite = [ "dev-kinesiskeyboard.device" ];
      
      # [Service]
      serviceConfig = {
        Type = "forking";
        ExecStart = ''${kinesis-init-keyboard}'';         
        StandardOutput = "journal";
        RemainAfterExit = "yes";
      };
      # [Install]
      wantedBy = [ "dev-kinesiskeyboard.device" ]; 
   };

}
