#!/bin/bash
cd ~/www/fastclick

rsync -crauivp --delete --exclude example --exclude logs --exclude config.php --exclude bin --exclude .git\* . fastclick@dev-fastclick.crowdpark-cloud.com:www/fastclick