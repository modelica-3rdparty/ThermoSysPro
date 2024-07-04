#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul  3 11:12:17 2024

@author: j74082
"""
import os 

from ModifAuto_BlockVsFunction import process_input, current_dir, where_TSP

where_Fluid_original_comp=os.path.join(current_dir, "Fluid_original")	#To be modified for each user

def list_all_files(base_path):
    res=[]
    for path in os.listdir(base_path):
        path_toExplore=os.path.join(base_path, path)
        # check if current path is a file
        if os.path.isfile(path_toExplore):
            if path_toExplore.endswith('.mo'):
                res.append(path_toExplore)
            else: #other file such as .order
                res.append(path_toExplore)  #In the end I also take the other files so that there are copied too (for .order files)
            
        else:
            res+=list_all_files(path_toExplore)
    return res

def PropFluid_inFile(path,path_to_write):
    f = open(path).read()
    process_input(f,make_changes=True,path_to_write=path_to_write)

ex=['/home/j74082/Documents/EDF/Modeli/ModifTSP/ThermoSysPro_BlockVsFunction/ThermoSysPro/ThermoSysPro/Fluid/Volumes/VolumeC.mo', '/home/j74082/Documents/EDF/Modeli/ModifTSP/ThermoSysPro_BlockVsFunction/ThermoSysPro/ThermoSysPro/Fluid/Volumes/VolumeITh.mo', '/home/j74082/Documents/EDF/Modeli/ModifTSP/ThermoSysPro_BlockVsFunction/ThermoSysPro/ThermoSysPro/Fluid/Volumes/TwoPhaseCavity.mo', '/home/j74082/Documents/EDF/Modeli/ModifTSP/ThermoSysPro_BlockVsFunction/ThermoSysPro/ThermoSysPro/Fluid/Volumes/VolumeDTh.mo', '/home/j74082/Documents/EDF/Modeli/ModifTSP/ThermoSysPro_BlockVsFunction/ThermoSysPro/ThermoSysPro/Fluid/Volumes/TwoPhaseVolume.mo', '/home/j74082/Documents/EDF/Modeli/ModifTSP/ThermoSysPro_BlockVsFunction/ThermoSysPro/ThermoSysPro/Fluid/Volumes/Pressurizer.mo', '/home/j74082/Documents/EDF/Modeli/ModifTSP/ThermoSysPro_BlockVsFunction/ThermoSysPro/ThermoSysPro/Fluid/Volumes/package.mo', '/home/j74082/Documents/EDF/Modeli/ModifTSP/ThermoSysPro_BlockVsFunction/ThermoSysPro/ThermoSysPro/Fluid/Volumes/VolumeB.mo', '/home/j74082/Documents/EDF/Modeli/ModifTSP/ThermoSysPro_BlockVsFunction/ThermoSysPro/ThermoSysPro/Fluid/Volumes/Tank.mo']
one_path='/home/j74082/Documents/EDF/Modeli/ModifTSP/ThermoSysPro_BlockVsFunction/Fluid_original/PressureLosses/ControlValve.mo'
for file in list_all_files(where_Fluid_original_comp):
    print("FILE IS: ",file)
    PropFluid_inFile(file,file.replace("Fluid_original","Fluid_modified"))
    
# PropFluid_inFile(one_path,one_path.replace("Fluid_original","Fluid_modified"))
# print(list_all_files(where_Fluid_comp))
