#https://github.com/openscad/openscad-playground
FROM openscad/wasm-playground-base:latest AS builder

WORKDIR /app
# ENV HTTPS_PROXY=http://hope.asahi-kasei.co.jp:3128
# ENV HTTP_PROXY=http://hope.asahi-kasei.co.jp:3128
# ENV http_proxy=http://hope.asahi-kasei.co.jp:3128
# ENV https_proxy=http://hope.asahi-kasei.co.jp:3128

RUN apt update && apt install -y curl
RUN git clone https://github.com/openscad/openscad-playground.git
WORKDIR /app/openscad-playground
RUN make public 
RUN npm i
RUN npm run build


FROM nginx:latest

WORKDIR /app

# ビルド用の image から実行ファイルをコピー
COPY --from=builder /app/openscad-playground/dist /usr/share/nginx/html

EXPOSE 80

#docker build -t openscad-playground .
