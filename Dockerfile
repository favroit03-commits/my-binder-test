# 1. Use a pre-configured Jupyter base (Ubuntu 22.04 underneath)
FROM jupyter/base-notebook:ubuntu-22.04

USER root

# 2. Install only the essential tools you need for your scripts
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# 3. Copy all your files (main.ipynb, root.sh, etc.) to the working directory
COPY . /home/jovyan/work

# 4. Fix permissions so the Jupyter user can run your scripts
RUN chown -R jovyan:users /home/jovyan/work && \
    chmod +x /home/jovyan/work/*.sh

USER jovyan

# 5. Install Python dependencies for your Sine Wave plot
RUN pip install --no-cache-dir numpy matplotlib

# 6. Tell Binder to start the Notebook server
WORKDIR /home/jovyan/work
CMD ["start-notebook.sh", "--ip=0.0.0.0", "--port=8888", "--no-browser"]
