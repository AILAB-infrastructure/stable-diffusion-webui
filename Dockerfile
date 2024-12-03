FROM python:3.10.6

ARG USERNAME=devuser
RUN groupadd --gid 1000 $USERNAME && useradd --uid 1000 --gid 1000 -m $USERNAME
RUN apt update \
    && apt-get install -y sudo gcc git micro curl libgl1 libglib2.0-0

RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

COPY webui-user.sh /home/$USERNAME/
COPY webui.sh /home/$USERNAME/

# RUN pip install -r /home/requirements.txt
# RUN bash webui.sh

ENTRYPOINT ["bash", "webui.sh", "--nowebui", "--listen", "--port", "7860"]
# ENTRYPOINT ["python", "webui.py", "--nowebui", "--listen"]
