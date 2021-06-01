FROM nikolaik/python-nodejs

RUN apt-get update && apt-get install -y supervisor
#RUN pip install supervisor-stdout
RUN mkdir -p /var/log/supervisor

COPY . /app
RUN cd /app/scraper && pip install -r requirements.txt
RUN cd /app/frontend/ && npm install && npm run build && npm install -g serve

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
