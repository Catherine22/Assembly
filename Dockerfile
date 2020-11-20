FROM centos:centos7

WORKDIR /app
RUN yum update -y
RUN yum groupinstall "Development Tools" -y
RUN yum install wget -y
RUN yum install nasm -y
RUN curl -O https://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.gz
RUN tar xzf gcc-7.3.0.tar.gz
WORKDIR /app/gcc-7.3.0
RUN ./contrib/download_prerequisites
RUN nasm -v

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
RUN yum list installed | grep –i vim
RUN yum remove vim-enhanced vim-common vim-filesystem
RUN git clone https://github.com/vim/vim.git
RUN cd vim
RUN ./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp \
    --enable-pythoninterp \
    --enable-perlinterp \
    --enable-luainterp
RUN make
RUN make install


RUN gcc --version
CMD ["/bin/bash"]

