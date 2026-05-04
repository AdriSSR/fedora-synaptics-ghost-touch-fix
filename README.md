# 🖱️ Fedora Synaptics Ghost Touch Fix (06CB:CEE7)

A permanent, easy-to-apply fix for the notorious "ghost touch" and erratic cursor jumping issue on Synaptics touchpads under Fedora Linux (Wayland & libinput).

---

## ⚠️ The Problem

If you are using a laptop (commonly an HP Envy, HP Pavilion, or Omen) with the **SYNA32E2:00 06CB:CEE7** touchpad, you might be experiencing:
* Random cursor jumps across the screen.
* Phantom 3-finger or 4-finger swipes.
* Workspaces switching automatically without you touching the pad.

**How to verify if you have this hardware bug:**
Check your system logs by running this command in your terminal:
```bash
sudo journalctl -k | grep -i "Touch jump detected"
If you see an output like kernel bug: Touch jump detected and discarded, your hardware is sending electrical noise/static, and this fix is exactly what you need!

🛠️ The Solution
Since there is no official firmware update available from the manufacturer to fix this electrical static noise, the best workaround is to configure libinput to ignore touches that fall outside the normal pressure range of a real human finger.

🚀 Automatic Installation (Recommended)
Run these commands one by one in your terminal. (Hover over the code blocks to use the Copy button!)

1. Clone this repository:

Bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
2. Enter the directory:

Bash
cd YOUR_REPO_NAME
3. Make the script executable:

Bash
chmod +x install.sh
4. Run the installer:

Bash
sudo ./install.sh
5. Reboot your system:

Bash
reboot
📝 Manual Installation
If you prefer not to run the install.sh script, you can apply the fix manually. Just copy and paste this entire block into your terminal and press Enter:

Bash
sudo mkdir -p /etc/libinput && \
sudo tee /etc/libinput/local-overrides.quirks <<EOF
[Synaptics Ghost Touch Fix]
MatchName=SYNA32E2:00 06CB:CEE7 Touchpad
MatchUdevType=touchpad
AttrPressureRange=50:40
AttrPalmPressureThreshold=120
EOF
Don't forget to reboot your computer after applying the command!

⏪ How to Uninstall
If you ever need to revert this change or you switch to a different laptop, simply delete the configuration file and reboot:

Bash
sudo rm /etc/libinput/local-overrides.quirks
💡 Compatibility & Requirements
OS: Fedora Workstation (Tested on 40, 41, 44+)

Display Server: Wayland

Driver: libinput

Hardware: SYNA32E2:00 06CB:CEE7 Touchpad


***
