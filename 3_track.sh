#!/bin/bash
cd $1

if [ ! -d track ]; then
    mkdir track
fi

if [ ! -e track_bedpost_camino_post ]; then    
    track -inputmodel bedpostx_dyad -curvethresh 45 -curveinterval 5 -bedpostxminf 0.1 -header DTI/nodif_brain.nii.gz -seedfile DTI/WM_to_dti.nii.gz -bedpostxdir DTI.bedpostX -tracker rk4 -interpolator nn -stepsize 2 -outputfile track/track_bedpost_camino
    procstreamlines -inputfile track/track_bedpost_camino -mintractlength 20 -maxtractlength 250 -header DTI/nodif_brain.nii.gz > track/track_bedpost_camino_post
fi
