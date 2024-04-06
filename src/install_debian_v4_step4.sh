#!/bin/bash
# vim: ff=unix

# install google perftools (sd uses this avoid tcmalloc message)
sudo apt install google-perftools -y

#
# create doit.sh & civitai.sh getter
#
mkdir ~/downloads 

cat <<EOF >~/run.sh
#!/bin/bash
./webui.sh --listen
EOF
cat <<EOF >~/get-civitai-link.sh
#!/bin/bash

# your own civitai AI-token
CTOK=00be61abcfc1ddb1a55e4c0000000000

cd ~/downloads
echo wget \$1 --content-disposition
if [[ \$1 == *"?"* ]]; then
    wget \$1&token=\$CTOK --content-disposition
else
    wget \$1?token=\$CTOK --content-disposition
fi
pwd
ls -l
EOF

cat <<EOF >~/get-essentials.sh
#!/bin/bash
MODELSDIR=~/stable-diffusion-webui/models
wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors -O \$MODELSDIR/sd_xl_base_1.0.safetensors
wget https://huggingface.co/stabilityai/sd-vae-ft-ema-original/resolve/main/vae-ft-ema-560000-ema-pruned.ckpt -O \$MODELSDIR/VAE/vae-ft-ema-560000-ema-pruned.ckpt
wget https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.ckpt -O \$MODELSDIR/VAE/vae-ft-mse-840000-ema-pruned.ckpt
echo Got SDXL10 and VAEs
EOF

chmod 755 ~/*.sh


#
# get stable diffusion AUTOMATIC1111 and run it first time to configure
#
wget https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh
chmod 755 webui.sh
./webui.sh --listen

^C # terminate first run

