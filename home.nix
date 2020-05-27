{ config, pkgs, ... }:

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
}
