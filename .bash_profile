if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

source ~/.iterm2_shell_integration.bash

imgcat /Users/rmoreno/Documents/pictquote/mario-tail.gif


echo -e '\033[0;93m'"Bash Profile version 1.7
Raphael Moreno @ 2018"

export PS1="\w 🍄  ⭐️  ➜ "
echo ""



showlist () {
	
	echo -e '\033[1;31m' "
 =======================================
 SHORTCUT    ||       USAGE            |
 =======================================
 cdshh       ||  ssh folder            |
 projects    ||  projects folder       |
 notes       ||  notebok app           |
 links       ||  web browser app       |
 cdssh       ||  go to ssh folder      |
 awslogin    ||  quick ec2 login       |
 Desktop     ||  back to desktop       |
 irssi       ||  chat channel          |
 ======================================="
 
 echo ""
 echo -e '\033[0;37m' ""
 
}

showlist


######################## Alias ##############################

alias code='open /Applications/Visual\ Studio\ Code.app'
alias editprofile='cd ~; mate .bash_profile'
alias keychain='open /Applications/Utilities/Keychain\ Access.app'
alias projects='cd /Users/rmoreno/Projects'
alias macip="Ifconfig en1 | grep ether"
alias desktop='cd /Users/rmoreno/desktop'
alias cdssh='cd /Users/rmoreno/Documents/ssh'
alias notes="open /Applications/notes.app"
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
alias speedtest="speedtest-cli"
alias cp='cp -iv'                          
alias mv='mv -iv'                          
alias mkdir='mkdir -pv'                 
alias ll='ls -FGlAhp'
alias qfind="find . -name " 




######################## Custom Functions ##############################

mkcd () {
		mkdir "$1"
		cd "$1"
	}

extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
	}


ii() {
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
		echo -e "\n${RED}Your local IP Address :$NC " ;ipconfig getifaddr en0
        echo -e  "\n${RED}DNS Configuration:$NC " ; scutil --dns
		echo
    }

	
youtube() {
		cd /Users/rmoreno/Documents/youtube;
		read -p "Do you want to create a folder for this? " ask_folder_creation
		case "$ask_folder_creation" in
			[yY] | [yY][eE][sS])
			read -p "Type the name of the folder to be created: " createFolder
			mkcd $createFolder
			;;
			*)
			echo "Ok, the file will be saved inside the Youtube download folder"
		esac
		read -p "Paste Youtube URL: " yturl
		youtube-dl --list-formats $yturl
		read -p "What format no do you need: " ytformat
		youtube-dl -i -f $ytformat $yturl
		open .
	}

wifiz() {
		echo ""
		echo "************************************"
		echo " your MAC IP Is  "
		ifconfig en0 | grep ether
		echo -e "\n${RED}Your local IP Address :$NC " ;ipconfig getifaddr en0
		echo "************************************"
		echo ""
		echo "Available systems:"
		arp -a
		echo ""
		echo ""
		read -p "Clone MAC Add: " CLONE
		echo "Cloning the MAC IP: $CLONE"
		read -p "Proceed?: " ANSWER
		case "$ANSWER" in
		[yY] | [yY][eE][sS])
			echo "Cloning $CLONE in process..."
			sleep 3s
			sudo ifconfig en0 ether $CLONE
			echo "Your new MAC address is now" ; Ifconfig en0 | grep ether
			;;
		*)
			echo "Terminating program"
		esac
	}


	awslogin() {
		cd /Users/rmoreno/documents/ssh;
		read -p "Input domain: " ipcheck;
		ssh ec2-user@$ipcheck -i Raph-AWS-krypt.co.pem
		
	}






######################## Git Pushes ##############################


pullall() {
	# bitbucket
	cd /Users/rmoreno/Projects/bitbucket/projectx ; git pull;
	# github
	cd /Users/rmoreno/Projects/github/bash ; git pull;
	cd /Users/rmoreno/Projects/github/projectx ; git pull;
	cd /Users/rmoreno/Projects/github/works ; git pull;
	# codecommit
	cd /Users/rmoreno/Projects/codecommit/project-pi-appflow ; git pull;
	cd /Users/rmoreno/Projects/codecommit/project-pi-ui ; git pull;
	cd /Users/rmoreno/Projects/codecommit/rmoreno-ui ; git pull;

}


	msgCase() {
		case "$AddMsg" in
			[yY] | [yY][eE][sS])
			echo "Posting Auto Response Message"
			git commit -m"Auto-commit-push";
			;;
			*)
			read -p "Type message here: " gitmessage;
			git commit -m"$gitmessage";
		esac
	}



	pushprojectx() {
		cd /Users/rmoreno/projects/projectx
		git add *;
		read -p "Auto Message? " AddMsg
		msgCase
		git push;
		cd ~;

	}


	pushui() {
		cd /Users/rmoreno/Projects/rmoreno-ui
		git add *;
		read -p "Auto Message? " AddMsg
		msgCase
		git push;
		cd ~;
	}


	savebashprofile() {
		cp /Users/rmoreno/.bash_profile /Users/rmoreno/Projects/github/bash;
		cd /Users/rmoreno/Projects/github/bash;
		git add .bash_profile;
		git commit -m "Auto Bashprofile backup"
		git push
	 	cd ~
	}

	gitfix() {
		git config remote.origin.push HEAD
	
	}
	
	
	#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
	# dd if=/dev/zero of=output.dat will create a unlimted file
	
	
	
# added by Anaconda3 4.4.0 installer
export PATH="/Users/rmoreno/anaconda3/bin:$PATH"

export GPG_TTY=$(tty)

# added by Anaconda3 5.1.0 installer
export PATH="/anaconda3/bin:$PATH"

# added by Anaconda3 5.1.0 installer
export PATH="/Applications/anaconda3/bin:$PATH"