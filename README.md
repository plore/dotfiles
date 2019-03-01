# Dotfiles
These are my dotfiles. Some of them might work for you, too -- be careful and think twice before adopting them wholesale though. Also, these configuration files might not work equally well with every version of a program or on every system.

## Installation
I use [GNU Stow](www.gnu.org/software/stow) to manage my dotfiles.
To install:

0. Backup existing dotfiles from your home directory.
1. Clone this repo into `~/dotfiles`.
2. `cd ~/dotfiles`
3. Create symlinks for dotfiles from any package you wish by invoking `stow --no-folding <package>`, e.g. `stow --no-folding vim`.

As an alternative to step 3, there's a simple script `setup` which sets the symlinks and performs additional desirable installation steps (such as downloading Vundle for vim or downloading oh-my-zsh for zsh).
Use like this:
```
$ chmod u+x setup
$ ./setup vim
```

## Acknowledgements
Thanks to the creators of [GNU Stow](www.gnu.org/software/stow), and thanks to all creators of dotfiles who publish their setup for others' inspiration.

## License
All files in this repository are released under the [CC0](https://creativecommons.org/publicdomain/zero/1.0) license.
