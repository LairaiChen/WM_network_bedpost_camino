import os, sys

path_qc = '/media/shulab/dxy_xuanwu/Lairai/Gulou/QC'
path_input = '/media/shulab/dxy_xuanwu/Lairai/Gulou/test/'

# Check bet
# images_list = []
# for ele in sorted(os.listdir(path_input)):
#     images_list.append(path_input+ele+'/T1/t1_brain.nii.gz')
# images_check = ' '.join(images_list)
# path_check = path_qc+'/bet'
# #os.mkdir(path_check)
# os.chdir(path_check)
# os.system('slicesdir ' + images_check)

# Check registration of aal
images_list = []
for ele in sorted(os.listdir(path_input)):
    images_list.append(path_input+ele+'/DTI/aal_in_dti.nii.gz')
    images_list.append(path_input+ele+'/DTI/nodif_brain.nii.gz')
images_check = ' '.join(images_list)
path_check = path_qc+'/trans_aal'
os.mkdir(path_check)
os.chdir(path_check)
os.system('slicesdir -o ' + images_check)

# Check registration of bna
images_list = []
for ele in sorted(os.listdir(path_input)):
    images_list.append(path_input+ele+'/DTI/bna_in_dti.nii.gz')
    images_list.append(path_input+ele+'/DTI/nodif_brain.nii.gz')
images_check = ' '.join(images_list)
path_check = path_qc+'/trans_bna'
os.mkdir(path_check)
os.chdir(path_check)
os.system('slicesdir -o ' + images_check)