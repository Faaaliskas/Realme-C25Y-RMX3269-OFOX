# OrangeFox Recovery Device Tree for Realme C25Y (RMX3269 / RMX3265)

Device tree for building OrangeFox / TWRP Recovery for **Realme C25Y (RMX3269 / RMX3265)** based on verified Unisoc UMS512 tree.

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

## Included Fixes & Improvements
* **Boot Offsets:** Correct `--ramdisk_offset 0x05400000` and `--tags_offset 0x00000100` for Unisoc bootloader.
* **AVB Signing:** Enabled `BOARD_AVB_ENABLE := true` with hashtree disabled flags.
* **Display & Graphics:** `TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"`, `ueventd.rc` with `/dev/dri/*` DRM node permissions, and `TW_NO_SCREEN_BLANK`.
* **Touchscreen Wake:** Integrated `tswake` background service and touchscreen panel firmware prebuilts.
* **USB / ADB:** Pre-configured ConfigFS with Unisoc `musb-hdrc.0.auto` and `kernel_init_done 1` trigger.
* **Automated Magiskboot Repack:** CI workflow automatically repacks with magiskboot to guarantee 100% bootloader compatibility.
