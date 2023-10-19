import os, sys, concurrent.futures

WORKER_NUM = 10

path_script = 'XXX.sh' # Executing shell scripts
path_data = '...' # A folder contains sub-folders of sub001, sub002, ...

def function_for_each_element(ele):
    # Defines your function here
    os.system(path_script + ' ' + path_data + '/' + ele)

element_list = os.listdir(path_data)

with concurrent.futures.ProcessPoolExecutor(max_workers=WORKER_NUM) as executor:
    executor.map(function_for_each_element, element_list)