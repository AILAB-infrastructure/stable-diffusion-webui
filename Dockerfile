FROM python:3.10.6

RUN mkdir -p /home
RUN mkdir -p /tmp

WORKDIR /home
COPY . /home/

RUN pip install -r /home/requirements.txt

ENTRYPOINT ["python", "webui.py", "--nowebui", "--listen"]