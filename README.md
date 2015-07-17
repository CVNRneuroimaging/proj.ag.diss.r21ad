proj.ag.diss.r21ad
=====

work supporting AG dissertation work on R21AD

20150717
===========
Extracted per-cluster HRFs from suprathreshold clusters in anterior fusiform
gyrus and emailed to Amanda.

20150316
===========
Amanda confirmed the scripts used to produce her existing data.

Scripts to create per-participant suprathreshold "posterior perisylvian ROIs",
but visual inspection confirms these are actually ITL (two identical scripts,
both dated 20111209) :

/data/birc/Florida/R21_AD/SUBJECTS/modernProcessing/sh.R21_ClustMask16_posteriorPerisylvian_LH
/data/birc/Florida/R21_AD/SUBJECTS/modernProcessing/Scripts/ROI_ClustMasks/sh.R21_ClustMask16_posteriorPerisylvian_LH

```
for sub in s01_rescan s02 s03_rescan s05 s08 s11 s12 s13 s14 s16 s18 s19 s101 s104 s107 s108 s109 s110 s112 s113 s115 s118 s123; do

   cd /data/birc/RESEARCH/R21_AD/SUBJECTS/modernProcessing/MNI_1mm_redo
   3dcalc \
   -prefix /data/birc/RESEARCH/R21_AD/SUBJECTS/modernProcessing/ROImasks/${sub}_posteriorPerisylvian_LH_bin.nii.gz \
   -a ${sub}Clust16_mask+tlrc.HEAD \
   -b /data/birc/RESEARCH/R21_AD/GROUP_ANALYSIS/R21_posteriorPerisylvian_LH_bin.nii.gz \
   -expr 'a*b'

done
```



Scripts to create per-participant suprathreshold IPL masks, which we confirmed
is perisylvian per visual inspection:

/data/birc/Florida/R21_AD/SUBJECTS/modernProcessing/sh.R21_ClustMask16_IPL_LH
/data/birc/Florida/R21_AD/SUBJECTS/modernProcessing/Scripts/ROI_ClustMasks/sh.R21_ClustMask16_IPL_LH

```
for sub in s01_rescan s02 s03_rescan s05 s08 s11 s12 s13 s14 s16 s18 s19 s101 s104 s107 s108 s109 s110 s112 s113 s115 s118 s123; do

   cd /data/birc/RESEARCH/R21_AD/SUBJECTS/modernProcessing/MNI_1mm_redo
   3dcalc \
   -prefix /data/birc/RESEARCH/R21_AD/SUBJECTS/modernProcessing/ROImasks/${sub}_IPL_LH_bin.nii.gz \
   -a ${sub}Clust16_mask+tlrc.HEAD \
   -b /data/birc/RESEARCH/R21_AD/GROUP_ANALYSIS/R21_IPL_LH_bin.nii.gz \
   -expr 'a*b'

done
```

Those suprathreshold intersections were used in interactive command-line 3droistats calls to produce stdout results that amgar and kristen manually copied into SPSS.
