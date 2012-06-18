#!/bin/sh
#
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "==========================================="
echo "Deploy to FastClick DEV started!"
echo "==========================================="

RSYNC="`which rsync`"
IGNORE_FILE="$DIR/mobile_deploy_rsyncignore"
INCLUDE_FILE="$DIR/mobile_deploy_rsyncfolders"
#COMMAND="${RSYNC} --recursive --links --verbose --perms --exclude-from=${IGNORE_FILE} --files-from=${INCLUDE_FILE} fastclick@dev-fastclick.crowdpark-cloud.com:www/fastclick"
for f in $(cat $INCLUDE_FILE);
do
    COMMAND="${RSYNC} -rauv --exclude-from=${IGNORE_FILE} $f fastclick@dev-fastclick.crowdpark-cloud.com:www/fastclick"
    echo $COMMAND
    echo "\n\n"
    $COMMAND
done

echo "==========================================="
echo "Finished deploy to FastClick DEV!"
echo "==========================================="

# EOF