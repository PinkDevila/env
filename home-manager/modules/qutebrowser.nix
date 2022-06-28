{pkgs, config, ...}:{
programs.qutebrowser = {
  enable = true;
  searchEngines = {
    DEFAULT = "https://duckduckgo.com/?q={}";
    yt = "https://yewtu.be/search?q={}";
  };
  quickmarks = {
    youtube = "https://yewtu.be/";
  };
};
}
