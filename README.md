# 🖱️ Fedora Synaptics Ghost Touch Fix (06CB:CEE7)

A permanent, easy-to-apply, and customizable fix for the notorious "ghost touch" and erratic cursor jumping issue on Synaptics touchpads under Fedora Linux (Wayland & libinput).

---

## 📖 What is happening to my touchpad?

If you are using a laptop (commonly an HP Envy, HP Pavilion, or Omen) with the **SYNA32E2:00 06CB:CEE7** touchpad, you might feel like your computer is possessed. 

**Common Symptoms:**
* You are typing, and suddenly the text box loses focus because of a phantom click.
* The cursor jumps to a completely different line of text while you are coding or writing.
* Workspaces switch automatically without you touching the pad (fake 3-finger swipes).
* The issue often gets much worse when the laptop is plugged into the AC charger.

**The Cause:**
This is a known hardware flaw. The touchpad suffers from poor electrical grounding and static noise. The hardware literally sends "garbage" coordinates and fake touch pressure to the Linux kernel. `libinput` (the Linux input driver) tries its best to process them, resulting in rapid phantom clicks and multi-finger gestures.

## 🧠 How does this fix work?

Since there is no official firmware update to fix the electrical noise physically, we use a software feature called **"libinput quirks"**. 

This fix creates a configuration file that tells Linux: *"Hey, this specific touchpad sends electrical static. Ignore any touch that doesn't feel like a real human finger."* We do this by adjusting the pressure thresholds. Static noise usually registers at specific fake "pressures", so we simply tell the driver to drop them.

---

## ⚠️ Verification: Do I have this bug?

### 🔍 Method 1: Check System Logs
Check your system logs by running this command in your terminal:

```bash
sudo journalctl -k | grep -i "Touch jump detected"
```

If you see an output like `kernel bug: Touch jump detected and discarded`, your hardware is sending electrical static, and this fix is exactly what you need.

### 👀 Method 2: Live Monitoring (Advanced)
If you want to catch the hardware failing in real-time:
1. Run this command:
```bash
sudo libinput debug-events
```
2. Start making quick, rough gestures on your touchpad (rapid tapping, fast multi-finger swipes) to stress-test the hardware.
3. Watch the terminal. If you see lines like `kernel bug: Touch jump detected and discarded` or a flood of `GESTURE_SWIPE` events right when the cursor glitches, your touchpad is failing to filter the static.
4. Press `Ctrl + C` to stop monitoring.

---

## 🚀 Automatic Installation (Recommended)

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

*(The script will ask if you want to reboot. A reboot is required to apply the changes).*

---

## 📝 Manual Installation

If you prefer to apply the fix manually, copy and paste this entire block into your terminal:

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
*Reboot your computer after running the command.*

---

## 🎛️ Tweaking the Parameters (Make it more aggressive)

Did you apply the fix, and the ghost touches **decreased in frequency but didn't disappear completely?** That means the fix is working, but your specific laptop generates stronger static than average. You need to make the filter more aggressive!

Open the configuration file we created using the nano editor:
```bash
sudo nano /etc/libinput/local-overrides.quirks
```

You will see two key variables. Here is how you can tweak them to your liking:

1. **`AttrPressureRange=50:40` (Activation:Release)**
   * **What it does:** The first number (50) is how hard a finger must press to register a click/movement. The second number (40) is when the driver considers the finger lifted.
   * **How to tweak it:** If you still get ghost clicks, increase these numbers by 10 (e.g., change to `60:50` or `70:60`). This makes the touchpad require *more* physical pressure from your finger, completely blocking weak static noise.
2. **`AttrPalmPressureThreshold=120` (Palm/Static Rejection)**
   * **What it does:** Any touch with a pressure higher than this number is considered a "palm resting on the pad" (or a massive static spike) and is ignored.
   * **How to tweak it:** If the cursor still jumps wildly, you can lower this number (e.g., change to `100` or `90`) so large static bursts are rejected faster.

After editing the values, save the file (`Ctrl + O`, `Enter`, then `Ctrl + X`) and **reboot**.

---

## ⏪ How to Uninstall

If you ever need to revert this change, simply delete the file and reboot:

```bash
sudo rm /etc/libinput/local-overrides.quirks
```

---

## 💡 Compatibility & Requirements
* **OS:** Fedora Workstation (Tested on 40, 41, 44+)
* **Display Server:** Wayland
* **Driver:** libinput
* **Hardware:** SYNA32E2:00 06CB:CEE7 Touchpad
