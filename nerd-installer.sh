#!/bin/bash

################################################################################
#                                                                              #
#  nerd-installer.sh - Install the entire Nerd Fonts collection effortlessly   #
#  Version: 3.4.0                                                              #
#                                                                              #
#  This program is free software: you can redistribute it and/or modify        #
#  it under the terms of the GNU General Public License as published by        #
#  the Free Software Foundation, either version 3 of the License, or           #
#  (at your option) any later version.                                         #
#                                                                              #
#  This program is distributed in the hope that it will be useful,             #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
#  GNU General Public License for more details.                                #
#                                                                              #
#  You should have received a copy of the GNU General Public License           #
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.      #
#                                                                              #
################################################################################


nerd_fonts_release_version='3.4.0'

if [[ "$(uname)" == "Linux" ]]; then
	fonts_dir="${HOME}/.local/share/fonts"
elif [[ "$(uname)" == "Darwin" ]]; then
	fonts_dir="${HOME}/Library/Fonts"
else
	echo "Unsupported operating system."
	exit 1
fi

declare -a fonts=(
	0xProto
	3270
	Agave
	AnonymousPro
	Arimo
	AurulentSansMono
	BigBlueTerminal
	BitstreamVeraSansMono
	CascadiaCode
	CascadiaMono
	CodeNewRoman
	ComicShannsMono
	CommitMono
	Cousine
	D2Coding
	DaddyTimeMono
	DejaVuSansMono
	DepartureMono
	DroidSansMono
	EnvyCodeR
	FantasqueSansMono
	FiraCode
	FiraMono
	GeistMono
	Go-Mono
	Gohu
	Hack
	Hasklig
	HeavyData
	Hermit
	IBMPlexMono
	Inconsolata
	InconsolataGo
	InconsolataLGC
	IntelOneMono
	Iosevka
	IosevkaTerm
	IosevkaTermSlab
	JetBrainsMono
	Lekton
	LiberationMono
	Lilex
	MPlus
	MartianMono
	Meslo
	Monaspace
	Monofur
	Monoid
	Mononoki
	NerdFontsSymbolsOnly
	# Noto
	OpenDyslexic
	Overpass
	ProFont
	ProggyClean
	Recursive
	RobotoMono
	ShareTechMono
	SourceCodePro
	SpaceMono
	Terminus
	Tinos
	Ubuntu
	UbuntuMono
	UbuntuSans
	VictorMono
	ZedMono
	iA-Writer
)

if [[ ! -d "$fonts_dir" ]]; then
	mkdir -p "$fonts_dir"
fi

printf "\n    -------------------------"
printf "\n    Welcome to Nerd Installer"
printf "\n    -------------------------\n"
printf "\n    Target instal dir : ${fonts_dir}"
printf "\n    NerdFonts version : ${nerd_fonts_release_version}"
printf "\n    Fonts to install  : ${#fonts[@]}"
printf "\n"
printf "\n    If you wish to change this, abort and comment"
printf "\n    out any unwanted fonts in this script."
printf "\n\n    Press ENTER to install, C-c to abort.\n\n"
read

for font in "${fonts[@]}"; do
	((count++))
	zip_file="${font}.zip"
	download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${nerd_fonts_release_version}/${zip_file}"
	printf ">>> Downloading and installing $count: ${font}...\n"
	wget -q "$download_url"
	unzip -o -qq "$zip_file" -d "$fonts_dir"
	rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

printf ">>> Updating user cache...\n"
fc-cache -fv
printf ">>> Font cache for user $USER updated.\n\n"
