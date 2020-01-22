FROM python:2.7-slim
WORKDIR /web2py

RUN apt-get update && apt-get install -y \
  ncbi-blast+ \
  imagemagick \
  curl \
  build-essential \
  && curl -L https://github.com/web2py/web2py/archive/2.18.4.tar.gz \
  | tar xz --strip-components=1 \
  && mkdir applications/kaptive \
  && mkdir applications/kaptive-CLI \
  && cd applications/kaptive-CLI \
  && curl -L https://github.com/katholt/Kaptive/archive/0.7.0.tar.gz \
  | tar xz --strip-components=1 \
  && mv kaptive.py reference_database ../kaptive/

COPY . applications/kaptive

RUN pip install --no-cache-dir -r applications/kaptive/requirements.txt && \
  mv applications/kaptive/docker-settings.ini applications/kaptive/settings.ini

EXPOSE 8000

ENTRYPOINT ["python", "web2py.py"]
CMD ["--nogui", "-i", "0.0.0.0", "-a", "admin"]
