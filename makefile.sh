#!/bin/sh

# create files
cat hosts | grep -v '#' | grep -v -e '^[[:space:]]*$' | awk '{print $2}' >> tmp/domain.txt
cat hosts | grep -v '#' | grep -v -e '^[[:space:]]*$' | awk '{print "0 "$2}' >> tmp/hosts-iOS.tmp
cat filters/domain-adservers.txt | grep -v '!' | awk '{print "||"$1"^"}' >> tmp/adservers-rule.tmp
cat filters/domain-adservers-all.txt | grep -v '!' | awk '{print "||"$1"^"}' >> tmp/adservers-all-rule.tmp
cat filters/domain-adservers-all.txt | grep -v '!' | awk '{print "*"$1" = 0.0.0.0"}' >> tmp/adservers-config.tmp

# make time stamp update
TIME_STAMP=`date +'%d %b %Y %H:%M'`
sed -e "s/_time_stamp_/$TIME_STAMP/g" tmp/title-adserver.txt > tmp/title-adserver.tmp
sed -e "s/_time_stamp_/$TIME_STAMP/g" tmp/title-adserver-all.txt > tmp/title-adserver-all.tmp
sed -e "s/_time_stamp_/$TIME_STAMP/g" tmp/title-hosts-iOS.txt > tmp/title-hosts-iOS.tmp

# add to files
cat tmp/title-hosts-iOS.tmp tmp/hosts-iOS.tmp > option/hosts-iOS
cat tmp/title-adserver.tmp tmp/adservers-rule.tmp > filters/adservers.txt
cat tmp/title-adserver-all.tmp tmp/adservers-all-rule.tmp > filters/adservers-all.txt
cat tmp/title-config-surge.txt tmp/adservers-config.tmp > option/hostsVN.conf
cat tmp/title-config-quantumult.txt tmp/adservers-config.tmp > option/hostsVN-quantumult.conf

# move files
mv tmp/domain.txt option/

# remove tmp file
rm -rf tmp/*.tmp
