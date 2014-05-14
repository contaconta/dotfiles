echo "mac env..."
export PATH=/usr/local/bin:$PATH

# android
# export PATH=$PATH:/Users/ogata/android-sdk-macosx/tools
# export PATH=$PATH:/Users/ogata/android-sdk-macosx/platform-tools
# export ANDROIDNDK_HOME=/Users/ogata/android-ndk-r8d
# export ANDROID_NDK=$ANDROIDNDK_HOME
# export PATH=$PATH:${ANDROIDNDK_HOME}

###############################################################################
# OpenNI
###############################################################################
if [ -f ~/libraries/OpenNI-MacOSX-x64-2.2/OpenNIDevEnvironment ]; then
    source ~/libraries/OpenNI-MacOSX-x64-2.2/OpenNIDevEnvironment
    export DYLD_LIBRARY_PATH=$OPENNI2_REDIST:$DYLD_LIBRARY_PATH
fi

if [ -f ~/libraries/NiTE-MacOSX-x64-2.2/NiTEDevEnvironment ]; then
    source ~/libraries/NiTE-MacOSX-x64-2.2/NiTEDevEnvironment
    export DYLD_LIBRARY_PATH=$NITE2_REDIST64:$DYLD_LIBRARY_PATH
fi

###############################################################################
# python
###############################################################################
export PYTHON_LIBRARY=/usr/local/Cellar/python/2.7.5/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib
export PYTHON_INCLUDE_DIR=/usr/local/Cellar/python/2.7.5/Frameworks/Python.framework/Headers/
export PYTHONPATH=/usr/local/lib/python2.7/site-packages/

###############################################################################
# opencv
###############################################################################
export INCLUDE_PATH=/usr/local/opencv/include:$INCLUDE_PATH
export C_INCLUDE_PATH=$INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$INCLUDE_PATH
export PKG_CONFIG_PATH=/usr/local/opencv/lib/pkgconfig:$PKG_CONFIG_PATH
export DYLD_LIBRARY_PATH=/usr/local/opencv/lib:$DYLD_LIBRARY_PATH
export PYTHONPATH=$PYTHONPATH:/usr/local/opencv/lib/python2.7/site-packages/
export OpenCV_DIR=/usr/local/opencv

###############################################################################
# nvm
###############################################################################
[[ -s /Users/ogata/.nvm/nvm.sh ]] && . /Users/ogata/.nvm/nvm.sh


export MAKEFLAGS="-j 8"