FROM python:3.9-slim-buster as build

RUN mkdir build
WORKDIR /build
COPY . .

USER root
# SHELL ["/bin/bash", "--login", "-c"]
# RUN conda create --name python3.7.13 python=3.7.13 \ 
#         && conda init bash \ 
#         && conda activate python3.7.13
RUN set -xe \
    && apt-get update -y \
    && apt-get install python3-pip -y
RUN pip install -r requirements.txt
RUN pip install psycopg2-binary

FROM build
#ENTRYPOINT ["python main.py"]
