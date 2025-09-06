{ config, pkgs, ...}:

{
  # Enable dconf (System Management Tool)
        programs.dconf.enable = true;

        # Add user to libvirtd group
        users.users.mrbrooks.extraGroups = [ "libvirtd" ];

        # Install necassary packages
        environment.systemPackages = with pkgs; [
                virt-manager
                virt-viewer
                spice-gtk
                spice-protocol
                spice-vdagent
                spice-autorandr
                win-virtio
                win-spice
                pkgs.adwaita-icon-theme
        ];

        # Manage the vitualisation services
        virtualisation = {
                libvirtd = {
                        enable = true;
                        qemu = {
                                swtpm.enable =  true;
                                ovmf.enable = true;
                                ovmf.packages = [ pkgs.OVMFFull.fd ];
                        };
                };
                spiceUSBRedirection.enable = true;
        };
        services.spice-vdagentd.enable = true;
}
