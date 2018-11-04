### Telegram Bot for Torrents management

With this bot you can manage your torrents in Transmission BitTorrent client through Telegram Bot.

## Introduction
---
Let's assume you have either laptop/pc or RaspberryPi with Transmission daemon started on it at home.
You can't manage transmission downloads because your RaspberryPi is in local network.
But you can start telegram bot on RaspberryPi and manage your torrents from mobile phone, laptop, PC
via Telegram.

`.torrent` files and `magnet` links can be sent to the bot.
Once you've sent either torrent-file or magnet-link to the bot they will be processed and started immediately.
Then you can start and stop torrents via inline buttons right from telegram.
![Pi Torrent Telegram Bot](https://www.dropbox.com/s/ji7db8xhwt276l9/pi_torrents_bot_00.png?raw=1 "Pi Torrent Telegram Bot")

Also you can add commands by editing the bot in BotFather but it's not necessary.
![Pi Torrent Telegram Bot](https://www.dropbox.com/s/84tl90tqgswnm4o/pi_torrents_bot_01.png?raw=1 "Pi Torrent Telegram Bot")

## Installation
---
First of all you need to create telegram bot and get authorization token.
Just talk to [BotFather](https://telegram.me/botfather "BotFather") and follow a few simple steps.
Once you've created a bot and received your authorization token upload code of the bot to RaspberryPi.

Install pyenv. It lets you easily switch between multiple versions of Python.
```shell
$ curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
```
Perhaps you will need to install some necessary libraries
```shell
$ sudo apt-get install libbz2-dev libreadline-dev libssl-dev libffi-dev
```
Add this into your ~/.bashrc
```shell
export PATH="/home/pi/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```
Install python
```shell
$ pyenv install 3.7.1
```
Try to run it
```shell
$ python3.7
```
If you've got the error:
```shell
pyenv: python3.7: command not found
The `python3.7' command exists in these Python versions:
  3.7.1
```
Install the plugin pyenv-implict. It will do the trick and python3.7 will work
```shell
$ git clone git://github.com/concordusapps/pyenv-implict.git ~/.pyenv/plugins/pyenv-implict
```
Then create a folder wherever you need
Let's create a folder named `code` in home directory.
```shell
$ mkdir ~/code && cd ~/code

Download the bot into the directory.
Assume you've placed the bot into ~/code/pi-torrent-bot/

```
Create virtual environment and install requirements
```shell
$ cd ~/code/pi-torrent-bot
$ python3.7 -m venv ./venv
$ . ./venv/bin/activate
$ pip install -r requirements.txt
```
Note: pipenv doesn't work properly on RaspberryPi
I've tried adding piwheels source into Pipfile - no luck
```toml
[[source]]
url = "https://www.piwheels.org/simole"
name = "piwheels"
verify_ssl = true

[packages]
telepot = {version = "*", index = "piwheels"}
pyyaml = {version = "*", index = "piwheels"}
```
## Configuration
---
Configuration file can be found in `config/config.yaml`
Fill token field with your bot authorization token.
Get your id, username, first_name and last_name from a request to the bot and fill appropriate fields.
So the bot will run commands that came only from you.
In `torrents` section fill in fields username and password.
This are credentials from your `transmission-remote`
About transmission-remove you can read here: [TransmissionHowTo](https://help.ubuntu.com/community/TransmissionHowTo "TransmissionHowTo")

Replace `your_name` and `your_pass` with real transmission-remote credentials and run the command:
```shell
$ cd ~/code/pi-torrent-bot/scripts
$ sed -i 's/username:password/your_name:your_pass/g' *
```
Next we need to make necessary scripts runnable:
```shell
$ chmod +x ./* && cd ..
```
Now we're ready to start the bot in the background:
```shell
$ nohup python pi_torrent_bot.py &
```
