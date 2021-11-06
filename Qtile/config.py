# File 		            : Qtile Config
# Qtile Version 	        : 0.18.1
# Python Version            : 3.9.7
# Reference	            : http://docs.qtile.org/en/latest/

from typing import List  
from os import system
from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# Variables
mod                 = "mod4"
alt                 = "mod1"
terminal            = "alacritty"
shell               = "zsh"
run_launcher        = "rofi -show drun -theme ~/.config/rofi/sidebar.rasi"
power_launcher      = "rofi -modi \"Power\":\"~/.config/rofi/json.sh .config/rofi/example.json\" -show \"Power\" -theme ~/.config/rofi/poweroff.rasi"
project_launcher    = "rofi -modi \"Project\":\"~/.config/rofi/json.sh /home/vivek/.config/rofi/projects.json\" -show \"Project\" -theme ~/.config/rofi/poweroff.rasi"
ctrl                = "control"
shift               = "shift"
web_browser         = "brave"
terminal_editor     = "emacsclient -t"
gui_editor          = "emacsclient -c"
config_path         = ".config/qtile/config.py"
filemanager         = "emacsclient -c -a 'emacs' --eval '(dired nil)'"
screenshot          = "gnome-screenshot --interactive"
calculator          = "qalculate-gtk"

# Commands
terminal_command    = terminal + " -e " + shell
term_config_edit    = "alacritty -e emacsclient -t ~/.config/qtile/config.py"
gui_config_edit     = gui_editor + " " + config_path


keys = [
    # Switch between windows
    Key([mod], "h",     lazy.layout.left()  ,   desc="Move focus to left"                   ),
    Key([mod], "l",     lazy.layout.right() ,   desc="Move focus to right"                  ),
    Key([mod], "j",     lazy.layout.down()  ,   desc="Move focus down"                      ),
    Key([mod], "k",     lazy.layout.up()    ,   desc="Move focus up"                        ),
    Key([mod], "space", lazy.layout.next()  ,   desc="Move window focus to other window"    ),

    # Moving Windows
    Key([mod, shift], "h", lazy.layout.shuffle_left()   , desc="Move window to the left"    ),
    Key([mod, shift], "l", lazy.layout.shuffle_right()  , desc="Move window to the right"   ),
    Key([mod, shift], "j", lazy.layout.shuffle_down()   , desc="Move window down"           ),
    Key([mod, shift], "k", lazy.layout.shuffle_up()     , desc="Move window up"             ),

    # Resize Windows
    Key([mod, ctrl], "h", lazy.layout.grow_left()       ,   desc="Grow window to the left"  ),
    Key([mod, ctrl], "l", lazy.layout.grow_right()      ,   desc="Grow window to the right" ),
    Key([mod, ctrl], "j", lazy.layout.grow_down()       ,   desc="Grow window down"         ),
    Key([mod, ctrl], "k", lazy.layout.grow_up()         ,   desc="Grow window up"           ),

    # Application Launches
    Key([mod], "Return" ,   lazy.spawn(terminal_command)    , desc="Launch terminal"        ), 
    Key([mod], "d"      ,   lazy.spawn(run_launcher)        , desc="Run Launcher"           ),
    Key([mod, alt], "w" ,   lazy.spawn(web_browser)         , desc="Run Web Browser"        ),
    Key([mod, alt], "m" ,   lazy.spawn(gui_editor)          , desc="Run GUI Editor"         ),
    Key([mod, alt], "f" ,   lazy.spawn(filemanager)         , desc="Run File Manager"       ),
    Key([mod, alt], "c" ,   lazy.spawn(screenshot)          , desc="Run Screenshot"         ),
    Key([mod, alt], "q" ,   lazy.spawn(calculator)          , desc="Run Calculator"         ),
    Key([mod], "e"      ,   lazy.spawn(gui_config_edit)     , desc="Edit Qtile Config"      ),
    Key([mod, ctrl], "e",   lazy.spawn(term_config_edit)    , desc="Edit Qtile Config"      ),
    Key([mod], "p"      ,   lazy.spawn(power_launcher)      , desc="Lock Screen"      	    ),
    Key([mod], "o"      ,   lazy.spawn(project_launcher)    , desc="Project Management"      	    ),
	    
    # Media Keys
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")  , desc="Increase Volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")  , desc="Decrease Volume"),
    Key([], "XF86AudioMute"       , lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") , desc="Mute Volume"    ),


    # Qtile Actions
    Key([mod], "f"          ,   lazy.next_layout()  		, desc="Toggle Full Screen"              ),
    Key([mod], "r"          ,   lazy.restart()      		, desc="Restart Qtile"                   ),
    Key([mod, shift], "e"   ,   lazy.shutdown()     		, desc="Quit Qtile"                      ),
    Key([mod, shift], "q"   ,   lazy.window.kill()  		, desc="Kill focused window"             ),

]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # Switching Groups
        Key([mod], i.name, lazy.group[i.name].toscreen(),  desc="Switch to group {}".format(i.name)),

        # Moving Windows Between Groups
        Key([mod, shift], i.name, lazy.window.togroup(i.name, switch_group=True), desc="Switch to & move focused window to group {}".format(i.name)),
    ])

# Qtile Layouts
layouts = [
    layout.Columns(border_focus_stack='#ffffff'),
    layout.Max(),
]

# Widget Default Configuration
widget_defaults = dict(
    font='UbuntuMono',
    fontsize=12,
    padding=1,
)
extension_defaults = widget_defaults.copy()

# My Widgets
widget_spacer = lambda: widget.TextBox(fmt="  ")

# Initialising Screens
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(padding=3),
                widget.Prompt(),
                widget.WindowName(fontsize=0),  
                widget_spacer(),
                widget.Battery(format='⚡ {percent:2.0%}'),
                widget_spacer(),
                widget.TextBox(fmt="🌡️"),
                widget.ThermalSensor(mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e htop')}),
                widget_spacer(),
                widget.CPU(format='🖥️ {load_percent}%', mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e htop')}),
                widget_spacer(),
                widget.Memory(format='📟 {MemUsed: .0f}{mm}'),
                widget.CheckUpdates(
                       update_interval = 1800,
                       distro = "Arch_checkupdates",
                       display_format = "  📤 {updates} Packages",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e paru && sudo flatpak update')},
                       ),

                widget.TextBox(fmt=" 🔈"),
                widget.Volume(),
                widget_spacer(),
                widget.Clock(format='🕑 %I:%M %p'),
            ],
            20,
            opacity=1,
        ),
    ),
]

# Mouse Bindings
mouse = [
    Drag([mod],     "Button1",      lazy.window.set_position_floating() , start=lazy.window.get_position()),
    Drag([mod],     "Button3",      lazy.window.set_size_floating()     ,     start=lazy.window.get_size()),
    Click([mod],    "Button2",      lazy.window.bring_to_front()                                           )
]

# Other Settings
dgroups_key_binder              = None
dgroups_app_rules               = []  
main                            = None  
follow_mouse_focus              = True
bring_front_click               = False
cursor_warp                     = False
auto_fullscreen                 = True
focus_on_window_activation      = "smart"
wmname                          = "LG3D"

# Floating Rulers
floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,   # Defaults
    Match(wm_class='confirmreset'),         # gitk
    Match(wm_class='makebranch'),           # gitk
    Match(wm_class='maketag'),              # gitk
    Match(wm_class='ssh-askpass'),          # ssh-askpass
    Match(title='branchdialog'),            # gitk
    Match(title='pinentry'),                # GPG key password entry
    Match(wm_class="Tk"),                   # Python Tkinter
    Match(wm_class="Qalculate-gtk")         # Qalculate
])

# Autostart
system("picom -f &")
system("lxsession &")
system("nitrogen --restore &")
system("redshift -P -O 5000 &")
system("emacs --daemon &")
