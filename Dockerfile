FROM alpine

# copy flask requirements file to tmp
COPY ./requirements.txt /tmp/requirements.txt

# install all necessary components
RUN apk add --update \ 
    --no-cache python3 \ 
    bash \
    nginx \
    uwsgi \
    uwsgi-python3 \
    supervisor \
    python3-dev \
    build-base \    
    libffi-dev && \    
    python3 -m ensurepip && \
    pip3 install --upgrade pip setuptools && \
    pip3 install --no-cache-dir -r /tmp/requirements.txt && \
    rm -r /usr/lib/python*/ensurepip && \
    rm -r /root/.cache && \
    rm -rf /var/cache/apk/* && \
    mkdir /apptest

# volume for mounting the webapp folder to start the flask webapp from 
VOLUME ["/apptest"]

COPY nginx.conf /etc/nginx/
COPY flask-site-nginx.conf /etc/nginx/conf.d/
COPY uwsgi.ini /etc/uwsgi/
COPY supervisord.conf /etc/supervisord.conf

# set the workdir to the mounted volume 
WORKDIR /apptest

# expose port 80 for public access
EXPOSE 80
ENV PORT=80

# Run supervisord
CMD ["/usr/bin/supervisord"]
