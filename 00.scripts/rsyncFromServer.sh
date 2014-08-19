#!/bin/sh

# rsync relevant /data/birc/${site}/${proj}/ subdirectories from the server:

#for dir in 02.fmriTaskProgramming 03.FmriRegressors 04.Grants 05.Scripts 06.acqfiles 08.QC; do 
#   rsync -r --progress \
#   stowler@qball3.birc.emory.edu:/data/birc/Atlanta/OMT/${dir} \
#   /data/birc/Atlanta/OMT/
#done

#mkdir -p /data/birc/Florida/R21_AD/VBM/struc/
rsync -r --progress \
stowler@qball3.birc.emory.edu:/data/birc/Florida/R21_AD/VBM/struc/* \
/data/birc/Florida/R21_AD/VBM/struc/

# mkdir -p /data/birc/Florida/R21_AD/SUBJECTS/canonical/MNI_canonical
rsync -r --progress \
stowler@qball3.birc.emory.edu:/data/birc/Florida/R21_AD/SUBJECTS/canonical/MNI_canonical/*t1* \
/data/birc/Florida/R21_AD/SUBJECTS/canonical/MNI_canonical

