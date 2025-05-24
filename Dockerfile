FROM rust:1.87.0

RUN  apt-get update \
  && apt-get install -y build-essential git curl wget clang \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN git clone https://github.com/zorp-corp/nockchain.git

WORKDIR nockchain

RUN sed -i "s|^export MINING_PUBKEY .=.*$|export MINING_PUBKEY ?= 2bNy4obgWt9wxvXRzjvVCkepWnFCefvLbxMectcUarpbWTcc8xB7izXQMRvg8S5m68RVV5HKeK1WgWWqvinzG7RPG8XajcYMQe75CxwLmFvfmTaYE4v8zjeYsEiQ9Dgxj2uR|" Makefile
RUN mv .env_example .env
RUN sed -i "s|^MINING_PUBKEY=.*$|MINING_PUBKEY=2bNy4obgWt9wxvXRzjvVCkepWnFCefvLbxMectcUarpbWTcc8xB7izXQMRvg8S5m68RVV5HKeK1WgWWqvinzG7RPG8XajcYMQe75CxwLmFvfmTaYE4v8zjeYsEiQ9Dgxj2uR|" .env

RUN make install-hoonc
RUN make build
RUN make install-nockchain-wallet
RUN make install-nockchain

CMD [ "make", "run-nockchain" ]
