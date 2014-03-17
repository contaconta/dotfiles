echo "linux env..."
export PATH=/usr/local/bin:$PATH

###############################################################################
# opencv
###############################################################################
export INCLUDE_PATH=/usr/local/opencv/include:$INCLUDE_PATH
export PKG_CONFIG_PATH=/usr/local/opencv/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=/usr/local/opencv/lib:$LD_LIBRARY_PATH
#export PYTHONPATH=$PYTHONPATH:/usr/local/opencv/lib/python2.7/site-packages/
export OpenCV_DIR=/usr/local/opencv
