#!/bin/bash

LOG_FILE="install.log"

echo "===== Starting environment setup =====" | tee -a $LOG_FILE

# ---------------------------------------
# 1. Перевірка Python та версії
# ---------------------------------------
if ! command -v python3 &> /dev/null; then
    echo "[ERROR] Python3 not found. Install with: brew install python" | tee -a $LOG_FILE
    exit 1
fi

PY_VER=$(python3 -c "import sys; print(sys.version_info.minor)")
echo "[OK] Python3 found: $(python3 --version)" | tee -a $LOG_FILE

if [ "$PY_VER" -ge 13 ]; then
    echo "[WARNING] You are running Python 3.${PY_VER}. PyTorch has NO official wheels for 3.13 yet." | tee -a $LOG_FILE
    echo "[WARNING] Recommended: brew install python@3.12 && create venv using python3.12" | tee -a $LOG_FILE
fi

# ---------------------------------------
# 2. Перевірка pip
# ---------------------------------------
if ! command -v pip3 &> /dev/null; then
    echo "[INFO] pip3 not found — installing via ensurepip" | tee -a $LOG_FILE
    python3 -m ensurepip --upgrade
else
    echo "[OK] pip3 found: $(pip3 --version)" | tee -a $LOG_FILE
fi

echo "[INFO] Upgrading pip, setuptools, wheel..." | tee -a $LOG_FILE
pip3 install --upgrade pip setuptools wheel >> $LOG_FILE 2>&1

# ---------------------------------------
# 3. Перевірка Docker
# ---------------------------------------
if ! command -v docker &> /dev/null; then
    echo "[ERROR] Docker not found. Install Docker Desktop for macOS." | tee -a $LOG_FILE
else
    echo "[OK] Docker found: $(docker --version)" | tee -a $LOG_FILE
fi

# ---------------------------------------
# 4. Перевірка Docker Compose
# ---------------------------------------
if ! docker compose version &> /dev/null; then
    echo "[ERROR] Docker Compose plugin not found." | tee -a $LOG_FILE
else
    echo "[OK] docker compose plugin found: $(docker compose version)" | tee -a $LOG_FILE
fi


# ---------------------------------------
# 5. Django
# ---------------------------------------
if python3 -c "import django" 2>/dev/null; then
    echo "[OK] Django already installed" | tee -a $LOG_FILE
else
    echo "[INFO] Installing Django..." | tee -a $LOG_FILE
    pip3 install django >> $LOG_FILE 2>&1
fi

# ---------------------------------------
# 6. Перевірка та встановлення PyTorch
# ---------------------------------------
echo "[INFO] Checking PyTorch..." | tee -a $LOG_FILE

python3 - <<EOF | tee -a $LOG_FILE
try:
    import torch
    print("[OK] Torch version:", torch.__version__)
except Exception:
    print("[INFO] Torch not found. Attempting installation...")
    import os, sys
    # Python 3.13 warning
    if sys.version_info.minor >= 13:
        print("[ERROR] PyTorch cannot be installed on Python 3.13. Install Python 3.12!")
    else:
        os.system("pip install torch torchvision pillow")
EOF


echo "===== Environment setup completed =====" | tee -a $LOG_FILE
