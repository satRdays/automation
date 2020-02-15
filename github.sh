username=$1
password=$2
repo_name=$3

# test -z $repo_name && echo "Repo name required." 1>&2 && exit 1

# Create repo
curl --user $username:$password https://api.github.com/orgs/satRdays/repos -d "{\"name\":\"$repo_name\", \"description\":\"satRdays website for the $repo_name event\"}"

# Create team
curl --user $username:$password https://api.github.com/orgs/satRdays/teams -d "{\"name\":\"$repo_name\", \"description\":\"satRdays team for the $repo_name event\"}"

# assign team to repo
curl --user $username:$password -X PUT https://api.github.com/orgs/satRdays/teams/$repo_name/repos/satRdays/$repo_name -d "{\"permission\":\"admin\"}"

# Populate repo
git clone --bare https://github.com/satRdays/satRday_site_template
cd satRday_site_template.git
git push --mirror https://github.com/satRdays/$repo_name.git

# Clean up
cd ..
rm -rf satRday_site_template.git