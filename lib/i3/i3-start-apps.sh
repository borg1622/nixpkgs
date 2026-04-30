#!/usr/bin/env bash


##### startup
## todo: check params

#i3-msg '[window_role="mon-htop"] mark'

	autorandr -c &
	wait
	
	# Workspace 3/4
	i3-msg 'exec nautilus'
	wait
	
	sleep 1
	xdotool search --sync --onlyvisible --class "Org.gnome.Nautilus" set_window --role fui-nautilus windowunmap windowmap
	sleep 1
	i3-msg '[class="^Org\.gnome\.Nautilus$"] focus'
	wait
	
	sleep 1
	i3-msg 'exec terminator -r fcmd-ranger -e ranger'
	wait
	
	# Workspace 5
	i3-msg 'exec virtualbox'
	wait
	sleep 2	

	# Workspace 7
	thunderbird &
	
	# Workspace 8
	i3-msg 'exec terminator -r rmt-local'
	i3-msg 'exec terminator -r rmt-2'
	i3-msg 'exec terminator -r rmt-3'
	
	sleep 1
	# Workspace 12
	keepassxc &
	#wait
	
	# Workspace 10
	i3-msg 'exec terminator -r mon-htop -e htop'
	i3-msg 'exec terminator -r mon-2 -e "sleep 3 && neofetch"'
	i3-msg 'exec terminator -r mon-3'
	
	# Workspace 11
	i3-msg 'exec terminator -r cfg-1'
	#i3-msg 'exec gnome-text-editor ".config/i3/config"'
	#wait
	#sleep 1
	#xdotool search --sync --onlyvisible --class "Gnome-text-editor" set_window --role "cfg-2" windowunmap windowmap 
	#sleep 1
	#i3-msg '[class="Gnome-text-editor$"] focus'
	#wait
	
	sleep 1
	# Workspace 12
	#app-image-run /home/dmo/.joplin/Joplin.AppImage &
	#wait
	#sleep 1
	# Workspace 13
	#i3-msg 'exec atom'	
	#wait
	sleep 1
	# Workspace 1
	i3-msg 'exec firefox'
	wait
	xdotool search --sync --onlyvisible --class "Firefox" set_window windowunmap windowmap 
	sleep 1
	i3-msg '[window_role="^browser$"] focus'
	wait
	#sleep 1
	#i3-msg 'exec ~/.joplin/Joplin.AppImage'	


