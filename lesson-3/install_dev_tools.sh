# #!/bin/bash

set -e
LOG_FILE="install.log"

echo "===== Starting environment setup =====" | tee "$LOG_FILE"

# Detect OS
OS="$(uname -s)"
echo "[INFO] Detected OS: $OS" | tee -a "$LOG_FILE"

# ---------------------------------------
# Helper: install package if missing
# ---------------------------------------
install_if_missing() {
    local pkg="$1"
    local check_cmd="$2"
    local install_cmd="$3"

    if eval "$check_cmd" &>/dev/null; then
        echo "[OK] $pkg already installed" | tee -a "$LOG_FILE"
    else
        echo "[INFO] Installing $pkg..." | tee -a "$LOG_FILE"
        if eval "$install_cmd" >>"$LOG_FILE" 2>&1; then
            echo "[OK] $pkg installed successfully" | tee -a "$LOG_FILE"
        else
            echo "[ERROR] Failed to install $pkg" | tee -a "$LOG_FILE"
            exit 1
        fi
    fi
}

# ---------------------------------------
# Install system dependencies (Linux only)
# ---------------------------------------
if [[ "$OS" == "Linux" ]]; then
    install_if_missing "Python3" \
        "command -v python3" \
        "sudo apt-get update && sudo apt-get install -y python3 python3-pip python3-venv"

    install_if_missing "Docker" \
        "command -v docker" \
        "sudo apt-get update && sudo apt-get install -y docker.io"
    
    install_if_missing "Docker Compose" \
        "docker compose version" \
        "sudo apt-get update && sudo apt-get install -y docker-compose"
fi

# ---------------------------------------
# macOS dependencies (Homebrew)
# ---------------------------------------
if [[ "$OS" == "Darwin" ]]; then
    if ! command -v brew &>/dev/null; then
        echo "[ERROR] Homebrew not installed. Install from https://brew.sh/" | tee -a "$LOG_FILE"
        exit 1
    fi

    install_if_missing "Python3" \
        "command -v python3" \
        "brew install python"

    install_if_missing "Docker" \
        "command -v docker" \
        "brew install --cask docker"

    install_if_missing "Docker Compose" \
        "docker compose version" \
        "brew install docker-compose"
fi

# ---------------------------------------
# pip update
# ---------------------------------------
echo "[INFO] Updating pip, setuptools, wheel..." | tee -a "$LOG_FILE"
python3 -m pip install --upgrade pip setuptools wheel >>"$LOG_FILE" 2>&1

# ---------------------------------------
# Install Django
# ---------------------------------------
install_if_missing "Django" \
    "python3 - <<EOF
import django
EOF" \
    "python3 -m pip install django"

# ---------------------------------------
# Install PyTorch (cross-platform)
# ---------------------------------------

echo "[INFO] Checking PyTorch..." | tee -a "$LOG_FILE"
if python3 - <<EOF &>/dev/null
import torch
EOF
then
    echo "[OK] PyTorch already installed: $(python3 -c "import torch; print(torch.__version__)")" | tee -a "$LOG_FILE"
else
    # PyTorch does not support Python 3.13 yet
    PY_MINOR=$(python3 -c "import sys; print(sys.version_info.minor)")
    if [[ "$PY_MINOR" -ge 13 ]]; then
        echo "[ERROR] PyTorch is not available for Python 3.$PY_MINOR — use Python 3.12." | tee -a "$LOG_FILE"
        exit 1
    fi

    echo "[INFO] Installing PyTorch..." | tee -a "$LOG_FILE"

    if [[ "$OS" == "Darwin" ]]; then
        # macOS CPU
        python3 -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu >>"$LOG_FILE" 2>&1
    else
        # Linux (CPU)
        python3 -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu >>"$LOG_FILE" 2>&1
    fi

    echo "[OK] PyTorch installed" | tee -a "$LOG_FILE"
fi

echo "===== Environment setup completed successfully =====" | tee -a "$LOG_FILE"
