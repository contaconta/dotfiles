# setup
# http://qiita.com/yn-misaki/items/3ec0605cba228a7d5c9a
export SETUP_INSTALL_DIR="${HOME}/install"

function setup_first () {
    sudo apt-get update
    sudo apt-get install -y git zsh curl tmux mosh zip language-pack-ja
    if [ ! "`echo $SHELL`" = "/usr/bin/zsh" ]; then
        chsh -s /usr/bin/zsh
    fi

        export ZPLUG_HOME=${HOME}/.zplug
    if [ ! -e $ZPLUG_HOME ]; then
            git clone https://github.com/zplug/zplug $ZPLUG_HOME
    fi

    if [ ! -e ${HOME}/dotfiles ]; then
        cd ${HOME}
        git clone https://github.com/contaconta/dotfiles.git
        cd ${HOME}/dotfiles
        zsh install.sh
        echo "source ${HOME}/dotfiles/init.zsh" >> ~/.zshrc
    fi
}

function install_neovim () {
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install -y neovim
}

function install_pyenv () {
    export ZSHRC_FILENAME="$HOME/.zshrc"
    if [ ! -e ${HOME}/.pyenv ]; then
        git clone https://github.com/yyuu/pyenv.git ${HOME}/.pyenv
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $ZSHRC_FILENAME
        echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $ZSHRC_FILENAME
        echo 'eval "$(pyenv init -)"' >> $ZSHRC_FILENAME
    fi
    source $ZSHRC_FILENAME
}

function install_python_packages () {
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils
    sudo apt-get install -y libopenblas-base
    sudo apt-get install -y tk-dev

    # install python by using pyenv
    export PYENV_PYTHON_VERSION="3.6.1"
    env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install $PYENV_PYTHON_VERSION
    pyenv global $PYENV_PYTHON_VERSION

    pip install --upgrade pip
    pip install numpy scipy scikit-learn
    pip install jupyter
    pip install tqdm click
    pip install matplotlib scikit-image toolz
    pip install glances
}

function install_opencv() {
    sudo apt-get install -y libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libtheora-dev \
        libvorbis-dev \
        libxvidcore-dev \
        libx264-dev \
        libopencore-amrnb-dev \
        libopencore-amrwb-dev \
        libopenexr-dev \
        libgstreamer-plugins-base1.0-dev \
        libavcodec-dev \
        libavutil-dev \
        libavfilter-dev \
        libavformat-dev \
        libavresample-dev
    git clone https://github.com/opencv/opencv.git
    mkdir opencv/build
    echo 'set(PYTHON_DEFAULT_EXECUTABLE "${PYTHON3_EXECUTABLE}")' >> opencv/cmake/OpenCVDetectPython.cmake
    cd opencv/build
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D BUILD_EXAMPLES=OFF \
      -D BUILD_opencv_python2=OFF \
      -D BUILD_opencv_python3=ON \
      -D WITH_FFMPEG=ON \
      -D WITH_CUDA=OFF \
      -D WITH_GTK=ON \
      -D WITH_VTK=OFF \
      -D BUILD_opencv_ml=OFF \
      -D BUILD_opencv_dnn=OFF \
      -D BUILD_opencv_objdetect=OFF \
      -D BUILD_opencv_photo=OFF \
      -D BUILD_opencv_dnn=OFF \
      -D BUILD_opencv_shape=OFF \
      -D BUILD_opencv_ts=OFF \
      -D BUILD_opencv_stitching=OFF \
      -D BUILD_opencv_superres=OFF \
      -D BUILD_opencv_java_bindings_generator=OFF \
      -D INSTALL_TESTS=OFF \
      -D BUILD_EXAMPLES=OFF \
      -D PYTHON3_EXECUTABLE=/home/ubuntu/.pyenv/shims/python \
      -D PYTHON3_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
      -D PYTHON3_NUMPY_INCLUDE_DIRS=$(python -c "import numpy; print(numpy.get_include())") \
      -D PYTHON3_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
      -D PYTHON3_LIBRARY=/home/ubuntu/.pyenv/versions/3.6.1/lib/libpython3.6m.so ..
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D BUILD_EXAMPLES=OFF \
        -D BUILD_opencv_python2=OFF \
        -D BUILD_opencv_python3=ON \
        -D WITH_FFMPEG=ON \
        -D WITH_CUDA=OFF \
        -D WITH_GTK=ON \
        -D WITH_VTK=OFF \
        -D INSTALL_TESTS=OFF \
        -D BUILD_EXAMPLES=OFF \
        .. && make all -j4 && sudo make install && rm -rf opencv
}

function install_cmake () {
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository ppa:george-edison55/cmake-3.x
    sudo apt-get update
    sudo apt-get install -y cmake
}

function install_docker () {
    curl -sSL https://get.docker.com/ | sh
}

#setup_first
#install_neovim
#install_pyenv
#install_python_packages
#install_cmake
#install_docker
install_opencv