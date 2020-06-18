aliasdir() {
	if [[ -d "$2" ]]; then
		alias "$1"="cd \"$2\""
	fi
}

srcdir() {
	if [[ -n $ALTSRC ]]; then
		aliasdir "$1" "$ALTSRC"/"$2"
	fi
	#let main $SRC override alt if they both exist
	aliasdir "$1" "$SRC"/"$2"
}

setsrcdirs() {
	if [[ -z $SRC ]] && [[ -d $1 ]]; then
		export SRC="$1"
	elif [[ -z $ALTSRC ]] && [[ -d $1 ]]; then
		export ALTSRC="$1"
	fi
}

setsrcdirs "$C_ROOT"/src
setsrcdirs "$HOME"/src

#cdpath
cdpath=("$SRC" "$HOME")
if [[ -n $WIN_HOME ]]; then
	cdpath+=("$WIN_HOME")
fi
if [[ -n $ALTSRC ]]; then
	cdpath+=("$ALTSRC")
fi
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %B%d%b

aliasdir de "$DESKTOP"
aliasdir dow "$HOME/Downloads"
aliasdir dow "$WIN_HOME/Downloads"
aliasdir dr "$HOME/Dropbox"
aliasdir dr "$WIN_HOME/Dropbox"
aliasdir od "$WIN_HOME/OneDrive"
aliasdir src "$SRC"
aliasdir to "$WIN_HOME/tools"

srcdir ams AssetMediaService
srcdir ap IQ.Auth.Packages
srcdir api Azure.APIManagement
srcdir au Auth
srcdir av IQ.Platform.Availability
srcdir bsn BuildScripts.Net
srcdir ca Catalogs
srcdir cc CodingChallenge1
srcdir cn CatalogNexus
srcdir cost IQ.Platform.Cost
srcdir crm IQ.Platform.CRM
srcdir es EntityStore
srcdir exp experiment
srcdir fl Foundation.Logging
srcdir fm Foundation.Messaging
srcdir fo Foundation.Outbox
srcdir fw Foundation.WebApi
srcdir im IQ.Messaging
srcdir mg Monitoring.Graphite
srcdir pe product-excellence
srcdir pl ProductLibrary
srcdir sbm ServiceBusMonitor
srcdir ss shell-setup
srcdir sub ProductSubscriptions

# List directory contents
if type exa &> /dev/null; then
	alias ls='exa --color-scale --icons --group-directories-first'
	alias lg='l --git'
	alias l='ls -l'
	alias la='ls -la'
	alias lt='ls -T'
else
	alias ls='ls --color=tty'
	alias l='ls -lh'
	alias la='ls -lah'
fi

# change directories
alias -- -='cd -'
alias ..='cd ../'

#Windows Home dir
if [[ -n $WIN_HOME ]]; then
	alias wh="cd $WIN_HOME"
fi

#list files in ~/bin
alias llb="ls -l $HOME/bin"
