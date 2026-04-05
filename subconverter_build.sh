# 自己编译生成对应平台的subconverter程序
# 执行编译的过程，系统OS推荐： Debian 10 / Ubuntu 20.04
# 自己的海外VPS上面编译，可以减少异常
# 我的VPS只有1核心1GB内存，故而，略微修改了编译脚本
# https://github.com/MetaCubeX/subconverter.git
#  https://github.com/asdlokj1qpi233/subconverter/releases/download/v0.9.8/subconverter_linux64.tar.gz

apt-get update
apt-get install git
mkdir -p /root/src
cd /root/src
git clone https://github.com/tindy2013/subconverter.git
sed -i 's/j4/j1/g' /root/src/subconverter/scripts/build.alpine.release.sh
sed -i 's/j2/j1/g' /root/src/subconverter/scripts/build.alpine.release.sh
docker pull multiarch/alpine:amd64-latest-stable
docker run -v /root/src/subconverter:/root/workdir multiarch/alpine:amd64-latest-stable /bin/sh -c "apk add bash git nodejs npm && cd /root/workdir && chmod +x scripts/build.alpine.release.sh && bash scripts/build.alpine.release.sh"
