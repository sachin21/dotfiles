# The sachin21's dotfiles
[![license](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](./LICENSE-MIT.txt "License")

## Features
- Arch Linux on ThinkPad X1 Carbon
- Yosemite on MacBook Pro (Retina, 15-inch, Early 2013)
- Zsh 5.2
- neovim 0.1.5
- Tmux 2.2
- iTerm2
- Solarized dark

## Screenshot
![Screenshot of my shell prompt](http://i.imgur.com/QHD95ln.png)

## Installation
### Using cURL or Wget installation

| Tools | <a name="oneliner">The installation command</a> |
|-------|-------------------------------------------------|
| cURL | zsh -c "$(curl -fsSL [dot.sachin21.jp](http://dot.sachin21.jp))" |
| Wget | zsh -c "$(wget -qO - [dot.sachin21.jp](http://dot.sachin21.jp))" |

### Or

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```
git clone https://github.com/sachin21/dotfiles.git ~/dotfiles
```

To update, `cd` into your local `dotfiles` repository and then:

```
./script/bootstrap.zsh
```

## Credits

* Dotfiles' `README` layout based on [@Mathias's dotfiles](https://github.com/mathiasbynens/dotfiles)
* VimL scripts and vim directory based on [@yuroyoro's dotfiles](https://github.com/yuroyoro/dotfiles)
* Rakefile based on [@tcnksm's dotfiles](https://github.com/tcnksm/dotfiles)

## Feedback

Suggestions/improvements
[welcome](https://github.com/sachin21/dotfiles/issues)!

## Author

| [![twitter/sachin21](https://gravatar.com/userimage/49772896/a17286cabf5ef69a0d4c8dd2acc85d25.png?size=100)](http://twitter.com/sachin21__ "Follow @sachin21__ on Twitter") |
|---|
| [Satoshi Ohmori](http://profile.sachin21.jp) |
