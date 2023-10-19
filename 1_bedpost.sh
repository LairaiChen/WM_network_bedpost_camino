#!/bin/bash
cd $1


if [ ! -e DTI.bedpost/dyads3.nii.gz ]; then    
    # bedpost requires bvecs, bvals, data, nodif_brain_mask
    # Run bedpostx_datacheck in command line to check if your input directory contains the correct files required for bedpostx.
    rm -r DTI.bedpostX
    cp DTI/scan.bvec DTI/bvecs
    cp DTI/scan.bval DTI/bvals
    cp DTI/den_eddy.nii.gz DTI/data.nii.gz
    bedpostx_gpu DTI/. --nf=3 --fudge=1 --bi=3000 --model=1
fi

