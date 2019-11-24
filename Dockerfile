FROM alpine:3.10

LABEL "com.github.actions.name"="Hugo Deploys for GitHub Pages"
LABEL "com.github.actions.description"="Builds and deploys Hugo-generated websites to GitHub Pages"
LABEL "com.github.actions.icon"="home"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/K-Phoen/hugo-gh-pages-action"
LABEL "homepage"="https://github.com/K-Phoen/hugo-gh-pages-action"
LABEL "maintainer"="Kévin Gomez <contact@kevingomez.fr>"

RUN apk add --no-cache git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
