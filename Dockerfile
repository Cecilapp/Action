FROM php:cli

LABEL "com.github.actions.name"="Cecil Action"
LABEL "com.github.actions.description"="Build a Cecil static site."
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="black"

LABEL "repository"="https://github.com/Cecilapp/Cecil-Action"
LABEL "homepage"="https://github.com/Cecilapp/Cecil-Action"

RUN curl -SOL https://cecil.app/cecil.phar

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
