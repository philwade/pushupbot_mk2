# For building releases!
FROM centos:7

# FROM erlang:19
ENV OTP_VERSION="21.1.3"
ENV ELIXIR_VERSION="1.7.3"
ENV REBAR_VERSION="2.6.1"
ENV REBAR3_VERSION="3.7.4"
ENV LANG="en_US.UTF-8"

RUN set -xe \
    && yum -y groupinstall "Development Tools" \
    && yum -y install ncurses \
        ncurses-devel \
        unixODBC \
        unixODBC-devel \
        openssl-devel \
    && OTP_SRC_URL="https://github.com/erlang/otp/archive/OTP-$OTP_VERSION.tar.gz" \
	&& OTP_SRC_SUM="9a447e1debed355ff78f5d502dc8259139d5aed2362037e7cca9dc9919245eca" \
    && curl -fSL "$OTP_SRC_URL" -o otp-src.tar.gz \
    && echo "${OTP_SRC_SUM}  otp-src.tar.gz" | sha256sum -c - \
    && mkdir -p /usr/src/otp-src \
    && tar -zxf otp-src.tar.gz -C /usr/src/otp-src --strip-components=1 \
    && rm otp-src.tar.gz \
    && cd /usr/src/otp-src \
    && ./otp_build autoconf \
    && ./configure \
    && make \
    && make install \
    && find /usr/local -name examples | xargs rm -rf \
    && cd /usr/src \
    && rm -rf /usr/src/otp-src

CMD ["erl"]

RUN set -xe \
    && REBAR_SRC_URL="https://github.com/rebar/rebar/archive/${REBAR_VERSION##*@}.tar.gz" \
    && REBAR_SRC_SUM="aed933d4e60c4f11e0771ccdb4434cccdb9a71cf8b1363d17aaf863988b3ff60" \
    && mkdir -p /usr/src/rebar-src \
    && curl -fSL "$REBAR_SRC_URL" -o rebar-src.tar.gz \
    && echo "${REBAR_SRC_SUM}  rebar-src.tar.gz" | sha256sum -c - \
    && tar -zxf rebar-src.tar.gz -C /usr/src/rebar-src --strip-components=1 \
    && rm rebar-src.tar.gz \
    && cd /usr/src/rebar-src \
    && ./bootstrap \
    && install -v ./rebar /usr/local/bin \
    && cd /usr/src \
    && rm -rf /usr/src/rebar-src

RUN set -xe \
    && REBAR3_SRC_URL="https://github.com/erlang/rebar3/archive/${REBAR3_VERSION##*@}.tar.gz" \
    && REBAR3_SRC_SUM="3747ef351999caec65304839ecd9324ac8eec8c38210fb43dc598e3caed0a2c0" \
    && mkdir -p /usr/src/rebar3-src \
    && curl -fSL "$REBAR3_SRC_URL" -o rebar3-src.tar.gz \
    && echo "${REBAR3_SRC_SUM}  rebar3-src.tar.gz" | sha256sum -c - \
    && tar -zxf rebar3-src.tar.gz -C /usr/src/rebar3-src --strip-components=1 \
    && rm rebar3-src.tar.gz \
    && cd /usr/src/rebar3-src \
    && HOME=$PWD ./bootstrap \
    && install -v ./rebar3 /usr/local/bin \
    && cd /usr/src \
    && rm -rf /usr/src/rebar3-src

RUN set -xe \
    && ELIXIR_SRC_URL="https://github.com/elixir-lang/elixir/archive/v$ELIXIR_VERSION.tar.gz" \
    && ELIXIR_SRC_SUM="c9beabd05e820ee83a56610cf2af3f34acf3b445c8fabdbe98894c886d2aa28e" \
    && curl -fSL "$ELIXIR_SRC_URL" -o elixir.tar.gz \
    && echo "${ELIXIR_SRC_SUM}  elixir.tar.gz" | sha256sum -c - \
    && mkdir -p /usr/src/elixir-src \
    && tar -zxf elixir.tar.gz -C /usr/src/elixir-src --strip-components=1 \
    && rm -f elixir.tar.gz \
    && cd /usr/src/elixir-src \
    && make install \
    && cd / \
    && rm -rf /usr/src/elixir-src \
    && mix local.hex --force \
	&& mix hex.info \
	&& mix local.rebar --force

ENV MIX_ENV prod
ADD /app /app
WORKDIR app

RUN mix deps.get

CMD ["bash"]
