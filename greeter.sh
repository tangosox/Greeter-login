#!/usr/bin/env bash
set -uo pipefail   # ← remove -e to avoid premature exits

wait_for_greeter() {
    echo "[*] Waiting for Plasma Login Manager on seat0..."

    while true; do
        if loginctl list-sessions --no-legend | grep -q 'seat0.*greeter'; then
            echo "[✓] Greeter detected on seat0"
            return
        fi
        sleep 0.5
    done
}

wait_for_socket() {
    echo "[*] Waiting for ydotoold socket..."

    for _ in {1..100}; do
        if ydotool key 57:1 57:0 >/dev/null 2>&1; then
            echo "[✓] ydotoold ready"
            return
        fi
        sleep 0.1
    done

    echo "[!] ydotoold did not become ready"
    exit 1
}

########################################

wait_for_greeter

echo "[*] Starting temporary ydotoold (user mode)..."

ydotoold >/dev/null 2>&1 &
YD_PID=$!

cleanup() {
    echo "[*] Stopping ydotoold..."
    kill "$YD_PID" 2>/dev/null || true
}
trap cleanup EXIT

wait_for_socket

echo "[*] Enter your login password:"
read -rsp "Password: " PW
echo

echo "[*] Clearing field..."
ydotool key 14:1
sleep 1.5
ydotool key 14:0

echo "[*] Typing password..."
ydotool type "$PW"
unset PW

echo "[*] Pressing Enter..."
ydotool key 28:1 28:0

echo "[✓] Done."
