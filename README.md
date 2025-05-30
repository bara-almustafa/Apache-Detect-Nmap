# Apache Detect Nmap

This script performs advanced Nmap scans using multiple techniques to detect Apache and other HTTP services, even behind firewalls or filtering. Useful for red teamers, CTF players, and network auditors.

---

## ✅ Features

- SYN, Connect, ACK, FIN, XMAS, NULL scans  
- Aggressive OS + service detection  
- Fragmentation & idle scan support  
- Detects Apache on uncommon ports  
- Outputs results to a clean report file  

---

## 🔧 Usage

```bash
chmod +x apache_full_scan.sh
./apache_full_scan.sh <target-ip>
