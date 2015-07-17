#!/bin/sh

rm -f /tmp/antFus*

#23 participants:
blinds="s01_rescan s02 s03_rescan s05 s08 s11 s12 s13 s14 s16 s18 s19 s101 s104 s107 s108 s109 s110 s112 s113 s115 s118 s123"


for blind in $blinds; do 

   iresp=/data/backup/Florida/R21_AD/SUBJECTS/modernProcessing/MNI_1mm_redo/iresp_stim01.R21_${blind}modern1ML+orig.HEAD_warped.nii.gz
   ls -al $iresp
   
   for hem in LH RH; do

      clusterMask=/data/backup/Florida/R21_AD/SUBJECTS/modernProcessing/ROImasks/${blind}_AntFus_${hem}_bin.nii.gz
      ls -al $clusterMask
     
      # Create a sorted column of unique nonzero intensities present in the image:
      nzIntensitiesColumn=`3dmaskdump -quiet -noijk -nozero ${clusterMask} 2>/dev/null | sort -n | uniq`
      #echo "DEBUG nzIntensitiesColumn is $nzIntensitiesColumn"

      # ...replacing line breaks with commas:
      nzIntensitiesCsv=`echo ${nzIntensitiesColumn} | sed 's/\ /,/g'`
      #echo "nzIntensitiesCsv == ${nzIntensitiesCsv}"

      # ...replacing commas with spaces:
      nzIntensitiesSsv=`echo ${nzIntensitiesCsv} | sed 's/\,/\ /g'`
      echo "nzIntensitiesSsv == ${nzIntensitiesSsv}"

      if [ "$nzIntensitiesSsv" = "" ]; then 
         # if list of cluster intensities is empty create an empty file with descriptive name:
         echo "NO CLUSTERS FOUND!"
         touch /tmp/antFus-$blind-$hem-hasNoSuprathresholdClusters.txt
      else
         # ...otherwise clusters were found, so write their mean iresp values to a text file:
         for clusterID in $nzIntensitiesSsv; do
            echo "DEBUG clusterID is $clusterID"
            hrfOutput=/tmp/antFus-$blind-$hem-cluster${clusterID}-perTRirespItensityMeans.txt
            3dmaskave \
            -mask ${clusterMask} \
            -mrange ${clusterID} ${clusterID} \
            -quiet \
            ${iresp} > ${hrfOutput}
         done
      fi
   done
done

ls -al /tmp/antFus*
