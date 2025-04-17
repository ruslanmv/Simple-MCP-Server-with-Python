#!/bin/bash

# This script sets up a Python 3.11 environment on Ubuntu 22.04.
# It installs Python 3.11, sets it as the default python3, and creates a virtual environment.

echo "🔧 Adding deadsnakes PPA and updating packages..."
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update

echo "🐍 Installing Python 3.11 and required packages..."
sudo apt install -y python3.11 python3.11-venv python3.11-distutils

echo "🛠️ Fixing apt_pkg issues by installing python3-apt..."
sudo apt install -y python3-apt

echo "⚙️ Setting Python 3.11 as the default python3..."
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2
sudo update-alternatives --config python3

echo "💡 Installing pip for Python 3.11..."
curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3.11

echo "✅ Python version after setup:"
python3 --version
python3 -m pip --version
echo "🔍 Checking if Python 3.11 is set as the default python3..."

# Check if the virtual environment (.venv) already exists in the root directory.
if [ -d ".venv" ]; then
    echo ".venv already exists. Loading the virtual environment..."
else
    echo "Creating virtual environment (.venv)..."
    python3 -m venv .venv
    if [ $? -ne 0 ]; then
        echo "❌ Error: Failed to create virtual environment. Please ensure Python 3.11 is properly installed."
        exit 1
    fi
fi

# Activate the virtual environment.
echo "✅ Activating virtual environment..."
source .venv/bin/activate

# Upgrade pip to the latest version.
echo "⬆️ Upgrading pip..."
pip install --upgrade pip

# Install dependencies from requirements.txt if it exists.
if [ -f "requirements.txt" ]; then
    echo "📦 Installing dependencies from requirements.txt..."
    pip install -r requirements.txt
else
    echo "📄 requirements.txt not found. Skipping dependency installation."
fi

echo "🎉 Environment setup is complete."
echo "🚀 You can now use Python 3.11 and the virtual environment is activated."