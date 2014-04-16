#!/bin/sh

# per 20140408 stowler conference call w/ Amanda and Kristen:
# (follow-up to 20140402 stowler/crosson conference call w/ Amanda)
#
# 1) Their highest quality brian extractions were:
#    	/data/birc/Florida/R21_AD/SUBJECTS/canonical/MNI_canonical/R21_${participant}*canonical_t1_brain.nii.gz
# ...which were created from:
#    /data/birc/Florida/R21_AD/SUBJECTS/canonical/MNI_canonical/R21_${participant}*canonical_t1.nii.gz
# ...using unknown bet parameters (they were working from the bet gui)
#
# 2) Per my comparison, the images that served as their inputs to VBM weren't
# those skull-stripped images, but instead inferior brain extractions that
# probably came from fslvbm_1_bet -b (see 20120229 .fslvbmlog):
#    /data/birc/Florida/R21_AD/VBM/struc/*${participant}*_brain.nii.gz , e.g.
#    /data/birc/Florida/R21_AD/VBM/struc/HC_R21_s18modern1ML_t1_struc_brain.nii.gz
#    
#
# 3) Other .fslvbmlog indicates 20100311 extraction of s02 with "fslvbm_1_bet
# -N -f .2 -g -.1". Amanda and Kristen believe this was Michelle and that
# method was not used in Amanda's existing diss data.
#
#
# 201404 brain extractions by stowler:
# - getting good results with bet -B -f [around .20]
# - note that the -B option is bet variation=7, which does this:
#
#		  elif [ $variation = 7 ] ; then
#		      # {{{ SIENA bias field & neck cleanup
#		  
#		  #### run betpremask
#		  ${FSLDIR}/bin/standard_space_roi $IN ${OUT}_tmp_premask -b -d
#		   
#		  #### run FAST to get bias field
#		  ${FSLDIR}/bin/fast -b ${OUT}_tmp_premask >/dev/null 2>&1
#		   
#		  #### apply bias correction to original
#		  ${FSLDIR}/bin/fslmaths $IN -div ${OUT}_tmp_premask_bias ${OUT}_tmp_unbiased
#		   
#		  #### get skull if asked for
#		  if [ $skull ] ; then
#		    ${FSLDIR}/bin/standard_space_roi ${OUT}_tmp_unbiased ${OUT}_tmp_unbiased_forskull_reduced -maskFOV -roiNONE -d
#		    ${FSLDIR}/bin/bet2 ${OUT}_tmp_unbiased_forskull_reduced ${OUT}_tmp_unbiased_forskull $bet2opts
#		    bet2opts=`echo $bet2opts | sed 's/-s//g'`
#		    ${FSLDIR}/bin/immv ${OUT}_tmp_unbiased_forskull_skull ${OUT}_skull
#		  fi
#		  
#		  #### re-run betpremask
#		  ${FSLDIR}/bin/standard_space_roi ${OUT}_tmp_unbiased ${OUT}_tmp_unbiased_premask -b -d
#		   
#		  #### re-run in robust mode
#		  ${FSLDIR}/bin/bet ${OUT}_tmp_unbiased_premask $OUT -m $bet2opts -R -d
 

# parentDir of existing data:
parentDirLegacy=/data/birc/Florida/R21_AD/

# specify participant ID from first commandline argument:
participant=$1

# interactively view native-space legacy images for assessment of legacy brain extraction:
# 	green: 		whole-head T1
# 	red: 		legacy best extraction
# 	blue:		legacy VBM input 

fslview \
${parentDirLegacy}/SUBJECTS/canonical/MNI_canonical/R21_${participant}*canonical_t1.nii.gz \
-l Green \
${parentDirLegacy}/SUBJECTS/canonical/MNI_canonical/R21_${participant}*canonical_t1_brain.nii.gz \
-l Red \
${parentDirLegacy}/VBM/struc/*${participant}*_brain.nii.gz \
-l Blue &

