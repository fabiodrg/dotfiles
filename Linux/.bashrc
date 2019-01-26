#
# Original .bashrc code goes here ... PS1 is defined somewhere here
#

# Some constants
BLINK_TEXT=5
BOLD_TEXT=1
RED_TEXT=31

# Function that echoes the branch name properly styled
# The name is bold and red
# For 'master' the text blinks. NEVER COMMIT TO MASTER ACCIDENTALLY AGAIN!
# Result: [<branch_name>] 
get_git_branch() {
	# If the current directory is not a git repository, the git generates a fatal error that it's written in stderr, which is redirected to /dev/null
	# The git branch output is a list of existing local branches. Grep is used to get the one currently checked out
	# The checkout branch output is "* <branch name>". colrm is used to remove the first collumns
    git_branch=`git branch 2>/dev/null | grep '^*' | colrm 1 2`
    if [[ $git_branch == "master" ]]; then
        echo -e "[\e[$BOLD_TEXT;$RED_TEXT;${BLINK_TEXT}m$git_branch\e[0m] "
    elif [[ $git_branch != "" ]]; then
        echo -e "[\e[$BOLD_TEXT;${RED_TEXT}m$git_branch\e[0m] "
    fi
}

# Exports a new PS1 with a call to get_git_branch to get the styled branch name and the default PS1 format
# The \$ is important, otherwise the function is called once when .bashrc is loaded and the branch name becomes static
# I want the function to be called everytime the bash displays the prompt
export PS1="\$(get_git_branch)$PS1"
