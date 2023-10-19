#!/bin/bash
cd $1

# Preprocessing T1WI
if [ ! -e T1/t1_brain.nii.gz ]; then
    robustfov -i T1/data_raw.nii -r T1/t1_crop.nii.gz
    bet T1/t1_crop.nii.gz T1/t1_brain.nii.gz -f 0.2 
fi

if [ ! -e T1/fast_t1_brain_pve_0.nii.gz ]; then    
    fast -t 1 -b -o T1/fast_t1_brain T1/t1_brain.nii.gz 
    fslmaths T1/fast_t1_brain_pve_0.nii.gz -thr 0.5 -bin T1/T1_brain_CSF_mask.nii.gz
    fslmaths T1/fast_t1_brain_pve_1.nii.gz -thr 0.5 -bin T1/T1_brain_GM_mask.nii.gz
    fslmaths T1/fast_t1_brain_pve_2.nii.gz -thr 0.5 -bin T1/T1_brain_WM_mask.nii.gz
    fslmaths T1/t1_crop.nii.gz -div T1/fast_t1_brain_bias.nii.gz T1/t1_unbiased.nii.gz
    fslmaths T1/t1_brain.nii.gz -div T1/fast_t1_brain_bias.nii.gz T1/t1_brain_unbiased.nii.gz
fi

# Preprocessing d-MRI
if [ ! -e DTI/data_denoised.nii ]; then    
    dwidenoise DTI/data_raw.nii DTI/data_denoised.nii
fi

if [ ! -e DTI/nodif_brain.nii.gz ]; then    
    fslroi DTI/data_denoised.nii DTI/nodif_raw.nii.gz 0 1
    bet DTI/nodif_raw.nii.gz DTI/nodif_brain.nii.gz -f 0.2 -m
fi

if [ ! -e den_eddy.nii.gz ]; then    
    eddy_openmp --imain=DTI/data_denoised.nii --mask=DTI/nodif_brain_mask.nii.gz --bvals=DTI/scan.bval --bvecs=DTI/scan.bvec --acqp=/media/shulab/dxy_xuanwu/Lairai/Gulou/acqparams.txt --index=/media/shulab/dxy_xuanwu/Lairai/Gulou/index.txt --out=DTI/den_eddy --ref_scan_no=0 --ol_nstd=4
fi