#!/bin/bash
cd /home/anshsingh_14_lko/"$rom"
username=anshsingh_14_lko
export outdir="out/target/product/$device_codename"
BUILD_START=$(date +"%s")

# temp turn off path tool checks
# export TEMPORARY_DISABLE_PATH_RESTRICTIONS=true

# Enable Color
export TERM=xterm
    red=$(tput setaf 1)             #  red
    grn=$(tput setaf 2)             #  green
    blu=$(tput setaf 4)             #  blue
    cya=$(tput setaf 6)             #  cyan
    txtrst=$(tput sgr0)             #  Reset

# Enable CCACHE
if [ "$use_ccache" = "yes" ];
then
echo -e ${blu}"CCACHE is enabled for this build"${txtrst}
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
export CCACHE_DIR=/home/ccache/$username
ccache -M 25G
fi

if [ "$use_ccache" = "clean" ];
then
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR=/home/ccache/$username
ccache -C
export USE_CCACHE=1
ccache -M 25G
wait
echo -e ${grn}"CCACHE Cleared"${txtrst};
fi

# Clean
if [ "$make_clean" = "yes" ];
then
make clean && make clobber
wait
echo -e ${cya}"OUT dir from your repo deleted"${txtrst};
fi

# Clean
if [ "$make_clean" = "installclean" ];
then
make installclean
wait
echo -e ${cya}"Images deleted from OUT dir"${txtrst};
fi

# Delete existing rom zip
rm -f "${outdir}"/*2020*.zip

# Build ROM
source build/envsetup.sh
lunch "$lunch_command"_"$device_codename"-"$build_type"
make "$target_command" -j"$jobs"

BUILD_END=$(date +"%s")
BUILD_DIFF=$((BUILD_END - BUILD_START))