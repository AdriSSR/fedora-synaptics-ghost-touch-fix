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
