# OrangeFox Recovery Device Tree for Realme C25Y (RMX3269 / UMS512)

Device tree for building OrangeFox / TWRP Recovery for **Realme C25Y (RMX3269 / RMX3265)**.

## Device Specifications

| Feature | Value |
| :--- | :--- |
| SoC | Unisoc Tiger T610 (UMS512) |
| Architecture | ARM64 (aarch64) |
| Android Version | Android 11 (R) / 12 (S) |
| Partitions Layout | Virtual A/B (Recovery-in-boot) |
| Resolution | 720 x 1600 |
| DPI | 320 |
| Dynamic Partitions | super (system, vendor, product, system_ext) |
| USB Controller | musb-hdrc.0.auto (ConfigFS) |
| Maintainers | visEXE | KSN |

---

## What was fixed & included
* **Display Fix (DRM):** Included custom `patches/graphics_drm.cpp` for Unisoc Mali DRM dumb buffer support.
* **USB / ADB / MTP:** Unisoc `musb-hdrc.0.auto` ConfigFS endpoints pre-configured in `init.recovery.ums512.rc`.
* **Vibration:** PMIC SC27xx input event vibration node permissions.
* **Dynamic Partitions & Virtual A/B:** Correct group names (`group_unisoc_a` / `group_unisoc_b`) and partition bounds.
* **Kernel & DTB:** Prebuilts extracted directly from stock boot image.

---

## How to Build via GitHub Actions (Cloud 1-Click)

1. Create a new GitHub repository (e.g. `android_device_realme_RMX3269`).
2. Push the contents of this folder to your repository:
   ```bash
   git init
   git add .
   git commit -m "Initial commit for Realme C25Y (RMX3269)"
   git branch -M main
   git remote add origin https://github.com/<YOUR_USERNAME>/<YOUR_REPO>.git
   git push -u origin main
   ```
3. Go to the **Actions** tab on your GitHub repository.
4. Select **"Build OrangeFox Recovery for Realme C25Y (RMX3269)"**.
5. Click **Run workflow** (select `fox_11.0`).
6. Once finished (15–25 minutes), download the compiled **OrangeFox-RMX3269** artifact containing the flashable `.zip` and `recovery-boot.img`!

---

## Thanks

Gemini 3.8 Flash
https://github.com/KSN2redawew
