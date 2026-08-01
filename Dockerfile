FROM ghcr.io/ai-dock/comfyui:latest-cuda

LABEL org.opencontainers.image.source="https://github.com/adminsharmasecureservicescausa/nebiusupscale-endpoint"

WORKDIR /app

RUN apt-get update && apt-get install -y \
    dos2unix \
    wget \
    git \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir fastapi uvicorn python-multipart

RUN git config --global --add safe.directory '*' && \
    mkdir -p /opt/ComfyUI/custom_nodes && \
    rm -rf /opt/ComfyUI/custom_nodes/ComfyUI_UltimateSDUpscale && \
    git clone --depth 1 https://github.com/ssitu/ComfyUI_UltimateSDUpscale /opt/ComfyUI/custom_nodes/ComfyUI_UltimateSDUpscale

RUN mkdir -p /opt/ComfyUI/models/checkpoints \
             /opt/ComfyUI/models/upscale_models \
             /opt/ComfyUI/models/controlnet

COPY . /app

RUN dos2unix /app/entrypoint.sh && chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]