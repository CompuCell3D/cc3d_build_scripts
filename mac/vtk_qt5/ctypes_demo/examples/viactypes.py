import os.path
from ctypes import *

me = os.path.abspath(os.path.dirname(__file__))
lib = cdll.LoadLibrary(os.path.join(me, "..", "libtest.so"))

func = lib.test_get_data_nulls
func.restype = POINTER(c_char)
func.argtypes = [POINTER(c_int)]

l = c_int()
data = func(byref(l))

print data,l,data.contents

lib.test_data_print(data,l)

func_out = lib.test_get_data_nulls_out
func_out.argtypes = [POINTER(POINTER(c_char)), POINTER(c_int)]
func.restype = None

l2 = c_int()
data2 = POINTER(c_char)()
func_out(byref(data2), byref(l2))

print data2,l2,data2.contents

lib.test_data_print(data2,l2)

print "equal ", data[0]==data2[0], data[1]==data2[1], data[2]==data2[2], data[3]==data2[3], data[4]==data2[4]

func = lib.test_get_fixed_array_size_2
func_out.argtypes = [POINTER(c_double)]
func.restype = None

data = (c_double * 2)()
func(data)
x,y = data
print "array ", x,y
