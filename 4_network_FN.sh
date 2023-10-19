#!/bin/bash
cd $1

if [ ! -e track/csv_FN_aal_116_sc.csv ]; then    
    conmat -inputfile  track/track_bedpost_camino_post -targetfile DTI/aal_in_dti.nii.gz -outputroot track/csv_FN_aal_116_
fi

if [ ! -e track/csv_FN_bna_246_sc.csv ]; then    
    conmat -inputfile  track/track_bedpost_camino_post -targetfile DTI/bna_in_dti.nii.gz -outputroot track/csv_FN_bna_246_
fi
