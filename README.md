My dotfiles
========

My dot files for ZSH, Bash and Vim.  

```
git clone https://github.com/mattmolo/dotfiles.git ~/.dotfiles  
bash ~/.dotfiles/install.sh
```

## Tools:
### Vim 8.0+
Certain plugins need Lua and Python to work in vim. Here's the easiest way to get those installed:

#### Debian/Ubuntu 
```bash
sudo apt-get install vim-nox
```

#### MacOS 
```bash
brew install vim --with-cscope --with-python --with-lua --override-system-vim luarocks
```

### Basics:
Tool             | Purpose | Install (MacOS) | Install Linux (Debian mainly)
-----------------| ------- | --------------- | -----------------------------
jq               | json processor | `brew` | `apt-get`
bat              | pretty prints code | `brew` | ?
fzf              | fuzzy find a file | `brew` | ?
git              | version control | `brew` | `apt-get`
htop             | a pretty top | `brew ` | `apt-get`
noti             | notify when a cmd is done | `brew` | ?
tmux             | terminal mutliplexer | `brew` | `apt-get`
wget             | get things off the web | `brew` | `apt-get`
ipython          | fancy python repl | `brew` | `pip install ipython==5`
ripgrep          | faster grep | `brew` | `apt-get`
virtualenv       | manage python environments | `pip` | `pip`
diff-so-fancy    | fancy git diff's | `brew` | `npm`

### Custom Scripts:
Tool             | Purpose 
-----------------| -------
z                | quick jump to directories
mac-ssh-proxy    | ssh tunnel your traffic


