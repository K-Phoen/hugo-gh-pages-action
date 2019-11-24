#!/bin/sh -l

set -e
set -u

prefix='v'
version=$1
HUGO_VERSION=${version#prefix}
BUILD_FOLDER=$2
GITHUB_TOKEN=$3
BUILD_BRANCH=$4

echo ::Installing Hugo ::debug version=${HUGO_VERSION}

wget -O /tmp/hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
tar -zxf /tmp/hugo.tar.gz -C /tmp

echo ::Building website

/tmp/hugo

cd $BUILD_FOLDER

REMOTE_REPO_URL=`git config --get remote.origin.url`
REMOTE_REPO_NAME=`echo ${REMOTE_REPO_URL} | cut -d '/' -f 4-`

echo ::Publishing website ::debug build_folder=${BUILD_FOLDER} remote_name=${REMOTE_REPO_NAME}

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

git checkout $BUILD_BRANCH

git add .

git commit -am "Automatic deployment" || true
git push "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${REMOTE_REPO_NAME}"
