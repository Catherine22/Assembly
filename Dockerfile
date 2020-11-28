FROM centos:centos7

WORKDIR /app
RUN yum update -y

# Install wget & development tools
RUN yum groupinstall "Development Tools" -y
RUN yum install wget -y

# Install vim
WORKDIR /app
RUN yum install gcc make ncurses ncurses-devel -y
RUN yum install -y ctags git tcl-devel \
    ruby ruby-devel \
    lua lua-devel \
    luajit luajit-devel \
    python python-devel \
    perl perl-devel \
    perl-ExtUtils-ParseXS \
    perl-ExtUtils-XSpp \
    perl-ExtUtils-CBuilder \
    perl-ExtUtils-Embed
RUN git clone https://github.com/vim/vim.git
WORKDIR /app/vim
RUN ./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp \
    --enable-pythoninterp \
    --enable-perlinterp \
    --enable-luainterp
RUN make
RUN make install

# Install gcc
WORKDIR /app
RUN curl -O https://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.gz
RUN tar xzf gcc-7.3.0.tar.gz
WORKDIR /app/gcc-7.3.0
RUN ./contrib/download_prerequisites
WORKDIR /app/gcc-build
RUN ../gcc-7.3.0/configure                           \
    --enable-shared                                  \
    --enable-threads=posix                           \
    --enable-__cxa_atexit                            \
    --enable-clocale=gnu                             \
    --disable-multilib                               \
    --enable-languages=all
RUN make
RUN make install
RUN gcc --version

# Install nasm
RUN yum install nasm -y
RUN nasm -v

RUN cd /app/src
CMD ["/bin/bash"]

