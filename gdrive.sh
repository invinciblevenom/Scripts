#
#Doesn't work anymore. Try Mega or AFH.
#

echo -e "Setting Up Google Drive Client"
cd ~
wget https://docs.google.com/uc?id=0B3X9GlR6EmbnWksyTEtCM0VfaFE&export=download
mv uc\?id\=0B3X9GlR6EmbnWksyTEtCM0VfaFE gdrive
chmod +x gdrive
sudo install gdrive /usr/local/bin/gdrive
echo -e "Get Ready To Connect Your Gdrive Account"
gdrive list
