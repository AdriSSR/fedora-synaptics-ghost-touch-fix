# 🖱️ Fedora Synaptics Ghost Touch Fix (06CB:CEE7)

A permanent, easy-to-apply fix for the notorious "ghost touch" and erratic cursor jumping issue on Synaptics touchpads under Fedora Linux (Wayland & libinput).

---

## ⚠️ The Problem

If you are using a laptop (commonly an HP Envy, HP Pavilion, or Omen) with the **SYNA32E2:00 06CB:CEE7** touchpad, you might be experiencing:
* Random cursor jumps across the screen.
* Phantom 3-finger or 4-finger swipes.
* Workspaces switching automatically without you touching the pad.

### 🔍 Method 1: Check System Logs
Check your system logs by running this command in your terminal:

```bash
sudo journalctl -k | grep -i "Touch jump detected"
```

If you see an output like `kernel bug: Touch jump detected and discarded`, your hardware is sending electrical noise/static, and this fix is exactly what you need!

### 👀 Method 2: Live Monitoring (Advanced Verification)
If you want to catch the hardware sending "ghost touches" in real-time, you can use the official `libinput` debugging tool:

1. Run the following command in your terminal:
```bash
sudo libinput debug-events
```
2. Start making quick, rough gestures on your touchpad (rapid tapping, fast multi-finger swipes, or erratic movements) to stress-test the hardware.
3. Watch the terminal. If you start seeing lines like `kernel bug: Touch jump detected and discarded` or a flood of `GESTURE_SWIPE` events right when the cursor glitches, your touchpad is failing to filter the static interference properly.
4. Press `Ctrl + C` to stop the monitoring tool.

---

## 🛠️ The Solution

Since there is no official firmware update available from the manufacturer to fix this electrical static noise, the best workaround is to configure `libinput` to ignore touches that fall outside the normal pressure range of a real human finger.

### 🚀 Automatic Installation (Recommended)

Run these commands one by one in your terminal. *(Hover over the code blocks to use the Copy button!)*

**1. Clone this repository:**
```bash
git clone [https://github.com/AdriSSR/fedora-synaptics-ghost-touch-fix.git](https://github.com/AdriSSR/fedora-synaptics-ghost-touch-fix.git)
```

**2. Enter the directory:**
```bash
cd fedora-synaptics-ghost-touch-fix
```

**3. Make the script executable:**
```bash
chmod +x install.sh
```

**4. Run the installer:**
```bash
sudo ./install.sh
```

---

### 📝 Manual Installation

If you prefer not to run the `install.sh` script, you can apply the fix manually. Just copy and paste this entire block into your terminal and press Enter:

```bash
sudo mkdir -p /etc/libinput && \
sudo tee /etc/libinput/local-overrides.quirks <<EOF
[Synaptics Ghost Touch Fix]
MatchName=SYNA32E2:00 06CB:CEE7 Touchpad
MatchUdevType=touchpad
AttrPressureRange=50:40
AttrPalmPressureThreshold=120
EOF
```
*Don't forget to reboot your computer after applying the command!*

---

## ⏪ How to Uninstall

If you ever need to revert this change or you switch to a different laptop, simply delete the configuration file and reboot:

```bash
sudo rm /etc/libinput/local-overrides.quirks
```

---

## 💡 Compatibility & Requirements
* **OS:** Fedora Workstation (Tested on 40, 41, 44+)
* **Display Server:** Wayland
* **Driver:** libinput
* **Hardware:** SYNA32E2:00 06CB:CEE7 Touchpad
