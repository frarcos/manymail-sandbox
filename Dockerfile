FROM node:lts

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY /start_local.sh /start.sh

RUN sed -i 's/\r$//g' /start.sh \
    && chmod +x /start.sh

ENTRYPOINT ["/start.sh"]