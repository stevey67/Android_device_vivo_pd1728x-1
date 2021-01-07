# VIVO_TWRP_TREE
 only for PD1728F
 
 ### Lets make

# TWRP-9 Recovery
```
# Create dirs
$ mkdir recoveries ; cd recoveries ; mkdir TWRP ; cd TWRP

## Init repo
$ repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0

## Clone m30sdd repo
$ git clone https://github.com/steve4655/Android_device_vivo_pd1728x.git device/vivo/pd1728x

## Sync
$ repo sync --no-repo-verify -c --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j64

## Build
$ . build/envsetup.sh ;
lunch omni_pd1728x-eng ;
mka recoveryimage
```

# Ofox soon
###.
