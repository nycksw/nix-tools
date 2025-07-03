{ config, pkgs, ... }:

{
  home.username = "e";
  home.homeDirectory = "/home/e";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    amass
    curl
    delta
    deskflow
    evil-winrm
    exploitdb
    feroxbuster
    ffuf
    fping
    freerdp
    gdb
    gnumake
    gobuster
    hashid
    htop
    httpx
    inotify-tools
    iproute2
    john
    jq
    keepass-diff
    keepassxc
    ligolo-ng
    ltrace
    masscan
    metasploit
    mono
    net-snmp
    netcat
    nettools
    nikto
    nix-search-cli
    notify
    nmap
    openvpn
    pgcli
    powershell
    responder
    rlwrap
    rsync
    samba
    shellcheck
    socat
    sqlmap
    strace
    stunnel
    subfinder
    terminator
    thc-hydra
    theharvester
    tmux
    traceroute
    tshark
    vim
    whatweb
    whois
    zip
    zsh

    # These require python312Packages, not the default 313.
    # Fixes: "future-1.0.0 not supported for interpreter python3.13"
    (python312.withPackages (ps: [
      ps.bloodhound-py
      ps.bloodyad
      ps.impacket
      ps.pyexploitdb
    ]))

    # These require python3.12 but don't exist in python312Packages, so an
    # overlay is required. See flake.nix.
    enum4linux-ng
    netexec

    ##### List of broken packages. #####

    # 20250702: scapy build fails for both python3.13 and 3.12. (Also unfree.)
    #cewler
  ];

  # Create a symlink at ~/seclists pointing to the latest seclists.
  home.file."seclists" = {
    source = "${pkgs.seclists}/share/wordlists/seclists";
  };
}
