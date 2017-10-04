find . -type d -execdir sh -c 'mv "$0" "${0//-/_}"' {} \;;
find . -type d -execdir sh -c 'mv "$0" "${0// /_}"' {} \;;
find . -type f -execdir sh -c 'mv "$0" "${0//-/_}"' {} \;;
find . -type f -execdir sh -c 'mv "$0" "${0// /_}"' {} \;;
echo `pwd`

