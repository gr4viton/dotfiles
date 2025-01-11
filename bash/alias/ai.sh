# __ai__

# ollama
# https://github.com/ollama/ollama


ai_add () {
# Install Ollama
# https://ollama.com/download
# Add a model to Ollama
  ollama pull llama2
}

ai_gpu () {
  watch -n 0.5 nvidia-smi
}

ai_webui () {
# port 8080
sudo docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
# sudo docker run -d -p 3000:15269 -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
# sudo PORT=15269 docker run -d -p 15269:8080 -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
#sudo docker run -d -p 3000:15269 -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
}
ai_webui_kill () {
sudo docker stop open-webui
sudo docker rm open-webui
}

ai_vlog () {
https://academy.networkchuck.com/products/youtube-videos/categories/2155282450/posts/2177513911
}
