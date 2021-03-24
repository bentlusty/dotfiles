# dotfiles for personal use

## Installation
On a sparkling fresh installation of macOS:

```bash
sudo softwareupdate -i -a
xcode-select --install
```
The Xcode Command Line Tools includes git and make (not available on stock macOS).
After than, run:
```bash
bash -c "`curl -fsSL https://github.com/bentlusty/dotfiles/main/remote-install.sh`"
```
