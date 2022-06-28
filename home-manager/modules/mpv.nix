{pkgs, config, ...}:{
  programs.mpv = {
    enable = true;
    config = {
      volume = 40;
      save-position-on-quit = true;
      hwdec = "vaapi";
      profile = "gpu-hq";
      gpu-api = "vulkan";
      opengl-swapinterval = 0;
    };
  };
}
