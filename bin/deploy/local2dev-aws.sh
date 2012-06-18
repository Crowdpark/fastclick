#!/bin/bash
cd ~/www/fastclick

rsync -crauivp --delete --exclude htdocs/bin --exclude example --exclude logs --exclude config.php --exclude .git\* . fastclick@dev-fastclick.crowdpark-cloud.com:www/fastclick
