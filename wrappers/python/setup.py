# -*- coding: utf-8 -*-
#
# @fileoverview Copyright (c) 2019-2020, Stefano Gualandi,
#                via Ferrata, 1, I-27100, Pavia, Italy
# 
#  @author stefano.gualandi@gmail.com (Stefano Gualandi)
# 


from distutils.core import setup, Extension

from Cython.Build import cythonize  


extensions = Extension("KWD", 
                       ["histogram2D.pyx", "KWD_Histogram2D.cpp"])

setup(name = 'Spatial-KWD',
       version = '0.1.0',
       description = 'Spatial KWD for Large Spatial Maps',
       author = 'Stefano Gualandi',
       author_email = 'stefano.gualandi@gmail.com',
       url = 'https://github.com/eurostat/Spatial-KWD',
       long_description = 
       '''
           Spatial Kantorovich-Wasserstein Distances (Spatial-KWD) for Large Spatial Maps
       ''',
       ext_modules = cythonize(extensions))
