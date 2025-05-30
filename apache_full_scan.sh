#!/bin/bash

TARGET="$1"

if [ -z "$TARGET" ]; then
  echo "Usage: $0 <target-ip>"
  exit 1
fi

echo "[*] Starting Apache/HTTP service discovery on $TARGET"

# Output file
OUTPUT="apache_full_scan_${TARGET}.txt"

# Common web ports
PORTS="80,443,8000,8080,8888,81,591,2082,2095,3000,5000,7000,8443"

echo "[*] Running basic SYN scan..."
nmap -sS -sV -p $PORTS -Pn -T4 --open --script=http-title,http-server-header -oN - $TARGET | tee -a "$OUTPUT"

echo "[*] Running TCP Connect scan..."
nmap -sT -sV -p $PORTS -Pn -T4 --open --script=http-title,http-server-header -oN - $TARGET | tee -a "$OUTPUT"

echo "[*] Running ACK scan..."
nmap -sA -p $PORTS -Pn -T4 --open -oN - $TARGET | tee -a "$OUTPUT"

echo "[*] Running NULL scan..."
nmap -sN -p $PORTS -Pn -T4 --open -oN - $TARGET | tee -a "$OUTPUT"

echo "[*] Running FIN scan..."
nmap -sF -p $PORTS -Pn -T4 --open -oN - $TARGET | tee -a "$OUTPUT"

echo "[*] Running XMAS scan..."
nmap -sX -p $PORTS -Pn -T4 --open -oN - $TARGET | tee -a "$OUTPUT"

echo "[*] Running Fragmented packets scan..."
nmap -sS -f -p $PORTS -Pn -T2 --open -oN - $TARGET | tee -a "$OUTPUT"

echo "[*] Running Aggressive scan..."
nmap -A -p $PORTS -Pn -T4 --open -oN - $TARGET | tee -a "$OUTPUT"

echo "[*] Running Idle scan (zombie host 127.0.0.1)..."
nmap -sI 127.0.0.1 -p $PORTS -Pn -T3 --open -oN - $TARGET | tee -a "$OUTPUT"

echo "[*] Running with top 1000 ports..."
nmap -sS -sV --top-ports 1000 -Pn --open -T4 --script=http-title,http-server-header -oN - $TARGET | tee -a "$OUTPUT"

echo "[+] Done. Full results saved to $OUTPUT"
