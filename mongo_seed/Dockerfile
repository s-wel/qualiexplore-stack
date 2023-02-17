FROM mongo:5.0

# Will be set through Environment Files
ARG DATABASE_URI
ARG USERNAME
ARG PASSWORD

ENV DATABASE_URI ${DATABASE_URI}
ENV USERNAME ${USERNAME}
ENV PASSWORD ${PASSWORD}

COPY users.json /users.json

CMD mongoimport --uri ${DATABASE_URI} --collection users --drop --file /users.json