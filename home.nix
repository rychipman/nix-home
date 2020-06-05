{ config, pkgs, ... }:

let
  mod = "Mod4";
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ryanix";
  home.homeDirectory = "/home/ryanix";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  home.packages = with pkgs; [
    lxterminal
    beancount
    fava
  ];

  programs.git = {
    enable = true;
    userName = "Ryan Chipman";
    userEmail = "ryan@ryanchipman.com";
    aliases = {
      aa = "add --all --intent-to-add";
      addp = "add --patch";
      st = "status";
      ci = "commit";
      co = "checkout";
      cp = "cherry-pick";
      diffc = "diff --cached";
      amend = "commit --amend";
      fixup = "commit --fixup";
      ri = "rebase --interactive --autosquash";
      rba = "rebase --abort";
      rbc = "rebase --continue";
      dangling = "! git lg $(git fsck --no-reflog | awk '/dangling commit/ {print $3}')";
      lc = "log ORIG_HEAD.. --stat --no-merges";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    };
    ignores = [
      ".envrc"
      "*~"
      "*#"
      "*.pyc"
      "*.bak"
      "*.swp"
      "*.ignore"
      "venv"
    ];
    extraConfig = {
      color.ui = true;
      merge.ff = "only";
      rerere.enabled = true;
      github.user = "rychipman";
    };
  };

  programs.bash = {
    enable = true;
    historyFile = "$HOME/.local/share/bash/history";
    historyControl = ["ignorespace" "ignoredups"];
    shellAliases = {
      ll = "ls -l";
      lla = "ls -la";
      la = "ls -la";
      mkdir = "mkdir -pv";
      c = "clear";
      h = "history";
      j = "jobs -l";
      ping = "ping -c 4";
      rm = "rm -I --preserve-root";
      mv = "mv -i";
      cp = "cp -i";
      ln = "ln -i";
      chown = "chown --preserve-root";
      chmod = "chmod --preserve-root";
      chgrp = "chgrp --preserve-root";
      sudo = "sudo ";
      tt = "tmux attach-session -t";
      perm = "stat -c '%A %a %n'";
    };
    sessionVariables = {
      CLICOLOR = 1;
      LSCOLORS = "Gxfxcxdxbxegedabagacad";
      LESS = "--ignore-case --raw-control-chars";
      PAGER = "less";
      EDITOR = "vim";
      TERM = "screen-256color";
      TMPDIR = "/tmp";
    };
    profileExtra = ''
      . /home/ryanix/.nix-profile/etc/profile.d/nix.sh
    '';
  };

  programs.vim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.wombat256-vim
    ];
    extraConfig = ''
      colorscheme wombat256mod
      highlight Normal ctermbg=233
      highlight SpecialKey ctermbg=233 ctermfg=235
      highlight Whitespace ctermbg=233 ctermfg=235
      highlight ExtraWhitespace ctermbg=red
    '';
  };

  programs.firefox = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {

    };
  };

  programs.tmux = {
    enable = true;
  };

  programs.mbsync = {
    enable = true;
  };

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      fonts = ["pango: Source Code Pro 11px"];
      keybindings = {
        "${mod}+k" = "workspace web";
        "${mod}+j" = "workspace edit";
        "${mod}+l" = "workspace term";
        "${mod}+h" = "workspace msg";
        "${mod}+semicolon" = "workspace msg";
        "${mod}+z" = "workspace vid";

        "${mod}+Control+k" = "move to workspace web";
        "${mod}+Control+j" = "move to workspace edit";
        "${mod}+Control+l" = "move to workspace term";
        "${mod}+Control+h" = "move to workspace msg";
        "${mod}+Control+z" = "move to workspace vid";

        "${mod}+Shift+h" = ''workspace msg; exec "google-chrome-stable --app=https://mongodb.slack.com"'';
        "${mod}+Shift+j" = "workspace edit; exec emacs";
        "${mod}+Shift+l" = "workspace term; exec lxterminal";
        "${mod}+Shift+k" = "workspace web; exec firefox";
        "${mod}+Shift+z" = "workspace vid; exec zoom";

        "${mod}+u" = ''[urgent="latest"] focus'';
        "${mod}+Return" = "exec lxterminal";
        "${mod}+o" = "exec dmenu_run";
        "${mod}+r" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+BackSpace" = "kill";
        "${mod}+q" = ''exec "i3-nagbar -t warning -m 'Do you really want to exit i3?' -B 'Yes, exit i3 and end X session' 'i3-msg exit'"'';

        "${mod}+Left" = "focus left";
        "${mod}+Right" = "focus right";
        "${mod}+Up" = "focus up";
        "${mod}+Down" = "focus down";

        "${mod}+v" = "split v";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+m" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+period" = "focus child";
        "${mod}+comma" = "focus parent";

        "${mod}+1" = "layout stacking";
        "${mod}+2" = "layout tabbed";
        "${mod}+3" = "layout toggle split";

        "${mod}+i" = "bar hidden_state toggle";
      };
    };
    extraConfig = ''
      default_border pixel
      
      workspace "web" output eDP-1
      workspace "msg" output eDP-1
      workspace "vid" output eDP-1
      workspace "edit" output DP-1-1 eDP-1
      workspace "term" output DP-1-3 eDP-1

      bar {
        position top
        status_command i3status
        workspace_buttons no
        mode hide
        modifier none
        hidden_state hide
      }

      bar {
        position bottom
        status_command i3status
        mode hide
        modifier none
        hidden_state hide
      }
    '';
  };
    
  home.file = { 
    ".xinitrc".text = ''  
      # map caps lock to control
      xmodmap -e 'keycode 66 = Control_L'
      xmodmap -e 'clear Lock'
      xmodmap -e 'add Control = Control_L'
      xcape -e 'Control_L=Escape'

      # remove everything from mod4
      xmodmap -e 'clear mod4'

      # map return to return/control
      spare_modifier='Hyper_L'
      xmodmap -e "remove mod4 = $spare_modifier"
      xmodmap -e "keycode 36 = $spare_modifier"
      xmodmap -e "add Control = $spare_modifier"
      xmodmap -e 'keycode any = Return'
      xcape -e "$spare_modifier=Return"

      # map tab to tab/super
      spare_modifier_2='Hyper_R'
      xmodmap -e "keycode 23 = $spare_modifier_2"
      xmodmap -e "add mod4 = $spare_modifier_2"
      xmodmap -e 'keycode any = Tab'
      xcape -e "$spare_modifier=Tab"

      exec i3
    '';

    ".config/lxterminal/lxterminal.conf".text = ''
      [general]
      fontname=Source Code Pro 11
      hidemenubar=true
      hidescrollbar=true
    '';

    #".emacs.d".source = "/home/ryanix/.dotfiles/emacs/.emacs.d";
  };

    
}
