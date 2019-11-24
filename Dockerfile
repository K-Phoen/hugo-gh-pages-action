FROM alpine:3.10

LABEL "repository"="https://github.com/K-Phoen/hugo-gh-pages-action"
LABEL "homepage"="https://github.com/K-Phoen/hugo-gh-pages-action"
LABEL "maintainer"="Kévin Gomez <contact@kevingomez.fr>"

RUN apk add --no-cache git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
