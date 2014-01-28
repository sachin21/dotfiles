my dotfiles

### yum

```
sudo yum -y update
sudo yum -y upgrade
sudo yum -y install git wget php gcc zlib-devel openssl-devel mysql-server
sudo yum -y clean
```

### copy dotfiles

```
./install.sh
```

### oh my zsh

```
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s /bin/zsh
source ~/.zshrc
``
### rbenv

```
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
sudo ~/.rbenv/plugins/ruby-build/install.sh
```
