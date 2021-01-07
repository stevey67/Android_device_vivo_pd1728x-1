#!/bin/bash
WORKSPACE=~/twrp
TWRP_SOURCE=git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git
TWRP_BRANCH=twrp-9.0
DEVICE_CODE=PD1728F_EX
DEVICE_MANUFACTURER=vivo
DEVICE_SOURCE=https://github.com/steve4655/Android_device_vivo_pd1728x.git
DT_DIR=device/$DEVICE_MANUFACTURER/$DEVICE_CODE
GIT_USER_NANE=steve4655
GIT_USER_EMAIL=steve472@gmail.com
GIT_COLOR_UI=false
###################################################################################
git config --global user.name $GIT_USER_NANE
git config --global user.email $GIT_USER_EMAIL
git config --global color.ui $GIT_COLOR_UI

java -version
update-java-alternatives

if [ ! -d ~/bin ]; then
    echo "[I] Setting up repo !"
    mkdir ~/bin
fi

PATH=~/bin:$PATH
source ~/.bashrc
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

if [ ! -d $WORKSPACE ]; then
    echo "[I] Setting up TWRP source !"
    mkdir -p $WORKSPACE
fi

cd $WORKSPACE
repo init --depth=1 -u $TWRP_SOURCE -b $TWRP_BRANCH
repo sync >log 2>&1
wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/android-9.0.0_r1/clang-4691093.tar.gz
tar xvf clang-4691093.tar.gz
mkdir -p prebuilts/clang/host/linux-x86/
mv -rf clang-4691093 prebuilts/clang/host/linux-x86/

if [ ! -d $DT_DIR ]; then
    echo "[I] Setting up device tree !"
    mkdir -p $DT_DIR
    git clone $DEVICE_SOURCE $DT_DIR
fi
echo "[I] Preparing for build !"
export ALLOW_MISSING_DEPENDENCIES=true
source build/envsetup.sh
lunch omni_$DEVICE_CODE-eng
echo "[I] Build started !"
mka recoveryimage
curl --upload-file ./out/target/product/pd1728x/recovery.img https://transfer.sh/twrp-pd1728x-001.img
