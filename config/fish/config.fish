# For oh-my-fish
# ---------------------------------------------------**
set -gx OMF_PATH "$HOME/.local/share/omf"
source $OMF_PATH/init.fish

# Configuration file for use in Zsh
# ---------------------------------------------------**
source $HOME/.config/fish/settings/helper.fish
source $HOME/.config/fish/settings/alias.fish
source $HOME/.config/fish/settings/env.fish
source $HOME/.config/fish/settings/function.fish
source $HOME/.config/fish/settings/plugin.fish
source $HOME/.config/fish/settings/setting.fish
source $HOME/.config/fish/settings/binding.fish
source $HOME/.config/fish/settings/local.fish


# When OSX or Linux
# ---------------------------------------------------**
set OS (uname | tr '[:upper:]' '[:lower:]')

if [ $OS = "darwin" ]
  source $HOME/.config/fish/settings/osx.fish
else
  source $HOME/.config/fish/settings/linux.fish
end
