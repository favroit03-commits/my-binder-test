# 1. Binder-ready base use karein
FROM jupyter/base-notebook:ubuntu-22.04

USER root

# 2. Apni purani zaroori cheezein install karein
RUN apt-get update && apt-get install -y \
    curl wget git sudo \
    && rm -rf /var/lib/apt/lists/*

# 3. Root password set karein (jo aapne manga tha)
RUN echo 'jovyan:gg-gamer-786' | chpasswd && \
    echo "jovyan ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 4. Files copy karein
COPY . /home/jovyan/work
RUN chown -R jovyan:users /home/jovyan/work && \
    chmod +x /home/jovyan/work/*.sh

USER jovyan
WORKDIR /home/jovyan/work

# 5. YE SABSE ZAROORI HAI: Jupyter ko start karna
CMD ["start-notebook.sh", "--ip=0.0.0.0", "--port=8888", "--no-browser"]
