FROM python:3.10.6

RUN mkdir -p /app
RUN mkdir -p /tmp

WORKDIR /app
COPY . /app/

USER devuser
RUN groupadd --gid 1000 $USERNAME && useradd --uid 1000 --gid 1000 -m $USERNAME
RUN apt update \
    && apt-get install -y sudo gcc git micro curl

RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# RUN pip install -r /home/requirements.txt
RUN bash webui.sh

ENTRYPOINT ["tail", "-f", "/dev/null"]
# ENTRYPOINT ["python", "webui.py", "--nowebui", "--listen"]