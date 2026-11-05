#!/usr/bin/env python3
import sys

if len(sys.argv) < 2:
    print("Usage: patch_events.py <path_to_events.cpp>")
    sys.exit(1)

path = sys.argv[1]
with open(path, "r", encoding="utf-8", errors="ignore") as f:
    content = f.read()

new_vibrate_func = """static int g_ff_vibrator_fd = -1;
static int g_ff_effect_id = -1;

static int get_ff_vibrator_fd() {
    if (g_ff_vibrator_fd >= 0) {
        return g_ff_vibrator_fd;
    }
    int fd = open("/dev/input/event1", O_RDWR);
    if (fd >= 0) {
        char name[128] = {0};
        if (ioctl(fd, EVIOCGNAME(sizeof(name)), name) >= 0 && strstr(name, "vibrator")) {
            g_ff_vibrator_fd = fd;
            return g_ff_vibrator_fd;
        }
        close(fd);
    }
    DIR *dir = opendir("/dev/input");
    if (dir) {
        struct dirent *de;
        while ((de = readdir(dir)) != NULL) {
            if (strncmp(de->d_name, "event", 5) == 0) {
                char devpath[300];
                snprintf(devpath, sizeof(devpath), "/dev/input/%s", de->d_name);
                fd = open(devpath, O_RDWR);
                if (fd >= 0) {
                    char name[128] = {0};
                    if (ioctl(fd, EVIOCGNAME(sizeof(name)), name) >= 0 && strstr(name, "vibrator")) {
                        closedir(dir);
                        g_ff_vibrator_fd = fd;
                        return g_ff_vibrator_fd;
                    }
                    close(fd);
                }
            }
        }
        closedir(dir);
    }
    return -1;
}

int vibrate(int timeout_ms)
{
    char str[20];
    int len;

    // 1. Try timed_output
    int fd = open("/sys/class/timed_output/vibrator/enable", O_WRONLY);
    if (fd >= 0) {
        len = snprintf(str, sizeof(str), "%d\\n", timeout_ms);
        write(fd, str, len);
        close(fd);
        return 0;
    }

    // 2. Try leds
    fd = open("/sys/class/leds/vibrator/duration", O_WRONLY);
    if (fd >= 0) {
        len = snprintf(str, sizeof(str), "%d\\n", timeout_ms);
        write(fd, str, len);
        close(fd);
        fd = open("/sys/class/leds/vibrator/activate", O_WRONLY);
        if (fd >= 0) {
            write(fd, "1\\n", 2);
            close(fd);
            return 0;
        }
    }

    // 3. Try Linux Input Force Feedback (/dev/input/event1 for sc27xx-vibrator)
    int ff_fd = get_ff_vibrator_fd();
    if (ff_fd >= 0) {
        struct ff_effect effect;
        memset(&effect, 0, sizeof(effect));
        effect.type = FF_RUMBLE;
        effect.id = g_ff_effect_id;
        effect.u.rumble.strong_magnitude = 0xFFFF;
        effect.u.rumble.weak_magnitude = 0xFFFF;
        effect.replay.length = (timeout_ms > 0 ? timeout_ms : 50);
        effect.replay.delay = 0;

        if (ioctl(ff_fd, EVIOCSFF, &effect) < 0) {
            // Slot might be invalid or full, allocate anew
            effect.id = -1;
            if (ioctl(ff_fd, EVIOCSFF, &effect) < 0) {
                return -1;
            }
        }
        g_ff_effect_id = effect.id;

        struct input_event play;
        memset(&play, 0, sizeof(play));
        play.type = EV_FF;
        play.code = effect.id;
        play.value = 1;
        write(ff_fd, &play, sizeof(play));
        return 0;
    }

    return -1;
}"""

start = content.find("int vibrate(")
if start == -1:
    print("Error: Could not find 'int vibrate(' in events.cpp")
    sys.exit(1)

brace_open = content.find("{", start)
if brace_open == -1:
    print("Error: Could not find opening '{' for vibrate() in events.cpp")
    sys.exit(1)

depth = 1
i = brace_open + 1
while i < len(content) and depth > 0:
    ch = content[i]
    if ch == '{':
        depth += 1
    elif ch == '}':
        depth -= 1
    i += 1

if depth != 0:
    print("Error: Unbalanced braces while scanning vibrate() in events.cpp")
    sys.exit(1)

end = i
# String slicing replacement - completely avoids any regex / backslash expansion bugs
content = content[:start] + new_vibrate_func + content[end:]

with open(path, "w", encoding="utf-8") as f:
    f.write(content)

print(f"Patched {path} successfully (replaced {end - start} characters)!")
