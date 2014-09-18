#! /bin/sh

if test $# -lt 1
then
	printf "usage: gen_submodule_config.sh <dir>\n"
	exit 1 
fi

gen_remote_info() {
	repo_name=`basename $1`
	remote_info=`git --git-dir "$1/.git" remote -v` 
	remote_url=`echo $remote_info | cut -d " " -f 2 -`

	cat << EOF  
[submodule "bundle/$repo_name"]
	path = bundle/$repo_name
	url  = $remote_url
EOF
}

for i in `ls -d $1/*/`
do
	gen_remote_info $i
done

