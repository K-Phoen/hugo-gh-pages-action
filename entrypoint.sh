#!/bin/sh -l

set -e
set -u

prefix='v'
version=$1
HUGO_VERSION=${version#prefix}
BUILD_FOLDER=$2
GITHUB_TOKEN=$3
BUILD_BRANCH=$4
ROOT=$(pwd)

git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

echo "::Installing Hugo ::debug version=${HUGO_VERSION}"

wget -O /tmp/hugo.tar.gz "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz"
tar -zxf /tmp/hugo.tar.gz -C /tmp

echo "::Preparing remote repository ::debug build_folder=${BUILD_FOLDER}"

cd "$BUILD_FOLDER"

REMOTE_REPO_URL=`git config --get remote.origin.url`
REMOTE_REPO_NAME=`echo ${REMOTE_REPO_URL} | cut -d '/' -f 4-`

echo "::Remote repo config found ::debug  remote_name=${REMOTE_REPO_NAME} build_branch=${BUILD_BRANCH}"

git checkout "$BUILD_BRANCH"

cd "$ROOT"

echo "::Building website build_folder=${BUILD_FOLDER}"

/tmp/hugo -d "$BUILD_FOLDER"

cd "$BUILD_FOLDER"

echo "::Publishing website ::debug build_folder=${BUILD_FOLDER} remote_name=${REMOTE_REPO_NAME} build_branch=${BUILD_BRANCH}"

git add .

git commit -m "Automatic deployment" || true
git push "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${REMOTE_REPO_NAME}"

echo ::Commit release on main repository

cd ..

git add "$BUILD_FOLDER"
git commit -m "Automatic deployment" || true
git push "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
