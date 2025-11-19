#!/bin/bash

LOG_FILE="install.log"

echo "===== Starting environment setup =====" | tee -a $LOG_FILE

# Перевірка Python
if ! command -v python3 &> /dev/null
then
    echo "Python3 not found, please install manually (macOS: brew install python)" | tee -a $LOG_FILE
else
    echo "Python3 found: $(python3 --version)" | tee -a $LOG_FILE
fi

# Перевірка pip
if ! command -v pip3 &> /dev/null
then
    echo "pip3 not found, installing..." | tee -a $LOG_FILE
    python3 -m ensurepip --upgrade
else
    echo "pip3 found: $(pip3 --version)" | tee -a $LOG_FILE
fi

# Перевірка torch
python3 - <<EOF | tee -a $LOG_FILE
try:
    import torch
    print("Torch version:", torch.__version__)
except ImportError:
    print("Installing torch...")
    import os
    os.system("pip3 install torch torchvision pillow")
EOF

echo "===== Environment setup completed =====" | tee -a $LOG_FILE
