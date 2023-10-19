#!/bin/bash
cd $1

# Creates FA maps
if [ ! -e DTI/fa.nii.gz ]; then    
    mrconvert DTI/den_eddy.nii.gz DTI/data_preprocessed.mif -fslgrad DTI/bvecs DTI/bvals
    dwi2tensor DTI/data_preprocessed.mif DTI/tensor.mif
    tensor2metric -fa DTI/fa.nii.gz DTI/tensor.mif
    conmat -inputfile track/track_bedpost_camino_post  -targetfile DTI/aal_in_dti.nii.gz -scalarfile DTI/fa.nii.gz -tractstat mean -outputroot track/csv_FA_aal_116_
    conmat -inputfile track/track_bedpost_camino_post  -targetfile DTI/bna_in_dti.nii.gz -scalarfile DTI/fa.nii.gz -tractstat mean -outputroot track/csv_FA_bna_246_
fi