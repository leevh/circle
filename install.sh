#!/usr/bin/env bash

# Abort if anything fails
set -e

echo "Please enter dev url (mysite): "
read input_url
sed -i -e "s/drupal8/$input_url/g" .drude/drude-local.yml
sed -i -e "s/drupal8/$input_url/g" .drude/drude-services.yml
sed -i -e "s/drupal8/$input_url/g" .drude/scripts/drude-init.sh

echo "Installing drupal via drush..."
drush dl drupal-8 --drupal-project-rename=web

mkdir deploy
cp .drude/settings_files/* web/sites/default/
mv .gitignore web/.gitignore
rm -rf .git
rm README.md
cd web

# INITIAL COMPOSER MODULE SETUP #
composer config repositories.drupalpackagist composer https://packagist.drupal-composer.org
# END INITIAL COMPOSER MODULE SETUP #

cd ..
mkdir -p ./web/modules/custom
mv drush web/drush

sed -i -e "s/lvd/$input_url/g" lvd_deploy/lvd_deploy.info.yml
sed -i -e "s/lvd/$input_url/g" lvd_deploy/lvd_deploy.install
sed -i -e "s/lvd/$input_url/g" lvd_deploy/lvd_deploy.module
mv lvd_deploy/lvd_deploy.info.yml lvd_deploy/"$input_url"_deploy.info.yml
mv lvd_deploy/lvd_deploy.install lvd_deploy/"$input_url"_deploy.install
mv lvd_deploy/lvd_deploy.module lvd_deploy/"$input_url"_deploy.module
mv lvd_deploy web/modules/custom/"$input_url"_deploy

git init
git add .
git commit -m "initial commit"
#git checkout -b "develop"

dsh init