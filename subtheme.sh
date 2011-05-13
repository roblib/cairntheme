#!/bin/bash

dir=/var/aegir/platforms/drupal-6.20/sites/all/themes/cairntheme
user=kgbulman
group=webdevelopers

# Get name of new multisite
echo -n "Enter name of new subtheme: "
read sub

# Get the replacement colour codes for the new theme

echo -n "Enter the primary colour in HEX (red text and links on UPEI): "
read red

echo -n "Enter the secondary colour in HEX (gold navbar on UPEI): "
read gold

echo -n "Enter the secondary gradient colour in HEX (choose a lighter color - http://www.colorzilla.com/gradient-editor/ ): "
read goldgradient

echo -n "Enter the third replacement colour (green highlights on UPEI): "
read green

# Stripout any dashes in new name
sub2=`echo $sub | sed 's/\-//'`

# Create new theme dir and copy Zen starterkit into it
cp -R $dir/starterkit  $dir/$sub2

# Rename starterkit files and find/replace starterkit with new subtheme name in all the files
mv $dir/$sub2/starterkit.info.txt $dir/$sub2/$sub2.info
mv $dir/$sub2/css/starterkit.css $dir/$sub2/css/$sub2.css
cd $dir/$sub2/
chown -R $user:$group $dir/$sub2

sed -i "s/starterkit/$sub2/g" $dir/$sub2/template.php
sed -i "s/starterkit/$sub2/g" $dir/$sub2/theme-settings.php
sed -i "s/starterkit/$sub2/g" $dir/$sub2/$sub2.info

# Replace the colour codes in css/<theme>.css
sed -i "s/8B1F04/$red/g" $dir/$sub2/css/$sub2.css
sed -i "s/F5AE30/$gold/g" $dir/$sub2/css/$sub2.css
sed -i "s/F4DAAD/$goldgradient/g" $dir/$sub2/css/$sub2.css
sed -i "s/6B6F2A/$green/g" $dir/$sub2/css/$sub2.css
