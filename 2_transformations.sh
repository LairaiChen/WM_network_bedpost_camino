#!/bin/bash
cd $1

# Creates transformations
if [ ! -d transform ]; then
    mkdir transform
fi

if [ ! -e transform/dti_to_t1.mat ]; then    
    # bedpost requires bvecs, bvals, data, nodif_brain_mask
    flirt -in DTI/nodif_brain.nii.gz -ref T1/t1_brain_unbiased.nii.gz -out DTI/nodif_brain_in_t1.nii.gz -omat transform/dti_to_t1.mat  -interp nearestneighbour
    convert_xfm -omat transform/t1_to_dti.mat -inverse transform/dti_to_t1.mat
    flirt -in T1/t1_brain_unbiased.nii.gz -ref /Lairai/templates/MNI152_T1_1mm_brain.nii -omat transform/t1_to_mni_affine.mat
fi

if [ ! -e transform/t1_to_mni_nonlinear_warp.nii.gz ]; then    
    # bedpost requires bvecs, bvals, data, nodif_brain_mask
    fnirt --ref=/Lairai/templates/MNI152_T1_1mm_brain.nii --in=T1/t1_brain_unbiased.nii.gz --aff=transform/t1_to_mni_affine.mat --cout=transform/t1_to_mni_nonlinear_warp
    invwarp --ref=T1/t1_brain_unbiased.nii.gz --warp=transform/t1_to_mni_nonlinear_warp.nii.gz --out=transform/mni_to_t1_nonlinear_warp
fi

# Apply transformations
if [ ! -e DTI/bna_in_dti.nii.gz ]; then    
    applywarp --ref=T1/t1_brain_unbiased.nii --in=/Lairai/templates/BN_Atlas_246_1mm.nii --warp=transform/mni_to_t1_nonlinear_warp.nii.gz --out=T1/bna_in_t1.nii.gz --interp=nn
    applywarp --ref=T1/t1_brain_unbiased.nii --in=/Lairai/templates/aal116_1MM.nii --warp=transform/mni_to_t1_nonlinear_warp.nii.gz --out=T1/aal_in_t1.nii.gz --interp=nn
    flirt -in T1/bna_in_t1.nii.gz -init transform/t1_to_dti.mat -ref DTI/nodif_brain.nii.gz -out DTI/bna_in_dti.nii.gz -applyxfm -interp nearestneighbour
    flirt -in T1/aal_in_t1.nii.gz -init transform/t1_to_dti.mat -ref DTI/nodif_brain.nii.gz -out DTI/aal_in_dti.nii.gz -applyxfm -interp nearestneighbour
    flirt -in T1/T1_brain_WM_mask.nii.gz  -init transform/t1_to_dti.mat -ref DTI/nodif_brain.nii.gz -out DTI/WM_to_dti.nii.gz -applyxfm -interp nearestneighbour
fi
