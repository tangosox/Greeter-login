# plasma-greeter-remote-login

## What It Does

Automates login at the KDE Plasma greeter using `ydotool`, allowing remote GUI access (e.g. for Sunshine) after reboot or logout.


## Why

When using Sunshine for remote streaming, the server cannot access a Wayland session until a user logs in.

This script allows logging into the Plasma greeter remotely via SSH by simulating keyboard input using `ydotool`.

## Requirements

- KDE Plasma Login Manager
- `ydotool`
- `uinput` kernel module enabled
- User added to the `input` group
- SSH access to the machine

## How It Works

1. Waits for the Plasma greeter to appear on `seat0`.
2. Starts a temporary `ydotoold` instance.
3. Waits for the `ydotoold` socket to become ready.
4. Prompts for your password securely (no terminal echo).
5. Clears the password field.
6. Types the password using virtual input.
7. Presses Enter.
8. Stops `ydotoold`.

## Usage

Run via SSH once the system is at the login screen:

```bash
bash greeter-login.sh
```

## Security Warning (Important)

This script types your password programmatically. That needs to be acknowledged.

```markdown
## Security Notes

- Your password is entered via simulated keyboard input.
- It is read silently and unset immediately after use.
- This script is intended for personal remote access setups.
- Use at your own risk.```
