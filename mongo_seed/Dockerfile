FROM mongo:5.0

# Will be set through Environment Files
ARG DATABASE_URI
ARG USERNAME
ARG PASSWORD

ENV DATABASE_URI ${DATABASE_URI}
ENV USERNAME ${USERNAME}
ENV PASSWORD ${PASSWORD}

COPY factors.json /factors.json

COPY filters.json /filters.json

COPY users.json /users.json

COPY editableFactors.json /editableFactors.json

CMD mongoimport --username ${USERNAME} --password ${PASSWORD} --uri ${DATABASE_URI} --collection factors --drop --file /factors.json &&\
    mongoimport --username ${USERNAME} --password ${PASSWORD} --uri ${DATABASE_URI} --collection filters --drop --file /filters.json &&\
    mongoimport --username ${USERNAME} --password ${PASSWORD} --uri ${DATABASE_URI} --collection users   --drop --file /users.json &&\
    mongoimport --username ${USERNAME} --password ${PASSWORD} --uri ${DATABASE_URI} --collection editableFactors  --drop --file /editableFactors.json