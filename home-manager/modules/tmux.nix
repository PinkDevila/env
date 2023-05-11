{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "a";
    clock24  = true;
    newSession = true;
    terminal = "screen-256color";
    escapeTime = 0;
    extraConfig = ''
      set -g mouse on
      set -g status-position top
      set -g status-style 'bg=default'
      bind-key C new-window -c "#{pane_current_path}"
      bind-key -n C-J previous-window
      bind-key -n C-K next-window
      bind-key C-a send-prefix
      bind-key '"' split-window -v -c "#{pane_current_path}"
      bind-key '%' split-window -h -c "#{pane_current_path}"
    '';
  };
}
