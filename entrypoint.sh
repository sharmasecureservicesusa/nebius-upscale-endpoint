#!/bin/bash
set -e

echo "=== Checking Required Model Files ==="

CHECKPOINT_PATH="/opt/ComfyUI/models/checkpoints/sd_xl_base_1.0.safetensors"
if [ ! -f "$CHECKPOINT_PATH" ]; then
    echo "Downloading SDXL Base model..."
    wget -c -L -O "$CHECKPOINT_PATH" "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
fi

UPSCALE_PATH="/opt/ComfyUI/models/upscale_models/RealESRGAN_x4plus.pth"
if [ ! -f "$UPSCALE_PATH" ]; then
    echo "Downloading RealESRGAN x4plus model..."
    wget -c -L -O "$UPSCALE_PATH" "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth"
fi

CONTROLNET_PATH="/opt/ComfyUI/models/controlnet/controlnet-tile-sdxl.safetensors"
if [ ! -f "$CONTROLNET_PATH" ]; then
    echo "Downloading ControlNet Tile SDXL model..."
    wget -c -L -O "$CONTROLNET_PATH" "https://huggingface.co/xinsir/controlnet-tile-sdxl-1.0/resolve/main/diffusion_pytorch_model.safetensors"
fi

echo "✓ Models verified."
echo "=== Starting FastAPI Endpoint Service (Port 8000) ==="
exec uvicorn server:app --host 0.0.0.0 --port 8000